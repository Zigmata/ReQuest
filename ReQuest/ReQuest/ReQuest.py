import discord

client = discord.Client()
# TODO: load server settings from database

# declare global vars
postChannel = ''

# Print message on login
@client.event
async def on_ready():
	print('We have logged in as {0.user}'.format(client))

# Add commands here
@client.event
async def on_message(message):
	global postChannel

	if message.author == client.user:
		return
	
	# Command prefix set to r!
	# TODO: allow changing of command prefix
	if message.content[:2] == 'r!':
		args=message.content[2:].split()
		cmd=args[0]

	if cmd == 'hello':
		await message.channel.send('Hello!')

	if cmd == 'invite':
		await message.channel.send('Invite me to your server! <https://discordapp.com/api/oauth2/authorize?client_id=601492201704521765&permissions=388160&scope=bot>')

	if cmd == 'channel':
		postChannel = args[1]
		await message.channel.send('Successfully set quest channel to {0}!'.format(postChannel))

	if cmd == 'post':
		c = client.get_channel(int(postChannel.strip('<').strip('>').strip('#')))
		content = args[1]
		await c.send(content)

f=open('token.txt','r')
if f.mode == 'r':
	token=f.read()
f.close()

client.run(token)