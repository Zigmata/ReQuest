from discord.ui import LayoutView, Container, Section, Separator, TextDisplay

from ReQuest.ui.common.buttons import MenuViewButton, MenuDoneButton


class MenuBaseView(LayoutView):
    def __init__(self, title, menu_items, menu_level):
        super().__init__(timeout=None)
        self.title = title
        self.menu_items = menu_items
        self.menu_level = menu_level

        self.build_view()

    def build_view(self):
        container = Container()
        nav_button = MenuDoneButton()
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
