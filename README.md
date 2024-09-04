# ReQuest

A Discord bot for TTRPG communities.

Now open source! This bot is my own personal project to learn Python, asyncio, Discord, and many other things.

Made possible by [discord.py](https://discordpy.readthedocs.io/en/stable/) and [Motor](https://motor.readthedocs.io/en/stable/).

1. [Summary](#summary)
2. [Features](#features)
3. [Installation](#installation)

## Summary

ReQuest is a system-agnostic Discord bot designed to take the busy work out of running large TTRPG communities.

Server admins and game masters should be spending their time enjoying the games they love, not stressing over juggling
quest pings, creating roles, and validating every single transaction to deter cheaters. Likewise, players should be able
to trade amongst each other without needing to ping staff and hope someone is in their time zone.

## Features

#### System-Agnostic

ReQuest is designed to work for any system. Let your players, or your choice of specialty bot, handle the mechanics and
dice rolling. Let ReQuest handle all the boring busy work.

#### Hands-off Inventory Validation

With ReQuest, character inventories and experience are awarded from game masters only. Players cannot simply add things
to their characters; they must be received from another player's inventory or awarded directly from a Game Master or
quest. Players can freely trade without the need of GM oversight.

#### Automated Quest Lifecycle Management

Game Masters can create quests, modify details, assign party roles, and even award shared or individual loot, all
through a simple menu interface. Players sign themselves up directly, receive notifications when the Game Master is
ready to start, and automatically receive rewards (if any) once the quest is marked complete. Server admins can even
configure wait lists for quests, and an optional archive channel to view past adventures!

#### Fully-Custom Currency System

Define your currency, be it anything from credits and reputation, to gold or the U.S. Dollar. ReQuest keeps transactions
simple and makes change for you so you can get back to your adventures.

#### Easy User Interface

Forget typing lengthy commands just to miss a letter and have to start over. Every single function a game master,
player, or server admin needs, is under one command with easily-navigated menus.

#### Streamlined Help

Sick of typing `/help` every time you need to do something? Each menu page clearly outlines its functions so you don't
have to memorize the bot, or re-learn it when features are added.

#### Optional Player Message Board

Want your player characters to advertise their crafting? Looking to form an ad-hoc party for some role play? The message
board lets players post in-character in the same clean embed format as the quest board, letting server admins lock down
channels to prevent clutter.

#### Open Source

Tools that enhance TTRPGs and their communities don't deserve to be locked behind a paywall. ReQuest is licensed under
the GNU GPL v3 and will always be shared freely, forever.

## Installation

### Dependencies
- MongoDB version 5 or later.
- Python version 3.12 or later.
- A Discord bot application, using the process outlined [here](https://discord.com/developers/docs/getting-started).

> You'll need to read and understand bot scopes, permissions, and privileged intents for the bot to function. ReQuest
> requires access to the privileged gateways for presences, server members, and message content.

### Instructions

1. Clone this sucker and install the dependencies into your choice of environment.
2. Make sure your .gitignore is set up properly if you are running a public repo. You're going to want to ignore `config.yaml` in addition to your defaults.
3. Change the name of `config_template.yaml` to `config.yaml` and fill out accordingly. Don't forget your bot's token! AND DON'T LET ANYONE ELSE KNOW IT.
4. Run bot.py and everything *should* work.

### Special Considerations

- If you are running this bot locally, you can use the recommended default installation of mongoDB for your chosen OS,
  and a very simple connection string which is included in the setup hook for bot.py.
- If you are hosting this bot anywhere publicly accessible, it is highly recommended you familiarize yourself with
  mongoDB users and roles, and run your bot with specific credentials.

### Running ReQuest on Docker

- Coming Soon<sup>TM</sup>!

If you want to modify ReQuest, you will need to educate yourself on discord.py, cogs, extensions, and asyncio in order
to be marginally successful like me.

Don't forget to join the [Discord](https://discord.gg/Zq37gj4)!~~~~
