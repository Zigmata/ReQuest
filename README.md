# ReQuest
Bot for Discord TTRPG communities.

Now open source! This bot is my own personal project to learn Python, asyncio, Discord, and many other things.

Made possible by [discord.py](https://discordpy.readthedocs.io/en/stable/) and [Motor](https://motor.readthedocs.io/en/stable/).

## Installation

### Prerequesites
- MongoDB version 5 or later.
- Python version 3.7 or later.
- A Discord bot application, using the process outlined [here](https://discord.com/developers/docs/getting-started).
> You'll need to read and understand bot scopes, permissions, and privileged intents for the bot to function. ReQuest requires access to the privileged gateways for presences, server members, and message content. 

#### Package dependencies
- Motor version 2.5 or later
- discord.py version 2 or later
- Latest PyYAML and shortuuid

> Note as of April 2022: Motor will install PyMongo version 3.12+, do not manually upgrade your version of PyMongo to 4+ as it is incompatible with Motor at this time. Motor devs are including PyMongo 4+ support in Motor version 3.

Yes I know there's a way to automatically include pip dependencies, I'll incorporate that in this repo when I bother to learn it.

### Instructions

1. Clone this sucker and install the prereqs into your choice of environment.
2. Make sure your .gitignore is set up properly if you are running a public repo. You're going to want to ignore `config.yaml` in addition to your defaults.
3. Change the name of `config_template.yaml` to `config.yaml` and fill out accordingly. Don't forget your bot's token! AND DON'T LET ANYONE ELSE KNOW IT.
4. Run bot.py and everything *should* work.

If you want to modify the bot, you will need to educate yourself on discord.py, cogs, extensions, and asyncio in order to be marginally successful like me.

Don't forget to join the [Discord](https://discord.gg/Zq37gj4)!~~~~