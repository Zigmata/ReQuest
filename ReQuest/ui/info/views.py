import logging

from discord.ui import LayoutView, Container, Section, TextDisplay, ActionRow, Separator

from ReQuest.ui.common.buttons import MenuDoneButton
from ReQuest.ui.info.selects import LanguageSelect
from ReQuest.utilities.constants import CommonFields, DatabaseCollections
from ReQuest.utilities.localizer import DEFAULT_LOCALE, t
from ReQuest.utilities.supportFunctions import get_cached_data, log_exception

logger = logging.getLogger(__name__)


class LanguageView(LayoutView):
    def __init__(self):
        super().__init__(timeout=None)
        self.locale = DEFAULT_LOCALE
        self.language_select = LanguageSelect(self)
        self.current_display = TextDisplay('')

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
                current_locale = locale_data['locale']

            self.current_display.content = t(
                self.locale,
                'info-language-current',
                language=t(self.locale, f'info-language-label-{current_locale.lower()}')
            )
            self.language_select.populate(self.locale)

            self.build_view()
        except Exception as e:
            await log_exception(e)
