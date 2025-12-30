import discord
from discord import app_commands
from discord.ext.commands import Cog


class Info(Cog):
    """Help and informational commands."""
    def __init__(self, bot):
        self.bot = bot
        super().__init__()

    # Simple ping test
    @app_commands.command(name='ping')
    async def ping(self, interaction: discord.Interaction):
        """
        Get a quick reply from the bot to see if it is online.
        """
        await interaction.response.send_message('**Pong!**\n{0}ms'.format(round(self.bot.latency * 1000), 1),
                                                ephemeral=True)

    @app_commands.command(name='invite')
    async def invite(self, interaction: discord.Interaction):
        """
        Prints an invitation to add ReQuest to your server.
        """
        embed = discord.Embed(title='Invite me to your server!',
                              description='[Get ReQuest!](https://discord.com/api/oauth2/authorize?client_id=6014922017'
                                          '04521765&permissions=1497132133440&scope=applications.commands%20bot)',
                              type='rich')
        await interaction.response.send_message(embed=embed)

    @app_commands.command(name='support')
    async def support(self, interaction: discord.Interaction):
        """
        Prints the bot version and a link to the development server.
        """
        await interaction.response.send_message(
            f'**ReQuest v{interaction.client.version}**\n\nBugs? Feature Requests? Join the development '
            f'server at https://discord.gg/Zq37gj4')

    @app_commands.command(name='help')
    async def help(self, interaction: discord.Interaction):
        """
        Displays a list of commands and their functions.
        """
        embed = discord.Embed(
            title='ReQuest - Command List',
            description=(
                'The following basic commands are available:\n\n'
                '- `/help`: This command.\n'
                '- `/support`: Prints an invite to the official ReQuest Discord.\n'
                '- `/invite`: Prints an invite to add ReQuest to your Discord.\n'
                '- `/ping`: Performs a basic connectivity test.\n\n'
                'The following enhanced-menu commands are available; use one to learn more about its sub-functions:\n\n'
                '- `/config`: Server-wide configurations, mostly relating to first-time ReQuest setup for your Discord.'
                ' Requires "Manage Server" permissions to access.\n'
                '- `/player`: Functions for players to manage and view their player characters.\n'
                '- `/gm`: All Game Master functions. Requires a GM role to be configured for the server.\n'
                '- `/shop`: View and purchase items from the current channel\'s shop (if configured).\n\n'
                'The following commands are context-menus. To access them on the desktop client, right-click a user\'s '
                'name and choose "Apps". On mobile, view a user\'s profile and select "Apps" from the upper-right '
                'menu.\n\n'
                '- Trade: Give items or currency to another player.\n'
                '- View Player (GM-only): View another player\'s active character inventory.\n'
                '- Modify Player (GM-only): Modify another player\'s active character inventory or experience.\n'
            ),
            type='rich'
        )
        await interaction.response.send_message(embed=embed, ephemeral=True)


async def setup(bot):
    await bot.add_cog(Info(bot))
