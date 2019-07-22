import bson
import discord
import itertools
import pymongo
from pymongo import MongoClient

client = discord.Client()

connection = MongoClient('localhost', 27017)
db = connection['quests']

# Print message on login
@client.event
async def on_ready():
    print('We have logged in as {0.user}'.format(client))
    await client.change_presence(activity = discord.Game(name = 'By Post'))

# Add commands here
@client.event
async def on_message(message):
    global db    

    # Get Discord's server ID, used to query the db collection
    server = message.guild.id
    collection = db[str(server)]

    # Ignore messages sent by the bot
    if message.author == client.user:
        return

	# Command prefix set to r!
	# TODO: allow changing of command prefix
    if message.content[:2] == 'r!':
        args=message.content[2:].split()
        cmd=args[0]

    if cmd == 'info':
        await message.channel.send('Invite me to your server! <https://discordapp.com/api/oauth2/authorize?client_id=601492201704521765&permissions=388160&scope=bot>')

    if cmd == 'help':
        await message.channel.send('This is where the developer would have a handy help file, if he didn\'t suck.')

    if cmd == 'channel':
        postChannel = ''
        errorMsg = 'Error communicating with the database. Channel not set. Contact the ReQuest developer for support.'
        if len(args)>1:
            postChannel = args[1]
            if collection.find_one({'postChannel': {'$exists': 'true'}}):
                if not collection.delete_one({'postChannel': {'$exists': 'true'}}):
                    await message.channel.send(errorMsg)
                    return
            if not collection.insert_one({'postChannel': postChannel}):
                await message.channel.send(errorMsg)
                return
            await message.channel.send('Successfully set quest channel to {0}!'.format(postChannel))
        else:
            query = collection.find_one({'postChannel': {'$exists': 'true'}})
            if query:
                for key, value in query.items():
                    if key == 'postChannel':
                        postChannel = value
                await message.channel.send('Quest channel currently set to {0}.'.format(postChannel))
            else:
                await message.channel.send('No quest channel set. Use the command `r!channel <channel>`.')

    if cmd == 'announce':
        announceRole = ''
        errorMsg = 'Error communicating with the database. Announcement role not set. Contact the ReQuest developer for support.'
        if len(args)>1:
            announceRole = args[1]
            if collection.find_one({'announceRole': {'$exists': 'true'}}):
                if not collection.delete_one({'announceRole': {'$exists': 'true'}}):
                    await message.channel.send(errorMsg)
                    return
            if not collection.insert_one({'announceRole': announceRole}):
                await message.channel.send(errorMsg)
                return
            await message.channel.send('Successfully set announcement role to {0}!'.format(announceRole))
        else:
            query = collection.find_one({'announceRole': {'$exists': 'true'}})
            if query:
                for key, value in query.items():
                    if key == 'announceRole':
                        announceRole = value
                await message.channel.send('Announcement role currently set to {0}.'.format(announceRole))
            else:
                await message.channel.send('No quest channel set. Use the command `r!announce <role>`.')

    if cmd == 'post':
        postChannel = ''
        announceRole = ''
        postQuery = collection.find_one({'postChannel': {'$exists': 'true'}})
        if postQuery:
            for key, value in postQuery.items():
                if key == 'postChannel':
                    postChannel = client.get_channel(int(value.strip('<').strip('>').strip('#')))
        else:
            await message.channel.send('No quest channel set. Use the command `r!channel <channel>`.')
            return
        roleQuery = collection.find_one({'announceRole': {'$exists': 'true'}})
        if roleQuery:
            for key, value in roleQuery.items():
                if key == 'announceRole':
                    announceRole = value

        title, levels ,gm, description, slots, role = args[1], args[2], args[3], args[4], args[5], args[6]
        msg = await postChannel.send(f'{announceRole}\n**NEW QUEST:** {title}\n**Level Range:** {levels}\n**GM:** {gm}\n**Description:** {description}\n**Players:**')
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
        await message.channel.send('Quest posted!')
        
# After further thought, this feature should halt until the database is implemented
# Messages will store as arrays in a database and edits will call the array,
# modify the description index, and then pass to the message compiler to post
@client.event
async def on_reaction_add(reaction, user):
    if user == client.user:
        return

    original = reaction.message.content
    await reaction.message.edit(content = original+f'\n- <@!{user.id}>')

def deconstruct_post(message):
    return message.split('\n')

def reconstruct_post(content):
    return ' '.join(content)

f=open('token.txt','r')
if f.mode == 'r':
	token=f.read()
f.close()

client.run(token)