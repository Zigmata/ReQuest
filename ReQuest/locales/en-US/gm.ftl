## Game Master module strings

# GM buttons
gm-btn-create = Create
gm-btn-edit-details = Edit Quest
gm-btn-toggle-ready = Toggle Ready
gm-btn-configure-rewards = Configure Rewards
gm-btn-remove-player = Remove Player
gm-btn-cancel-quest = Cancel Quest
gm-btn-manage-party-rewards = Manage Party Rewards
gm-btn-manage-individual-rewards = Manage Individual Rewards
gm-btn-join = Join
gm-btn-leave = Leave
gm-btn-complete-quest = Complete Quest
gm-btn-edit-details-modal = Edit Details
gm-btn-edit-images = Edit Images
gm-select-placeholder-party-role = Select a party role...
gm-modal-title-edit-details = Edit Quest Details
gm-modal-title-edit-images = Edit Quest Images
gm-btn-publish = Publish
gm-btn-update-post = Update Post

# GM modals
gm-modal-title-create-quest = Create New Quest
gm-modal-label-quest-title = Quest Title
gm-modal-placeholder-quest-title = Title of your quest
gm-modal-label-restrictions = Restrictions
gm-modal-placeholder-restrictions = Restrictions, if any, such as player levels
gm-modal-label-max-party = Maximum Party Size
gm-modal-placeholder-max-party = Max size of the party for this quest
gm-modal-label-party-role = Party Role
gm-modal-placeholder-party-role = Create a role for this quest (Optional)
gm-modal-label-description = Description
gm-modal-placeholder-description = Write the details of your quest here
gm-modal-label-image-url = Thumbnail URL
gm-modal-label-large-image-url = Large Image URL
gm-modal-placeholder-image-url = Enter an image URL (or leave blank to remove)
gm-modal-title-add-reward = Add Reward
gm-modal-label-experience = Experience Points
gm-modal-placeholder-experience = Enter a number
gm-modal-label-items = Items
gm-modal-placeholder-items =
    item: quantity
    item2: quantity
    etc.
gm-modal-title-add-summary = Add Quest Summary
gm-modal-label-summary = Summary
gm-modal-placeholder-summary = Add a story summary of the quest
gm-modal-title-modifying-player = Modifying { $playerName }
gm-modal-placeholder-xp-add-remove = Enter a positive or negative number.
gm-modal-label-inventory = Inventory
gm-modal-placeholder-inventory-modify =
    item: quantity
    item2: quantity
    etc.

# GM errors
gm-error-forbidden-role-name = The name provided for the party role is forbidden.
gm-error-role-already-exists = A role with that name already exists in this server.
gm-error-no-quest-channel = A channel has not yet been designated for quest posts. Contact a server admin to configure the Quest Channel.
gm-error-cannot-ping-announce = Could not ping announce role { $role } in channel { $channel }. Check channel and ReQuest role permissions with your server admin(s).
gm-error-invalid-item-format = Invalid item format: "{ $item }". Each item must be on a new line, and in the format "Name: Quantity".
gm-error-already-on-quest = You are already on this quest as { $characterName }.
gm-error-no-active-character-long = You do not have an active character on this server. Use `/player` to register or activate a character.
gm-error-quest-locked = Error joining quest {"**"}{ $questTitle }{"**"}: The quest is locked by the GM.
gm-error-quest-full = Error joining quest {"**"}{ $questTitle }{"**"}: The quest roster is full!
gm-error-not-signed-up = You are not signed up for this quest.
gm-error-quest-not-found = Quest no longer exists.
gm-error-quest-channel-not-set = Quest channel has not been set!
gm-error-empty-roster = You cannot complete a quest with an empty roster. Try cancelling instead.
gm-error-invalid-xp-value = XP value must be a positive integer!
gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role, then retry the operation.

# GM confirm modals
gm-modal-title-cancel-quest = Cancel Quest
gm-modal-label-cancel-quest = Type CONFIRM to cancel the quest.
gm-modal-title-remove-from-quest = Remove character from quest
gm-modal-label-remove-from-quest = Confirm character removal?

# GM DM embeds
gm-dm-title-quest-cancelled = Quest Cancelled
gm-dm-desc-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} was cancelled by the GM.
gm-dm-title-quest-ready = Quest Ready
gm-dm-desc-quest-ready = Quest {"**"}{ $questTitle }{"**"} is now ready! Your GM will begin the quest soon.
gm-dm-title-player-removed = Removed from Quest
gm-dm-desc-player-removed = You were removed from quest {"**"}{ $questTitle }{"**"} by the GM.
gm-dm-desc-player-removed-waitlist = You were removed from the wait list for quest {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Party Promotion
gm-dm-desc-party-promotion =
    You have been promoted to the main party for {"**"}{ $questTitle }{"**"}
    because a player left the quest.
gm-dm-title-roster-locked = Roster Locked
gm-dm-desc-roster-locked =
    The roster for {"**"}{ $questTitle }{"**"} has been locked
    and all party members have been notified.
gm-dm-title-roster-unlocked = Roster Unlocked
gm-dm-desc-roster-unlocked = The roster for {"**"}{ $questTitle }{"**"} has been unlocked.
gm-dm-title-player-removed-confirm = Player Removed
gm-dm-desc-player-removed-confirm =
    The player has been removed from {"**"}{ $questTitle }{"**"}
    and the quest roster has been updated.
gm-dm-footer-quest = Quest ID: { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    Your server admin has configured rewards for Game Masters when they complete
    quests. However, since you have no registered characters, your rewards could
    not be automatically issued at this time.
gm-dm-rewards-no-active-character =
    Your server admin has configured rewards for Game Masters when they complete
    quests. However, since you have no active character on this server, your rewards
    could not be automatically issued at this time.
gm-dm-rewards-issued = The following has been awarded to your active character, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.
gm-dm-role-not-found =
    ⚠️ The quest role (ID: { $roleId }) for quest {"**"}{ $questTitle }{"**"} no longer exists on the server.
    Role operations were skipped. Please notify a server administrator if this is unexpected.

# GM select menus
gm-select-placeholder-party-member = Select a party member
gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

# GM embeds
gm-embed-title-mod-report = GM Player Modification Report
gm-embed-field-experience = Experience
gm-embed-title-quest-complete = Quest Complete: { $questTitle }
gm-embed-title-quest-completed = QUEST COMPLETED: { $questTitle }
gm-embed-field-rewards = Rewards
gm-embed-field-party = __Party__
gm-embed-field-summary = Summary
gm-embed-title-gm-rewards = GM Rewards Issued
gm-embed-field-items = Items

# GM views
gm-title-main-menu = Game Master - Main Menu
gm-menu-quests = Quests
gm-menu-desc-quests = Create, edit, and manage quests.
gm-menu-players = Players
gm-menu-desc-players = Manage player inventories and modify characters.

gm-title-quest-management = Game Master - Quest Management
gm-desc-create-quest = Create a new quest.
gm-msg-no-quests = No quests found.
gm-label-quest-locked = (Locked)
gm-label-quest-draft = (Draft)
gm-title-manage-quest = Manage Quest - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Edit quest details such as title, description, and party size.
gm-title-edit-quest = Edit Quest - { $questTitle }
gm-label-field-not-set = Not set
gm-label-description-not-set = Description not set
gm-label-current-title = {"**"}Title:{"**"} { $value }
gm-label-current-description = {"**"}Description{"**"}
gm-label-current-restrictions = {"**"}Restrictions:{"**"} { $value }
gm-label-current-party-size = {"**"}Max Party Size:{"**"} { $value }
gm-label-current-party-role = {"**"}Party Role:{"**"} { $value }
gm-label-current-image = {"**"}Thumbnail{"**"}
gm-label-current-large-image = {"**"}Image{"**"}
gm-error-party-size-positive = Party size must be a positive number.
gm-error-party-size-too-small = Party size cannot be smaller than the current party ({ $currentSize } members).
gm-desc-toggle-ready = Toggle ready state (Current: {"**"}{ $status }{"**"})
    - Locks the quest roster and notifies party members that the quest will begin soon. If a role is configured, it will be assigned to party members when locked.
    - Unlocks the roster when set to Open.
gm-label-ready-locked = Locked/Ready
gm-label-ready-open = Open
gm-desc-configure-rewards = Configure rewards for the selected quest.
gm-desc-complete-quest = Complete a quest. Issues rewards, if any, to party members.
gm-desc-remove-player = Remove a player from the quest roster and notify them.
gm-desc-cancel-quest = Cancel the quest and delete it from the quest board.
gm-desc-publish-quest = Publish this quest to the quest board.
gm-desc-update-quest-post = Update the quest post on the quest board.
gm-error-role-name-forbidden = The role name "{ $roleName }" is forbidden on this server.
gm-error-role-name-exists = A role named "{ $roleName }" already exists on this server.
gm-title-player-management = Game Master - Player Management
gm-desc-player-management =
    These commands have migrated to context menus. Right-click (desktop) or long-press (mobile) a player's profile for the following menu options:

    - {"**"}Modify Player{"**"}: Add or remove items and experience from a player.
    - {"**"}View Player{"**"}: View a player's active character details.
gm-title-remove-player = Remove Player from Quest - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Player Removal Notes{"**"}__

    - Choose a player from the dropdown below to remove them from the quest roster.
    - If any players are on a wait list, the first player on the list will be promoted to the party.
    - Individual rewards for the removed player will be deleted from the quest.
    - If you wish to reward the player for prior contributions, use the `Modify Player` context menu to issue them rewards directly.
gm-label-no-players-in-roster = No players in quest roster
gm-title-character-sheet = Character Sheet for { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Experience Points:{"**"}__
gm-label-possessions = __{"**"}Possessions{"**"}__
gm-label-currency-heading = {"**"}Currency{"**"}
gm-msg-inventory-empty = Inventory is empty.

# GM approvals
