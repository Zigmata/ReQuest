import logging

import discord
from discord.ui import Container, Section, TextDisplay, ActionRow, Separator, Button

from ReQuest.ui.common.views import LocaleLayoutView

from ReQuest.ui.common.buttons import MenuDoneButton
from ReQuest.ui.info.selects import LanguageSelect, get_locale_total_pages, get_locale_page
from ReQuest.utilities.constants import CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import DEFAULT_LOCALE, SUPPORTED_LOCALES, t
from ReQuest.utilities.supportFunctions import get_cached_data, log_exception

logger = logging.getLogger(__name__)


class LanguageView(LocaleLayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.locale = DEFAULT_LOCALE
        self.language_select = LanguageSelect(self)
        self.current_display = TextDisplay('')
        self.language_page = 0

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()

        header_section = Section(accessory=MenuDoneButton(self.locale))
        header_section.add_item(TextDisplay(f'**{t(self.locale, "info-language-title")}**'))
        container.add_item(header_section)
        container.add_item(Separator())

        container.add_item(self.current_display)

        language_select_row = ActionRow(self.language_select)
        container.add_item(language_select_row)

        total_pages = get_locale_total_pages()
        if total_pages > 1:
            nav_row = ActionRow()
            prev_button = Button(
                label=t(self.locale, 'common-btn-prev'),
                style=discord.ButtonStyle.secondary,
                custom_id='lang_prev_page',
                disabled=(self.language_page == 0)
            )
            prev_button.callback = self.prev_page

            page_display = Button(
                label=t(self.locale, 'common-page-display',
                        current=self.language_page + 1, total=total_pages),
                style=discord.ButtonStyle.secondary,
                custom_id='lang_page_display',
                disabled=True
            )

            next_button = Button(
                label=t(self.locale, 'common-btn-next'),
                style=discord.ButtonStyle.secondary,
                custom_id='lang_next_page',
                disabled=(self.language_page >= total_pages - 1)
            )
            next_button.callback = self.next_page

            nav_row.add_item(prev_button)
            nav_row.add_item(page_display)
            nav_row.add_item(next_button)
            container.add_item(nav_row)

        container.add_item(Separator())
        container.add_item(TextDisplay(t(self.locale, 'common-translation-notice')))

        self.add_item(container)

    async def setup(self, bot, user):
        try:
            locale_data = await get_cached_data(
                bot=bot,
                mongo_database=bot.mdb,
                collection_name=DatabaseCollections.USER_LOCALE,
                query={CommonFields.ID: user.id}
            )

            current_locale = self.locale
            if locale_data and 'locale' in locale_data:
                stored_locale = locale_data['locale']
                if stored_locale in SUPPORTED_LOCALES:
                    current_locale = stored_locale

            self.current_display.content = t(
                self.locale,
                'info-language-current',
                language=t(self.locale, f'info-language-label-{current_locale.lower()}')
            )
            self.language_page = get_locale_page(current_locale)
            self.language_select.populate(self.locale, page=self.language_page)

            self.build_view()
        except Exception as e:
            await log_exception(e)

    async def prev_page(self, interaction: discord.Interaction):
        if self.language_page > 0:
            self.language_page -= 1
            self.language_select.populate(self.locale, page=self.language_page)
            self.build_view()
            await interaction.response.edit_message(view=self)

    async def next_page(self, interaction: discord.Interaction):
        if self.language_page < get_locale_total_pages() - 1:
            self.language_page += 1
            self.language_select.populate(self.locale, page=self.language_page)
            self.build_view()
            await interaction.response.edit_message(view=self)
