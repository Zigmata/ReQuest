import logging
import traceback
from typing import Tuple

from titlecase import titlecase

from ReQuest.utilities.constants import CurrencyFields, CommonFields

logger = logging.getLogger(__name__)

__all__ = [
    'find_currency_or_denomination',
    'normalize_currency_keys',
    'format_currency_display',
    'get_denomination_map',
    'check_sufficient_funds',
    'get_base_currency_info',
    'consolidate_currency_totals',
    'format_consolidated_totals',
    'format_currency_amount',
    'format_price_string',
    'format_complex_cost',
]


def find_currency_or_denomination(currency_def_query, search_name) -> Tuple[str | None, str | None]:
    """
    Finds a currency or denomination by name in the currency definition.

    :param currency_def_query: The server's currency definition dict
    :param search_name: The name of the currency or denomination to search for

    :return: A tuple containing:
                - The found currency or denomination name, or None if not found
                - The parent currency name, or None if not found
    """
    if not currency_def_query:
        return None, None
    search_name = search_name.lower()
    for currency in currency_def_query[CurrencyFields.CURRENCIES]:
        if currency[CommonFields.NAME].lower() == search_name:
            return currency[CommonFields.NAME], currency[CommonFields.NAME]
        if CurrencyFields.DENOMINATIONS in currency:
            for denomination in currency[CurrencyFields.DENOMINATIONS]:
                if denomination[CommonFields.NAME].lower() == search_name:
                    return denomination[CommonFields.NAME], currency[CommonFields.NAME]
    return None, None


def normalize_currency_keys(currency_dict):
    return {k.lower(): v for k, v in currency_dict.items()}


def format_currency_display(player_currency: dict, currency_config: dict) -> list[str]:
    """
    Formats currency into a list of strings based on the server's currency configuration
    (double vs integer).

    :param player_currency: The player's currency dict
    :param currency_config: The server's currency config dict

    :return: A list of formatted currency strings
    """
    if not player_currency or not currency_config or CurrencyFields.CURRENCIES not in currency_config:
        return []

    output_lines = []
    norm_player_wallet = normalize_currency_keys(player_currency)

    for currency in currency_config[CurrencyFields.CURRENCIES]:
        base_name = currency[CommonFields.NAME]
        denomination_map, _ = get_denomination_map(currency_config, base_name)

        if not denomination_map:
            continue

        denominations_in_wallet = {k for k in norm_player_wallet if k in denomination_map}
        if not denominations_in_wallet:
            continue

        # Display as double
        if currency.get(CurrencyFields.IS_DOUBLE, False):
            total_value = 0.0
            for denom_name_lower in denominations_in_wallet:
                quantity = norm_player_wallet.get(denom_name_lower, 0)
                denom_value_in_base = denomination_map[denom_name_lower]
                total_value += quantity * denom_value_in_base

            if total_value > 0:
                output_lines.append(f"{titlecase(base_name)}: **{total_value:.2f}**")

        # Display as separate integers
        else:
            # Sort by value descending
            sorted_denoms = sorted(denominations_in_wallet, key=lambda d: denomination_map[d], reverse=True)
            for denom_name_lower in sorted_denoms:
                quantity = norm_player_wallet.get(denom_name_lower, 0)
                if quantity > 0:
                    denom_display_name, _ = find_currency_or_denomination(currency_config, denom_name_lower)
                    if denom_display_name:
                        output_lines.append(f"{titlecase(denom_display_name)}: **{quantity}**")
    
    return output_lines


def get_denomination_map(currency_config: dict, currency_name: str) -> Tuple[dict | None, str | None]:
    """
    Retrieves a mapping of denomination names to their values for a given currency.

    :param currency_config: The server's currency config dict
    :param currency_name: The name of the currency or denomination to look up

    :return: A tuple containing:
             - A dict mapping denomination names (lowercase) to their float values, or None if not found
             - The parent currency name, or None if not found
    """
    if not currency_config or CurrencyFields.CURRENCIES not in currency_config:
        return None, None

    _denom_name, parent_name = find_currency_or_denomination(currency_config, currency_name)

    if not parent_name:
        return None, None

    parent_currency_config = next(
        (currency for currency in currency_config[CurrencyFields.CURRENCIES]
         if currency[CommonFields.NAME].lower() == parent_name.lower()),
        None
    )

    if not parent_currency_config:
        return None, None  # Config is inconsistent

    denomination_map = {parent_name.lower(): 1.0}
    for denom in parent_currency_config.get(CurrencyFields.DENOMINATIONS, []):
        denomination_map[denom[CommonFields.NAME].lower()] = float(denom[CurrencyFields.VALUE])

    return denomination_map, parent_name


def check_sufficient_funds(player_currency: dict, currency_config: dict, cost_currency_name: str,
                           cost_amount: float) -> Tuple[bool, str]:
    """
    Verifies that a player has funds to cover the attempted transaction.

    :param player_currency: The player's currency dict
    :param currency_config: The server's currency config dict
    :param cost_currency_name: The name of the currency or denomination that is being used
    :param cost_amount: The amount of the currency or denomination that is being used

    :return: A tuple containing:
             - A boolean indicating if the player has sufficient funds
             - A message string indicating success or the reason for failure
    """
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE

    try:
        if cost_amount <= 0:
            return True, "OK"

        denomination_map, _ = get_denomination_map(currency_config, cost_currency_name.lower())

        if not denomination_map:
            return False, t(DEFAULT_LOCALE, 'error-currency-not-configured', currencyName=cost_currency_name)

        cost_name_lower = cost_currency_name.lower()
        if cost_name_lower not in denomination_map:
            return False, t(DEFAULT_LOCALE, 'error-cost-currency-system-mismatch', currencyName=cost_currency_name)

        min_value = min(denomination_map.values())
        if min_value <= 0:
            return False, t(DEFAULT_LOCALE, 'error-currency-config-error')

        norm_player_currency = normalize_currency_keys(player_currency)
        player_total_value = 0.0

        for denom_name_lower, denom_value in denomination_map.items():
            player_qty = norm_player_currency.get(denom_name_lower, 0)
            player_total_value += player_qty * (denom_value / min_value)

        cost_denom_value = denomination_map[cost_name_lower]
        cost_total_value = cost_amount * (cost_denom_value / min_value)

        tolerance = 1e-9
        if player_total_value + tolerance < cost_total_value:
            return False, t(DEFAULT_LOCALE, 'error-insufficient-funds')

        return True, "OK"
    except Exception as e:
        logger.error(f"Error in check_sufficient_funds: {e}")
        logger.error(traceback.format_exc())
        return False, t(DEFAULT_LOCALE, 'error-currency-validation', error=str(e))


def get_base_currency_info(currency_config: dict, currency_name: str):
    """
    Returns base currency info for a given currency name.

    Parameters:
    - currency_config (dict): The currency configuration dictionary.
    - currency_name (str): The name of the currency.

    Returns:
    - Tuple[str | None, float, bool]: A tuple containing the base currency name (or None if not found),
      the multiplier to convert to base currency, and a boolean indicating if it's a double currency.
    """
    normalized_name = currency_name.lower()
    is_currency, parent_name = find_currency_or_denomination(currency_config, normalized_name)

    if not is_currency:
        return None, 0, False

    denomination_map, base_name = get_denomination_map(currency_config, normalized_name)
    multiplier = denomination_map.get(normalized_name, 0)

    is_double = False
    for currency in currency_config.get(CurrencyFields.CURRENCIES, []):
        if currency[CommonFields.NAME].lower() == base_name.lower():
            is_double = currency.get(CurrencyFields.IS_DOUBLE, False)
            break

    return base_name, multiplier, is_double


def consolidate_currency_totals(raw_totals: dict, currency_config: dict) -> dict:
    """
    Consolidates raw currency totals into base currencies, or in other words, makes change so that a given currency
    is represented by the fewest amount of coins/denominations.

    :param raw_totals: A dict mapping currency/denomination names to their total amounts
    :param currency_config: The server's currency config dict

    :return: A dict mapping base currency names to their consolidated total amounts
    """
    if not currency_config:
        return raw_totals

    consolidated = {}

    for currency_name, amount in raw_totals.items():
        base_name, multiplier, _ = get_base_currency_info(currency_config, currency_name)

        if base_name:
            base_key = base_name.lower()
            total_value_in_base = amount * multiplier
            consolidated[base_key] = consolidated.get(base_key, 0.0) + total_value_in_base
        else:
            consolidated[currency_name] = consolidated.get(currency_name, 0.0) + amount

    return consolidated


def format_consolidated_totals(base_totals: dict, currency_config: dict) -> list[str]:
    """
    Formats consolidated currency totals into a list of strings for display.

    :param base_totals: A dict mapping base currency names to their total amounts
    :param currency_config: The server's currency config dict

    :return: A list of formatted currency total strings
    """
    output = []

    for base_name, total_value in base_totals.items():
        curr_conf = None
        if currency_config:
            for c in currency_config.get(CurrencyFields.CURRENCIES, []):
                if c[CommonFields.NAME].lower() == base_name.lower():
                    curr_conf = c
                    break

        if not curr_conf:
            output.append(f"{titlecase(base_name)}: {total_value}")
            continue

        base_display_name = curr_conf[CommonFields.NAME]

        if curr_conf.get(CurrencyFields.IS_DOUBLE, False):
            output.append(f"{titlecase(base_display_name)}: {total_value:.2f}")
        else:
            denoms = curr_conf.get(CurrencyFields.DENOMINATIONS, [])
            all_denoms = [{CommonFields.NAME: curr_conf[CommonFields.NAME], CurrencyFields.VALUE: 1.0}] + denoms
            all_denoms.sort(key=lambda x: float(x[CurrencyFields.VALUE]), reverse=True)

            parts = []
            remaining_val = total_value

            tolerance = 1e-9

            for d in all_denoms:
                d_val = float(d[CurrencyFields.VALUE])
                if remaining_val + tolerance >= d_val:
                    count = int(remaining_val / d_val + tolerance)
                    if count > 0:
                        parts.append(f'{count} {titlecase(d[CommonFields.NAME])}')
                        remaining_val -= count * d_val

            if parts:
                output.append(', '.join(parts))
            elif total_value == 0:
                output.append(f'{titlecase(base_display_name)}: 0')
            elif total_value > 0:
                output.append(f'{titlecase(base_display_name)}: {total_value:.2f}')

    return output


def format_currency_amount(amount, currency_name, currency_config) -> str:
    """
    Formats a currency amount as a string, respecting the currency's display type (integer vs double).

    :param amount: The amount of currency
    :param currency_name: The name of the currency or denomination
    :param currency_config: The server's currency config dict

    :return: A formatted amount string (e.g. '50' for integer, '2.50' for double)
    """
    _, _, is_double = get_base_currency_info(currency_config, currency_name)
    amount = float(amount)

    if is_double:
        return f'{amount:.2f}'
    else:
        if amount % 1 == 0:
            return str(int(amount))
        else:
            return f'{amount:.2f}'


def format_price_string(amount, currency_name, currency_config) -> str:
    """
    Formats a single price/cost string.

    :param amount: The amount of currency
    :param currency_name: The name of the currency
    :param currency_config: The server's currency config dict

    :return: A formatted price string
    """
    display_name = titlecase(currency_name)
    formatted_amount = format_currency_amount(amount, currency_name, currency_config)
    return f'{formatted_amount} {display_name}'


def format_complex_cost(costs: list, currency_config: dict) -> str:
    """
    Formats a list of complex costs into a readable string.

    :param costs: A list of cost dictionaries, e.g. [{'gold': 10}, {'reputation': 50}]
    :param currency_config: The server's currency config dict

    :return: A formatted cost string
    """
    from ReQuest.utilities.localizer import t, DEFAULT_LOCALE

    if not costs:
        return t(DEFAULT_LOCALE, 'common-label-free')

    option_strings = []
    for option in costs:
        component_strings = []
        for currency_name, amount in option.items():
            component_strings.append(format_price_string(amount, currency_name, currency_config))
        if component_strings:
            option_strings.append(' + '.join(component_strings))

    if not option_strings:
        return t(DEFAULT_LOCALE, 'common-label-free')

    return ' OR\n'.join(option_strings)
