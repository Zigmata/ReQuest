import discord


class AddCurrencyDenominationTextInput(discord.ui.TextInput):
    def __init__(self, input_type, placeholder):
        super().__init__(
            label=input_type,
            style=discord.TextStyle.short,
            placeholder=placeholder,
            custom_id=f'denomination_{input_type.lower()}_text_input',
            required=True
        )
