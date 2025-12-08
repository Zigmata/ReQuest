# ReQuest

A Discord bot for TTRPG communities. [Official Website](https://request.gg)

![GitHub Release](https://img.shields.io/github/v/release/zigmata/request)

Don't forget to join the official development [Discord](https://discord.gg/Zq37gj4)!

Made possible by [discord.py](https://discordpy.readthedocs.io/en/stable/).

1. [Summary](#summary)
2. [Features](#features)
3. [Installation](#installation)

## Summary

ReQuest is a system-agnostic Discord bot designed to take the busy work out of running large TTRPG communities.

Server admins and game masters should be spending their time enjoying the games they love, not stressing over juggling
quest pings, creating roles, and validating every single transaction to deter cheaters. Likewise, players should be able
to trade amongst each other without needing to ping staff and hope someone is in their time zone.

## Features

### Automated Quest Lifecycle Management

Game Masters can create quests, modify details, assign party roles, and even award shared or individual loot, all
through a simple menu interface. Players sign themselves up directly, receive notifications when the Game Master is
ready to start, and automatically receive rewards (if any) once the quest is marked complete. Server admins can even
configure wait lists for quests, and an optional archive channel to view past adventures!

### Fully-Custom Currency System

Define your currency, be it anything from credits and reputation, to gold or the U.S. Dollar. ReQuest keeps transactions
simple and makes change for you so you can get back to your adventures.

### Hands-off Inventory Validation

With ReQuest, you can trust that everything in your players' inventories is legitimate. Game Masters can create rewards
as needed, and players can freely trade without the need of GM oversight.

### Customizable Shop System

Create automated shops in any channel you like. No more GMs being spammed with "buy" and "sell" requests. Players can
browse shop inventories, and make purchases directly using any of the server's defined currencies.

### Easy User Interface

Forget typing lengthy commands just to miss a letter and have to start over. Every single function a game master,
player, or server admin needs, is accessed via easily-navigated menus.

### System-Agnostic

ReQuest is designed to work for any system. Let your players, or your choice of specialty bot, handle the mechanics and
dice rolling. Let ReQuest handle all the boring busy work.

### Streamlined Help

Sick of typing `/help` every time you need to do something? Each menu page clearly outlines its functions so you don't
have to memorize the bot, or re-learn it when features are added.

### Server Configuration Wizard

New to ReQuest? No problem! The configuration wizard walks server admins through setting up the bot for their server,
step-by-step, while validating current settings to prevent misconfiguration.

### Optional Player Message Board

Want your player characters to advertise their crafting? Looking to form an ad-hoc party for some role play? The message
board lets players post in-character in the same clean embed format as the quest board, letting server admins lock down
channels to prevent clutter.

### Open Source

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

1. Clone this repository and install the dependencies into your choice of environment.
2. Make sure your .gitignore is set up properly if you are running a public repo.
3. Set your environment variables:
   - MONGO_USER: The user you created in mongoDB for the bot's specific access.
   - MONGO_PASSWORD: The password for the user above.
   - AUTH_DB: The database the user exists in (usually `admin`).
   > The three above variables are only needed if you are running mongoDB with authentication (recommended).
   - MONGO_HOST: The hostname/IP of your mongoDB server.
   - MONGO_PORT: The port your mongoDB service is hosted on.
   - BOT_TOKEN: The token for your Discord bot application. NEVER SHARE THIS!
   - GUILD_DB: The name of the database you want to use for guild documents (configs, quests, etc.).
   - MEMBER_DB: The name of the database you want to use for member documents (characters).
   - CONFIG_DB: The name of the database you want to use for bot configs (/admin menu)
   - VERSION: The version of the bot for informational purposes only.
   - LOAD_EXTENSIONS: String with comma-separated extension names, e.g. `gm`. See example below.
   - ALLOWLIST: True if you want to prohibit bot joins to a specific allowlist of guild IDs. False if you want to disable
    the allowlist.
4. Run bot.py and everything *should* work.

### Special Considerations

- If you are running this bot locally, you can use the recommended default installation of mongoDB for your chosen OS,
  and a very simple connection string which is included in the setup hook for bot.py.
- If you are hosting this bot anywhere publicly accessible, it is highly recommended you familiarize yourself with
  mongoDB users and roles, and run your bot with specific credentials and database access.

### Running ReQuest on Docker

Use the following docker compose to grab containers for [ReQuest](https://hub.docker.com/r/zigmata/request) and MongoDB:

> Note: You may want to specify a version tag for MongoDB rather than `latest`, depending on how frequently you pull 
> containers. MongoDB major versions require incremental updates with some manual configuration changes, so 
> inadvertently skipping an x.0 release may result in your database becoming inaccessible until you perform the necessary
> migration steps.

**docker-compose.yml**

```yaml
services:
  mongodb:
    image: mongodb/mongodb-community-server:latest
    container_name: mongodb
    #     environment:
    #       MONGO_INITDB_ROOT_USERNAME: # Give MongoDB an initial root username
    #       MONGO_INITDB_ROOT_PASSWORD: # Give MongoDB an initial root password
    restart: unless-stopped
  
  redis:
    image: redis:latest
    container_name: redis
    restart: unless-stopped

  request:
    image: zigmata/request:latest
    container_name: request
    environment:
      MONGO_USER: # Username if you are using auth in your mongoDB deployment
      MONGO_PASSWORD: # your mongo user password
      AUTH_DB: # name of the database your mongo user lives in
      MONGO_HOST: mongodb
      MONGO_PORT: 27017
      REDIS_HOST: redis
      REDIS_PORT: 6379
      BOT_TOKEN: # insert your bot's token here
      GUILD_DB: guilds
      MEMBER_DB: members
      CONFIG_DB: config
      VERSION: 1.2.7 # Doesn't affect functionality, just for info with the `/support` command
      LOAD_EXTENSIONS: admin, config, gm, info, player, shop
      ALLOWLIST: True
      LOG_LEVEL: INFO
      BOT_ACTIVITY: "Playing by Post" # Customize the displayed activity status
    depends_on:
      - mongodb
    restart: unless-stopped
```

### Docker Installation Notes

- The above example has commented-out lines for launching mongoDB with authentication. You can leave these commented out
  if security is not a concern (I.E. local deployment).
    - Make note of the mongoDB instantiation in the `setup_hook()` function of `bot.py`. There are two methods provided,
      one for a default unauthenticated connection, and one using an authenticated connection URI. Comment/un-comment 
      the appropriate lines as needed.
- You will not need to expose any ports past your host firewall if your mongoDB and ReQuest containers are on the same
  docker bridge network, and you are not going to access the db (for example, via mongosh) from outside its container. 
  Docker creates this bridge network by default if no network definitions are provided.
- If your bot runs on a publicly-accessible host, it is strongly recommended to research and implement best practices
  regarding mongoDB user authentication, least-privilege database access, and persistent database volume file security.
  You will also need to modify your docker-compose accordingly for specific volume mounts, users, etc. Guidance on these
  topics is well outside the scope of this README.
- A `dev` branch of this repo tracks any current feature implementation work and builds a corresponding `dev` tag in
  Docker Hub. Be warned when pulling this tag, for here there be dragons.
