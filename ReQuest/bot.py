from pathlib import Path

import discord
import yaml
from motor.motor_asyncio import AsyncIOMotorClient
from discord.ext import commands
from discord.ext.commands import errors
from utilities.supportFunctions import get_prefix, attempt_delete

# Set up config file and load
CONFIG_FILE = Path('ReQuest/config.yaml')

with open(CONFIG_FILE, 'r') as yaml_file:
    config = yaml.safe_load(yaml_file)

mongo_client = AsyncIOMotorClient(config['dbServer'], config['port'])
cdb = mongo_client[config['configDb']]
mdb = mongo_client[config['memberDb']]
gdb = mongo_client[config['guildDb']]


# Define bot class
class ReQuest(commands.AutoShardedBot):
    def __init__(self):
        allowed_mentions = discord.AllowedMentions(roles=True, everyone=False, users=True)
        intents = discord.Intents.default()
        intents.members = True  # Subscribe to the privileged members intent.
        intents.presences = True  # Subscribe to the privileged presences intent.
        super(ReQuest, self).__init__(command_prefix=get_prefix, fetch_offline_members=False,
                                      allowed_mentions=allowed_mentions, intents=intents, case_insensitive=True,
                                      activity=discord.Game(name=f'by Post'))

        self.gdb = gdb
        self.mdb = mdb
        self.cdb = cdb
        self.config = config
        self.white_list = []
        if config['whiteList']:
            self.white_list = self.get_white_list()

    @staticmethod
    async def get_white_list():
        return await cdb['botWhiteList'].find_one({'servers': {'$exists': True}})['servers']

    # Overridden from base to delete command invocation messages
    async def invoke(self, ctx):
        if ctx.command is not None:
            self.dispatch('command', ctx)
            try:
                if await self.can_run(ctx, call_once=True):
                    await attempt_delete(ctx.message)
                    await ctx.command.invoke(ctx)
                else:
                    raise errors.CheckFailure('The global check once functions failed.')
            except errors.CommandError as exc:
                await ctx.command.dispatch_error(ctx, exc)
            else:
                self.dispatch('command_completion', ctx)
        elif ctx.invoked_with:
            exc = errors.CommandNotFound('Command "{}" is not found'.format(ctx.invoked_with))
            self.dispatch('command_error', ctx, exc)

    async def on_message(self, message):
        if message.author.bot:
            return
        elif len(message.mentions) > 0 and self.user in message.mentions:
            await message.channel.send(f'My prefix for this server is `{await get_prefix(self, message)}`')
        else:
            await self.process_commands(message)


bot = ReQuest()


def main():
    """Tries to load every cog and start up the bot"""
    for extension in bot.config['load_extensions']:
        try:
            bot.load_extension(extension)
        except Exception as e:
            print(f'Failed to load extension: {extension}')
            print('{}: {}'.format(type(e).__name__, e))

    print("ReQuest is online.")
    bot.run(bot.config['token'], bot=True, reconnect=True)


if __name__ == '__main__':
    main()
