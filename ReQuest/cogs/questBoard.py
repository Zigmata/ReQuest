import logging

from discord.ext.commands import Cog

from ..utilities.supportFunctions import reaction_operation

listener = Cog.listener
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class QuestBoard(Cog):
    def __init__(self, bot):
        super().__init__()
        self.bot = bot

    # ---- Listeners and support functions ----

    @listener()
    async def on_raw_reaction_add(self, payload):
        """Reaction_add event handling"""
        if str(payload.emoji) == '<:acceptquest:601559094293430282>':
            await reaction_operation(self.bot, payload)
        else:
            return

    @listener()
    async def on_raw_reaction_remove(self, payload):
        """Reaction_remove event handling"""
        if str(payload.emoji) == '<:acceptquest:601559094293430282>':
            await reaction_operation(self.bot, payload)
        else:
            return

    #
    # @app_commands.command(name='delete')
    # async def delete(self, interaction: discord.Interaction, quest_id: str):
    #     """
    #     Deletes a quest.
    #
    #     Arguments:
    #     [quest_id]: The ID of the quest.
    #     """
    #     guild_id = interaction.guild_id
    #     user_id = interaction.user.id
    #     guild = self.bot.get_guild(guild_id)
    #     member = guild.get_member(user_id)
    #     error_title = None
    #     error_message = None
    #
    #     # Fetch the quest
    #     quest = await self.gdb['quests'].find_one({'questId': quest_id})
    #     if not quest:
    #         error_title = 'Error!'
    #         error_message = 'Quest ID not found!'
    #     # Confirm the user calling the command is the GM that created the quest, or has administrative rights.
    #     elif not quest['gm'] == user_id and not member.guild_permissions.manage_guild:
    #         error_title = 'Quest Not Edited!'
    #         error_message = 'GMs can only manage their own quests!'
    #     else:
    #         # If a party exists
    #         party = quest['party']
    #         title = quest['title']
    #         if party:
    #             # Check if a GM role was configured
    #             gm_role = None
    #             gm = quest['gm']
    #             role_query = await self.gdb['partyRole'].find_one({'guildId': guild_id, 'gm': gm})
    #             if role_query:
    #                 gm_role = role_query['role']
    #
    #             # Get party members and message them with results
    #             for player in party:
    #                 for key in player:
    #                     member = await guild.fetch_member(int(key))
    #                     # Remove the party role, if applicable
    #                     if gm_role:
    #                         role = guild.get_role(gm_role)
    #                         await member.remove_roles(role)
    #                     # TODO: Implement loot and XP after those functions are added
    #                     await member.send(f'Quest **{title}** was cancelled by the GM.')
    #
    #         # Delete the quest from the database
    #         await self.gdb['quests'].delete_one({'questId': quest_id})
    #
    #         # Delete the quest from the quest channel
    #         channel_query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
    #         channel_id = channel_query['questChannel']
    #         quest_channel = guild.get_channel(channel_id)
    #         message_id = quest['messageId']
    #         message = quest_channel.get_partial_message(message_id)
    #         await attempt_delete(message)
    #
    #         await interaction.response.send_message(f'Quest `{quest_id}`: **{title}** deleted!', ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @edit_group.command(name='title')
    # async def title(self, interaction: discord.Interaction, quest_id: str, new_title: str):
    #     """
    #     Edits the quest's title.
    #
    #     Arguments:
    #     [quest_id]: The ID of the quest.
    #     [new_title]: The updated title.
    #     """
    #     guild_id = interaction.guild_id
    #     guild = self.bot.get_guild(guild_id)
    #     user_id = interaction.user.id
    #     # Get the quest board channel
    #     query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
    #     quest_channel_id = query['questChannel']
    #     quest_channel = guild.get_channel(quest_channel_id)
    #     error_title = None
    #     error_message = None
    #
    #     # Find the quest to edit
    #     collection = self.gdb['quests']
    #     quest = await collection.find_one({'questId': quest_id})
    #     if not quest:
    #         error_title = 'Error!'
    #         error_message = f'A quest with id {quest_id} was not found in the database!'
    #     # Confirm the user calling the command is the GM that created the quest
    #     elif not quest['gm'] == user_id:
    #         error_title = 'Quest Not Edited!'
    #         error_message = 'GMs can only manage their own quests!'
    #     else:
    #         # Push the edit to db, then grab an updated quest
    #         await collection.update_one({'questId': quest_id}, {'$set': {'title': new_title}})
    #         updated_quest = await collection.find_one({'questId': quest_id})
    #
    #         # Fetch the updated quest and build the embed, then edit the original post
    #         message = quest_channel.get_partial_message(updated_quest['messageId'])
    #         post_embed = await self.update_quest_embed(updated_quest)
    #         await message.edit(embed=post_embed)
    #
    #         await interaction.response.send_message('Quest Updated!', ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @edit_group.command(name='description')
    # async def description(self, interaction: discord.Interaction, quest_id: str, new_description: str):
    #     """
    #     Edits the description of the provided quest ID.
    #
    #     Arguments:
    #     [quest_id]: The ID of the quest.
    #     [new_description]: The updated description.
    #     """
    #     guild_id = interaction.guild_id
    #     guild = self.bot.get_guild(guild_id)
    #     user_id = interaction.user.id
    #     # Get the quest board channel
    #     query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
    #     quest_channel_id = query['questChannel']
    #     quest_channel = guild.get_channel(quest_channel_id)
    #     error_title = None
    #     error_message = None
    #
    #     # Find the quest to edit
    #     collection = self.gdb['quests']
    #     quest = await collection.find_one({'questId': quest_id})
    #     if not quest:
    #         error_title = 'Error!'
    #         error_message = f'A quest with id {quest_id} was not found in the database!'
    #     # Confirm the user calling the command is the GM that created the quest
    #     elif not quest['gm'] == user_id:
    #         error_title = 'Quest Not Edited!'
    #         error_message = 'GMs can only manage their own quests!'
    #     else:
    #         # Push the edit to db, then grab an updated quest
    #         await collection.update_one({'questId': quest_id}, {'$set': {'desc': new_description}})
    #         updated_quest = await collection.find_one({'questId': quest_id})
    #
    #         # Fetch the updated quest and build the embed, then edit the original post
    #         message = quest_channel.get_partial_message(updated_quest['messageId'])
    #         post_embed = await self.update_quest_embed(updated_quest)
    #         await message.edit(embed=post_embed)
    #
    #         await interaction.response.send_message('Quest Updated!', ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @edit_group.command(name='partysize')
    # async def party_size(self, interaction: discord.Interaction, quest_id: str, new_party_size: int):
    #     """
    #     Edits the max party size of the provided quest ID.
    #
    #     Arguments:
    #     [quest_id]: The ID of the quest.
    #     [new_party_size]: The updated party size.
    #     """
    #     guild_id = interaction.guild_id
    #     guild = self.bot.get_guild(guild_id)
    #     user_id = interaction.user.id
    #     # Get the quest board channel
    #     query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
    #     quest_channel_id = query['questChannel']
    #     quest_channel = guild.get_channel(quest_channel_id)
    #     error_title = None
    #     error_message = None
    #
    #     # Find the quest to edit
    #     collection = self.gdb['quests']
    #     quest = await collection.find_one({'questId': quest_id})
    #     if not quest:
    #         error_title = 'Error!'
    #         error_message = f'A quest with id {quest_id} was not found in the database!'
    #     # Confirm the user calling the command is the GM that created the quest
    #     elif not quest['gm'] == user_id:
    #         error_title = 'Quest Not Edited!'
    #         error_message = 'GMs can only manage their own quests!'
    #     else:
    #         # Push the edit to db, then grab an updated quest
    #         await collection.update_one({'questId': quest_id}, {'$set': {'maxPartySize': new_party_size}})
    #         updated_quest = await collection.find_one({'questId': quest_id})
    #
    #         # Fetch the updated quest and build the embed, then edit the original post
    #         message = quest_channel.get_partial_message(updated_quest['messageId'])
    #         post_embed = await self.update_quest_embed(updated_quest)
    #         await message.edit(embed=post_embed)
    #
    #         await interaction.response.send_message('Quest Updated!', ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @edit_group.command(name='levels')
    # async def levels(self, interaction: discord.Interaction, quest_id: str, new_levels: str):
    #     """
    #     Edits the advertised level range of the provided quest ID.
    #
    #     Arguments:
    #     [quest_id]: The ID of the quest.
    #     [new_levels]: The updated level range.
    #     """
    #     guild_id = interaction.guild_id
    #     guild = self.bot.get_guild(guild_id)
    #     user_id = interaction.user.id
    #     # Get the quest board channel
    #     query = await self.gdb['questChannel'].find_one({'guildId': guild_id})
    #     quest_channel_id = query['questChannel']
    #     quest_channel = guild.get_channel(quest_channel_id)
    #     error_title = None
    #     error_message = None
    #
    #     # Find the quest to edit
    #     collection = self.gdb['quests']
    #     quest = await collection.find_one({'questId': quest_id})
    #     if not quest:
    #         error_title = 'Error!'
    #         error_message = f'A quest with id {quest_id} was not found in the database!'
    #     # Confirm the user calling the command is the GM that created the quest
    #     elif not quest['gm'] == user_id:
    #         error_title = 'Quest Not Edited!'
    #         error_message = 'GMs can only manage their own quests!'
    #     else:
    #         # Push the edit to db, then grab an updated quest
    #         await collection.update_one({'questId': quest_id}, {'$set': {'levels': new_levels}})
    #         updated_quest = await collection.find_one({'questId': quest_id})
    #
    #         # Fetch the updated quest and build the embed, then edit the original post
    #         message = quest_channel.get_partial_message(updated_quest['messageId'])
    #         post_embed = await self.update_quest_embed(updated_quest)
    #         await message.edit(embed=post_embed)
    #
    #         await interaction.response.send_message('Quest Updated!', ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @edit_group.command(name='experience')
    # async def quest_experience(self, interaction: discord.Interaction, quest_id: str, experience: int):
    #     """
    #     Assigns a global experience reward to a quest.
    #
    #     Experience is awarded equally to each member of a quest party once the quest is completed.
    #
    #     Arguments:
    #     <quest_id>: The id of the quest to assign the reward.
    #     <experience>: The global experience reward for the quest. This value is given to each player.
    #     """
    #     guild_id = interaction.guild_id
    #     guild = self.bot.get_guild(guild_id)
    #     user_id = interaction.user.id
    #     member = guild.get_member(user_id)
    #     collection = self.gdb['quests']
    #     quest_query = await collection.find_one({'questId': quest_id})
    #     error_title = None
    #     error_message = None
    #
    #     if experience < 1:
    #         error_title = 'Error!'
    #         error_message = 'Experience must be a positive integer!'
    #     elif user_id != quest_query['gm'] and not member.guild_permissions.manage_guild:
    #         error_title = 'Quest Not Edited!'
    #         error_message = 'Quests can only be manipulated by their GM or staff!'
    #     else:
    #         title = quest_query['title']
    #         await collection.update_one({'questId': quest_id}, {'$set': {'xp': experience}}, upsert=True)
    #
    #         await interaction.response.send_message(f'Experience reward for quest `{quest_id}`: **{title}** set to '
    #                                                 f'{experience} per character!', ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)
    #
    # @edit_group.command(name='rewards')
    # async def quest_rewards(self, interaction: discord.Interaction, quest_id: str, recipients: str, reward_name: str,
    #                         quantity: int = 1):
    #     """
    #     Assigns item rewards to a quest for one, some, or all characters in the party.
    #
    #     Arguments:
    #     <quest_id>: The ID of the quest.
    #     <reward_name>: The name of the item to award.
    #     <quantity>: The quantity of the item to award each recipient.
    #     <recipients>: User mentions of recipients. Can be chained.
    #     """
    #     guild_id = interaction.guild_id
    #     guild = self.bot.get_guild(guild_id)
    #     user_id = interaction.user.id
    #     member = guild.get_member(user_id)
    #     collection = self.gdb['quests']
    #     quest_query = await collection.find_one({'questId': quest_id})
    #     error_title = None
    #     error_message = None
    #
    #     if quantity < 1:
    #         error_title = 'Quantity Error!'
    #         error_message = 'Quantity must be a positive integer!'
    #     elif not quest_query:
    #         error_title = 'Error!'
    #         error_message = f'A quest with id {quest_id} was not found in the database!'
    #     elif user_id != quest_query['gm'] and not member.guild_permissions.manage_guild:
    #         error_title = 'Quest Not Edited!'
    #         error_message = 'Quests can only be manipulated by their GM or staff!'
    #     else:
    #         title = quest_query['title']
    #         current_rewards = quest_query['rewards']
    #         party = quest_query['party']
    #         valid_players = []
    #         invalid_players = []
    #
    #         for player in recipients:
    #             user_id = strip_id(player)
    #             user_name = self.bot.get_user(user_id).name
    #             present = False
    #             for entry in party:
    #                 if str(user_id) in entry:
    #                     present = True
    #
    #             if not present:
    #                 invalid_players.append(user_name)
    #                 continue
    #             else:
    #                 valid_players.append(player)
    #
    #                 if str(user_id) in current_rewards and reward_name in current_rewards[f'{user_id}']:
    #                     current_quantity = current_rewards[f'{user_id}'][reward_name]
    #                     new_quantity = current_quantity + quantity
    #                     await collection.update_one({'questId': quest_id},
    #                                                 {'$set': {f'rewards.{user_id}.{reward_name}': new_quantity}},
    #                                                 upsert=True)
    #                 else:
    #                     await collection.update_one({'questId': quest_id},
    #                                                 {'$set': {f'rewards.{user_id}.{reward_name}': quantity}},
    #                                                 upsert=True)
    #
    #         if not valid_players:
    #             error_title = 'Error!'
    #             error_message = 'No valid players were provided!'
    #         else:
    #             update_embed = discord.Embed(title='Rewards updated!', type='rich',
    #                                          description=f'Quest ID: **{quest_id}**\n'
    #                                                      f'Title: **{title}**\n'
    #                                                      f'Reward: **{quantity}x {reward_name} each**')
    #             update_embed.add_field(name="Recipients", value='\n'.join(valid_players))
    #             update_embed.add_field(name='The following players were not found in the roster',
    #                                    value='\n'.join(invalid_players))
    #
    #             await interaction.response.send_message(embed=update_embed, ephemeral=True)
    #
    #     if error_message:
    #         error_embed = discord.Embed(title=error_title, description=error_message, type='rich')
    #         await interaction.response.send_message(embed=error_embed, ephemeral=True)


async def setup(bot):
    await bot.add_cog(QuestBoard(bot))
