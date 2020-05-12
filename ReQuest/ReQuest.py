import discord
from discord.ext import commands

# -----COGS-----

COGS = ['cogs.questBoard','cogs.help','cogs.inventory','cogs.playerBoard', 'cogs.admin']

# Define bot class
class ReQuest(commands.AutoShardedBot):
    def __init__(self, prefix, **options):
        super(ReQuest, self).__init__(prefix, **options)

# Define bot and prefix
# TODO: Implement prefix changes
pre = 'r!'
bot = ReQuest(prefix=pre, activity=discord.Game(name=f'by Post'))
bot.remove_command('help')

for cog in COGS:
    bot.load_extension(cog)

f=open('token.txt','r')
if f.mode == 'r':
    token=f.read()
f.close()

bot.run(token, bot=True)