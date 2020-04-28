import bson
import itertools

import discord

from discord.ext import commands

import pymongo
from pymongo import MongoClient

connection = MongoClient('localhost', 27017)
db = connection['quests']

# client = discord.Client()

# Print message on login and set status
#@client.event
#async def on_ready():
    #print('We have logged in as {0.user}'.format(client))
    #await client.change_presence(activity = discord.Game(name = 'By Post'))

bot = commands.Bot(command_prefix='!')

@bot.command()
async def echo(ctx, *args):
    await ctx.send('{} arguments: {}'.format(len(args), ', '.join(args)))

@bot.command()
async def info(ctx):
    await ctx.send('Invite me to your server! <https://discordapp.com/api/oauth2/authorize?client_id=601492201704521765&permissions=388160&scope=bot>')

## Commands
#@client.event
#async def on_message(message):
#    global db    

#    # Get Discord's server ID, used to query the db collection
#    server = message.guild.id
#    collection = db[str(server)]

#    # Ignore messages sent by the bot
#    if message.author == client.user:
#        return

#	# Command prefix set to r!
#	# TODO: allow changing of command prefix
#    if message.content[:2] == 'r!':
#        args=message.content[2:].split()
#        cmd=args[0]
#    else:
#        return

#    if cmd == 'info':
#        await message.channel.send('Invite me to your server! <https://discordapp.com/api/oauth2/authorize?client_id=601492201704521765&permissions=388160&scope=bot>')

#    if cmd == 'help':
#        if len(args)>1:
#            command = args[1]
#            await message.channel.send(command_help(command))
#        else:
#            await message.channel.send(command_help(general))

#    if cmd == 'channel':
#        postChannel = ''
#        errorMsg = 'Error communicating with the database. Channel not set. Contact the ReQuest developer for support.'
#        if len(args)>1:
#            postChannel = args[1]
#            if collection.find_one({'postChannel': {'$exists': 'true'}}):
#                if not collection.delete_one({'postChannel': {'$exists': 'true'}}):
#                    await message.channel.send(errorMsg)
#                    return
#            if not collection.insert_one({'postChannel': postChannel}):
#                await message.channel.send(errorMsg)
#                return
#            await message.channel.send('Successfully set quest channel to {0}!'.format(postChannel))
#        else:
#            query = collection.find_one({'postChannel': {'$exists': 'true'}})
#            if query:
#                for key, value in query.items():
#                    if key == 'postChannel':
#                        postChannel = value
#                await message.channel.send('Quest channel currently set to {0}.'.format(postChannel))
#            else:
#                await message.channel.send('No quest channel set. Use the command `r!channel <channel>`.')

#    if cmd == 'announce':
#        announceRole = ''
#        errorMsg = 'Error communicating with the database. Announcement role not set. Contact the ReQuest developer for support.'
#        if len(args)>1:
#            announceRole = args[1]
#            if collection.find_one({'announceRole': {'$exists': 'true'}}):
#                if not collection.delete_one({'announceRole': {'$exists': 'true'}}):
#                    await message.channel.send(errorMsg)
#                    return
#            if not collection.insert_one({'announceRole': announceRole}):
#                await message.channel.send(errorMsg)
#                return
#            await message.channel.send('Successfully set announcement role to {0}!'.format(announceRole))
#        else:
#            query = collection.find_one({'announceRole': {'$exists': 'true'}})
#            if query:
#                for key, value in query.items():
#                    if key == 'announceRole':
#                        announceRole = value
#                await message.channel.send('Announcement role currently set to {0}.'.format(announceRole))
#            else:
#                await message.channel.send('No quest channel set. Use the command `r!announce <role>`.')

#    # TODO: Implement dynamic message construction for manipulation of joined members
#    if cmd == 'post':
#        postChannel = ''
#        announceRole = ''
#        postQuery = collection.find_one({'postChannel': {'$exists': 'true'}})
#        if postQuery:
#            for key, value in postQuery.items():
#                if key == 'postChannel':
#                    postChannel = client.get_channel(int(value.strip('<').strip('>').strip('#')))
#        else:
#            await message.channel.send('No quest channel set. Use the command `r!channel <channel>`.')
#            return
#        roleQuery = collection.find_one({'announceRole': {'$exists': 'true'}})
#        if roleQuery:
#            for key, value in roleQuery.items():
#                if key == 'announceRole':
#                    announceRole = value

#        title, levels ,gm, description, slots, role = args[1], args[2], args[3], args[4], args[5], args[6]
#        msg = await postChannel.send(f'{announceRole}\n**NEW QUEST:** {title}\n**Level Range:** {levels}\n**GM:** {gm}\n**Description:** {description}\n**Players:**')
#        emoji = '<:acceptquest:601559094293430282>'
#        await msg.add_reaction(emoji)
#        await message.channel.send('Quest posted!')
        
# Messages will store as arrays in a database and edits will call the array,
# modify the description index, and then pass to the message compiler to post
#@client.event
#async def on_reaction_add(reaction, user):
#    if user == client.user:
#        return

#    original = reaction.message.content
#    await reaction.message.edit(content = original+f'\n- <@!{user.id}>')

#def deconstruct_post(message):
#    return message.split('\n')

#def reconstruct_post(content):
#    return ' '.join(content)

#def command_help(command):
#    helpMsg = 'Help for this command is not yet implemented. Yell at the developer!'
#    if command == 'channel':
#        helpMsg = 'Sets the quest posting channel.\nSyntax: `r!channel <channel link>`\nExample: `r!channel #testing`\nUse this command with no arguments to view the currently configured channel.'
#    return(helpMsg)

f=open('token.txt','r')
if f.mode == 'r':
    token=f.read()
f.close()

bot.run(token, bot=True)

