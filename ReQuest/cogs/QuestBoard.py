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

# ---- Listeners and support functions ----

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

    async def embed_reaction(self, payload):
        """Handles addition/removal of user mentions when reacting to quest embeds"""
        guildId = payload.guild_id
        channel = self.bot.get_channel(payload.channel_id)
        messageId = payload.message_id
        message = await channel.fetch_message(messageId)
        channelName : str = None

        collection = gdb['questChannel']
        query = collection.find_one({'guildId': guildId})
        if not query:
# TODO: Error Handling
            return
        else:
            for key, value in query.items():
                if key == 'questChannel':
                    channelName = value

        collection = gdb['quests']
        if int(channelName[2:len(channelName)-1]) == int(channel.id):
            userId = payload.user_id
            query = collection.find_one({'messageId': messageId})
            if not query:
                return
            else:
                questId, title, description, levels, gm, party = \
                            query['questId'], query['title'], query['desc'], query['levels'], query['gm'], query['party']
                if payload.event_type == 'REACTION_ADD':
                    if payload.member.bot:
                        return
                    else:
                        if party[0] == None:
                            party[0] = userId
                        else:
                            party.append(userId)

                        mappedParty = list(map(str, party))

                        formattedParty = '- <@!'+'>\n- <@!'.join(mappedParty)+'>'

                        postEmbed = discord.Embed(title='NEW QUEST: '+title, type='rich', \
                            description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
                        postEmbed.add_field(name='Party', value=formattedParty)
                        postEmbed.add_field(name='Waitlist', value=None)
                        postEmbed.set_footer(text='Quest ID: '+questId)

                        collection.update_one({'messageId': messageId}, {'$push': {'party': userId}})

                    await message.edit(embed=postEmbed)
                else:
                    return


    #@listener()
    #async def on_raw_reaction_add(self, payload):
    #    """Reaction_add event handling"""
    #    await QuestBoard.reaction_operation(self, payload)

    @listener()
    async def on_raw_reaction_add(self, payload):
        """Reaction_add event handling"""
        await QuestBoard.embed_reaction(self, payload)

    @listener()
    async def on_raw_reaction_remove(self, payload):
        """Reaction_remove event handling"""
        await QuestBoard.reaction_operation(self, payload)

# ---- Configuration Commands ----

    @commands.has_permissions(administrator=True, manage_guild=True)
    @command(aliases = ['qchannel','qch'])
    async def questChannel(self, ctx, channel : str = None):
        """Configures the channel in which quests are to be posted"""
        # Get server ID to locate proper collection
        guildId = ctx.message.guild.id
        collection = gdb['questChannel']
        channelName : str = None

        # When provided with a channel name, deletes the old entry and adds the new one.
        if (channel):
            if collection.find_one({'guildId': guildId}):
                # If a match is found, attempt to delete it before proceeding.
                try:
                    collection.delete_one({'guildId': guildId})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return

            # Regardless of whether or not a match is found, insert the new record.
            try:
                collection.insert_one({'guildId': guildId, 'questChannel': channel})
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
            else:
                await ctx.send('Successfully set quest channel to {0}!'.format(channel))

        # If no channel is provided, inform the user of the current setting
        if (channel == None):
            query = collection.find_one({'guildId': guildId})
            if not query:
                await ctx.send('Quest channel not set! Configure with `{}questChannel <channel link>`'.format(self.bot.command_prefix))
            else:
                for key, value in query.items():
                    if key == 'questChannel':
                        channelName = value
                        await ctx.send('Quest channel currently set to {}'.format(channelName))

    @commands.has_permissions(administrator=True, manage_guild=True)
    @command(aliases = ['arole','ar'])
    async def announceRole(self, ctx, role: str = None):
        """Gets or sets the role used for post announcements."""
        guildId = ctx.message.guild.id
        collection = gdb['announceRole']

        if (role):
            if collection.find_one({'guildId': guildId}):
                try:
                    collection.delete_one({'guildId': guildId})
                except Exception as e:
                    await ctx.send('{}: {}'.format(type(e).__name__, e))
                    return

            try:
                collection.insert_one({'guildId': guildId, 'announceRole': role})
            except Exception as e:
                await ctx.send('{}: {}'.format(type(e).__name__, e))
            else:
                await ctx.send('Successfully set announcement role to {}!'.format(role))

        if (role == None):
            query = collection.find_one({'guildId': guildId})
            if not query:
                await ctx.send('Announcement role not set! Configure with `{}announceRole <role mention>`'.format(self.bot.command_prefix))
            else:
                announceRole = None
                for key, value in query.items():
                    if key == 'announceRole':
                        announceRole = value

                await ctx.send('Announcement role currently set to {}'.format(announceRole))

# ---- GM Commands ----

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
        #post = (f'{announceRole}\n**NEW QUEST:** {title}\n**Quest ID:** {questId}\n' +
        #        f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:** {description}\n' +
        #        f'**Players (Max of {maxPartySize}):**')
        #msg = await channel.send(post)
        #emoji = '<:acceptquest:601559094293430282>'
        #await msg.add_reaction(emoji)
        #messageId = msg.id

        # --- Embed Style ---

        postEmbed = discord.Embed(title='NEW QUEST: '+title, type='rich', description=f'**GM:** <@!{gm}>\n**Level Range:** {levels}\n**Description:**\n{description}')
        postEmbed.add_field(name='Party', value=None)
        postEmbed.add_field(name='Waitlist', value=None)
        postEmbed.set_footer(text='Quest ID: '+questId)

        await channel.send(f'{announceRole}')
        msg = await channel.send(embed=postEmbed)
        emoji = '<:acceptquest:601559094293430282>'
        await msg.add_reaction(emoji)
        messageId = msg.id

        #--------------------

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