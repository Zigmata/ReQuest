import shortuuid
import itertools
import bson
import re

import pymongo
from pymongo import MongoClient

import discord
from discord.utils import get
from discord.ext import commands
from discord.ext.commands import Cog, command

listener = Cog.listener

# TODO: Exception reporting in channel
class QuestBoard(Cog):
    """Quest posts and associated reaction signups/options"""
    def __init__(self, bot):
        global config
        global db # remove after redesign
        global gdb
        self.bot = bot
        config = bot.config
        connection = MongoClient(config['dbServer'],config['port'])
        db = connection[config['guildsCollection']] # remove after db redesign
        gdb = connection[config['guildCollection']]

    async def reaction_operation(self, payload):
        """Handles addition/removal of user mentions when reacting to quest posts"""
        guildId = payload.guild_id
        channel = self.bot.get_channel(payload.channel_id)
        message = await channel.fetch_message(payload.message_id)
        channelName : str = None

        # Find the configured Quest Channel and get the name (string in <#channelID> format)
        collection = gdb['questChannel']
        query = collection.find_one({'guildId': guildId})
        if not query:
# TODO: Error handling/logging
            return
        else:
            for key, value in query.items():
                if key == 'questChannel':
                    channelName = value

        collection = gdb['quests']
        if int(channelName[2:len(channelName)-1]) == int(channel.id): # Ensure that only posts in the configured Quest Channel are modified.
            messageId = payload.message_id
            userId = payload.user_id
            if payload.event_type == 'REACTION_ADD': # Checks which kind of event is raised
                if payload.member.bot:
                        return # Exits the function if the reaction add is triggered by the bot
                else:
                    original = message.content # Grab the original message
                    await message.edit(content = original+f'\n- <@!{userId}>') # Append the reacting user's mention to the message
                    collection.update_one({'messageId': messageId}, {'$push': {'party': userId}})
            else:
                original = message.content
                edited = re.sub('\n- <@!'+str(userId)+'>', '', original)
# TODO: index a regex of user mention, then remove that substring somehow
                await message.edit(content = edited)
                collection.update_one({'messageId': messageId}, {'$pull': {'party': userId}})
        else:
# TODO: Needs error reporting/logging
            return

    @listener()
    async def on_raw_reaction_add(self, payload):
        """Reaction_add event handling"""
        await QuestBoard.reaction_operation(self, payload)

    @listener()
    async def on_raw_reaction_remove(self, payload):
        """Reaction_remove event handling"""
        await QuestBoard.reaction_operation(self, payload)

    @command(aliases = ['qpost','qp'])
    async def questPost(self, ctx, title: str, levels: str, description: str, maxPartySize: int):
        """Posts a new quest."""

# TODO: Research exception catching on function argument TypeError
# TODO: Refactor post into BSON entry for manipulation/future functionality

        collection = gdb['questChannel']
        guildId = ctx.message.guild.id
        channelName : str = None
        announceRole : str = None
        questId = str(shortuuid.uuid()[:8])

        # Query the collection to see if a channel is set
        query = collection.find_one({'guildId': guildId})

        # Inform user if quest channel is not set. Otherwise, get the channel string
        if not query:
            await ctx.send('Quest channel not set! Configure with `{}questChannel <channel mention>`'.format(self.bot.command_prefix))
            return
        else:
            for key, value in query.items():
                if key == 'questChannel':
                    channelName = value

        # Query the collection to see if a role is set
        collection = gdb['announceRole']
        query = collection.find_one({'guildId': guildId})

        # Inform user if quest channel is not set. Otherwise, get the channel string
# TODO: Make announcement role optional
        if not query:
            await ctx.send('Announcement role not set! Configure with `{}announceRole <role mention>`'.format(self.bot.command_prefix))
            return
        else:
            for key, value in query.items():
                if key == 'announceRole':
                    announceRole = value
    
        collection = gdb['quests']
        # Slice the string so we just have the ID, and use that to get the channel object.
        channel = self.bot.get_channel(int(channelName[2:len(channelName)-1]))

        # Set post format and log the author, then post the new quest with an emoji reaction.
        gm = ctx.author.id
        party : [int] = [None]
        xp : int = None
        post = (f'{announceRole}\n**NEW QUEST:** {title}\n**Quest ID:**{questId}\n' +
                f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:** {description}\n' +
                f'**Players (Max of {maxPartySize}):**')
        msg = await channel.send(post)
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
        messageId = msg.id

        #postEmbed = discord.Embed(title='NEW QUEST: '+title, type='rich', description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
        #postEmbed.add_field(name='Party', value=None)
        #postEmbed.add_field(name='Waitlist', value=None)
        #postEmbed.set_footer(text='Quest ID: '+questId)

        #await channel.send(f'``` ```\n{announceRole}')
        #await channel.send(embed=postEmbed)

        try:
            collection.insert_one({'guildId': guildId, 'questId': questId, 'messageId': messageId, 'title': title, 'desc': description, 'maxPartySize': maxPartySize, 'levels': levels, 'gm': gm, 'party': party, 'xp': xp})
        except Exception as e:
            await ctx.send('{}: {}'.format(type(e).__name__, e))
            
        # Provide feedback to the channel from which the command was sent.
        await ctx.send('Quest posted!')

    #@commands.has_any_role() # Restrict command use to defined role(s)
    @command(aliases = ['qcomplete','qc'], hidden=True)
    async def questComplete(self, ctx, id):
        return

def setup(bot):
    bot.add_cog(QuestBoard(bot))