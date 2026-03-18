import discord
from discord.ui import (
    LayoutView,
    Container,
    Section,
    Separator,
    TextDisplay
)

from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton
from ReQuest.utilities.localizer import t, DEFAULT_LOCALE, set_locale_context


class LocaleLayoutView(LayoutView):
    """LayoutView subclass that propagates locale via context var before every component callback."""

    async def interaction_check(self, interaction: discord.Interaction) -> bool:
        locale = getattr(self, 'locale', None) or DEFAULT_LOCALE
        set_locale_context(locale)
        return True


class MenuBaseView(LocaleLayoutView):
    def __init__(self, title, menu_items, menu_level, locale=None):
        super().__init__(timeout=None)
        self.title = title
        self.menu_items = menu_items
        self.menu_level = menu_level
        self.locale = locale or DEFAULT_LOCALE

        self.build_view()

    def build_view(self):
        self.clear_items()
        container = Container()
        nav_button = MenuDoneButton(locale=self.locale)
        header_section = Section(accessory=nav_button)
        header_section.add_item(TextDisplay(f'**{self.title}**'))
        container.add_item(header_section)
        container.add_item(Separator())
        for item in self.menu_items:
            name = item.get('name', '')
            description = item.get('description', '')
            view_class = item.get('view_class', None)
            menu_button = MenuViewButton(view_class, name)
            menu_text = TextDisplay(description)
            menu_section = Section(accessory=menu_button)
            menu_section.add_item(menu_text)
            container.add_item(menu_section)

        self.add_item(container)
