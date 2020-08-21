import discord
import pymongo

async def delete_command(message):
    try:
        await message.delete()
    except discord.HTTPException:
        pass

#def has_gm_role():
#    def predicate(self, ctx):
#        db=self.bot.config
#        for role in ctx.author.roles:
#            if role.id in gmRoles:
#                return True

#        return False # TODO: Error reporting

#    return commands.check(predicate)