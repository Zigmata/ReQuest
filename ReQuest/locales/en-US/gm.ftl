## Game Master module strings

# GM buttons
gm-btn-create = Create
gm-btn-edit-details = Edit Details
gm-btn-toggle-ready = Toggle Ready
gm-btn-configure-rewards = Configure Rewards
gm-btn-remove-player = Remove Player
gm-btn-cancel-quest = Cancel Quest
gm-btn-manage-party-rewards = Manage Party Rewards
gm-btn-manage-individual-rewards = Manage Individual Rewards
gm-btn-join = Join
gm-btn-leave = Leave
gm-btn-complete-quest = Complete Quest
gm-btn-review-submission = Review Submission
gm-btn-approve = Approve
gm-btn-deny = Deny

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
gm-modal-title-editing-quest = Editing { $questTitle }
gm-modal-label-title = Title
gm-modal-label-max-party-size = Max Party Size
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
gm-modal-title-review-submission = Review Submission
gm-modal-label-submission-id = Submission ID
gm-modal-placeholder-submission-id = Enter the 8-char ID

# GM errors
gm-error-forbidden-role-name = The name provided for the party role is forbidden.
gm-error-role-already-exists = A role with that name already exists in this server.
gm-error-no-quest-channel = A channel has not yet been designated for quest posts. Contact a server admin to configure the Quest Channel.
gm-error-cannot-ping-announce = Could not ping announce role { $role } in channel { $channel }. Check channel and ReQuest role permissions with your server admin(s).
gm-error-invalid-item-format = Invalid item format: "{ $item }". Each item must be on a new line, and in the format "Name: Quantity".
gm-error-submission-not-found = Submission not found.
gm-error-already-on-quest = You are already on this quest as { $characterName }.
gm-error-no-active-character-long = You do not have an active character on this server. Use `/player` to register or activate a character.
gm-error-quest-locked = Error joining quest {"**"}{ $questTitle }{"**"}: The quest is locked by the GM.
gm-error-quest-full = Error joining quest {"**"}{ $questTitle }{"**"}: The quest roster is full!
gm-error-not-signed-up = You are not signed up for this quest.
gm-error-quest-channel-not-set = Quest channel has not been set!
gm-error-empty-roster = You cannot complete a quest with an empty roster. Try cancelling instead.

# GM confirm modals
gm-modal-title-cancel-quest = Cancel Quest
gm-modal-label-cancel-quest = Type CONFIRM to cancel the quest.
gm-modal-placeholder-cancel-quest = Type "CONFIRM" to proceed.
gm-modal-title-remove-from-quest = Remove character from quest
gm-modal-label-remove-from-quest = Confirm character removal?
gm-modal-placeholder-remove-from-quest = Type "CONFIRM" to proceed.

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} was cancelled by the GM.
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} is now ready!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} is no longer locked.
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} is now locked by the GM.
gm-dm-player-removed = You were removed from quest {"**"}{ $questTitle }{"**"}.
gm-dm-player-removed-waitlist = You were removed from the wait list for {"**"}{ $questTitle }{"**"}.
gm-dm-party-promotion = You have been added to the party for {"**"}{ $questTitle }{"**"}, due to a player dropping!

# GM select menus
gm-select-placeholder-party-member = Select a party member

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
gm-msg-player-removed = Player removed and quest roster updated!

# GM views
gm-title-main-menu = Game Master - Main Menu
gm-menu-quests = Quests
gm-menu-desc-quests = Create, edit, and manage quests.
gm-menu-players = Players
gm-menu-desc-players = Manage player inventories and modify characters.
gm-menu-approvals = Character Approvals
gm-menu-desc-approvals = Review and approve/deny character submissions.

gm-title-quest-management = Game Master - Quest Management
gm-desc-create-quest = Create a new quest.
gm-title-character-sheet = Character Sheet for { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Experience Points:{"**"}__
gm-label-possessions = __{"**"}Possessions{"**"}__
gm-label-currency-heading = {"**"}Currency{"**"}
gm-msg-inventory-empty = Inventory is empty.

# GM approvals
gm-title-approvals = Game Master - Inventory Approvals
gm-desc-review-submission = Enter a Submission ID to review and approve/deny it.
gm-title-reviewing = Reviewing: { $characterName }
gm-label-items = {"**"}Items:{"**"}
gm-label-currency = {"**"}Currency:{"**"}
gm-embed-title-approved = Inventory Update Approved
gm-embed-desc-approved = The inventory for {"**"}{ $characterName }{"**"} has been approved by { $approver }.
gm-embed-title-denied = Inventory Update Denied
gm-embed-desc-denied = The inventory for {"**"}{ $characterName }{"**"} has been denied by { $denier }.
