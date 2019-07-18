import discord

client = discord.Client()

@client.event
async def on_ready():
	print('We have logged in as {0.user}'.format(client))

@client.event
async def on_message(message):
	if message.author == client.user:
		return

	if message.content.startswith('$hello'):
		await message.channel.send('Hello!')

	if message.content.startswith('$invite'):
		await message.channel.send('Invite me to your server! https://discordapp.com/api/oauth2/authorize?client_id=601492201704521765&permissions=388160&scope=bot')

f=open('token.txt','r')
if f.mode == 'r':
	token=f.read()
f.close()

client.run(token)