## Chaînes du module Administration

# Cog admin
admin-embed-title-unauthorized = Serveur non autorisé
admin-embed-desc-unauthorized =
    Merci de votre intérêt pour ReQuest ! Votre serveur ne figure pas dans la liste des serveurs de test autorisés de ReQuest.
    Veuillez rejoindre le Discord de support ci-dessous et contacter l'équipe de développement pour demander un accès de test.

    [Discord de développement ReQuest](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = Les commandes suivantes ont été synchronisées avec { $guildName }, ID { $guildId }
admin-embed-title-sync-global = Les commandes suivantes ont été synchronisées globalement
admin-error-missing-scope = ReQuest n'a pas le bon scope dans le serveur cible. Ajoutez la permission `applications.commands` et réessayez.
admin-error-sync-failed = Une erreur est survenue lors de la synchronisation des commandes : { $error }
admin-msg-commands-cleared = Commandes effacées.

# Boutons admin
admin-btn-shutdown = Arrêter
admin-modal-title-confirm-shutdown = Confirmer l'arrêt
admin-modal-label-shutdown-warning = Attention ! Cela va arrêter le bot. Tapez CONFIRM pour continuer.
admin-msg-shutting-down = Arrêt en cours !
admin-btn-add-server = Ajouter un nouveau serveur
admin-btn-load-cog = Charger un Cog
admin-msg-extension-loaded = Extension chargée avec succès : `{ $module }`
admin-btn-reload-cog = Recharger un Cog
admin-msg-extension-reloaded = Extension rechargée avec succès : `{ $module }`
admin-btn-output-guilds = Afficher la liste des serveurs
admin-msg-connected-guilds = Connecté à { $count } serveurs :

# Fenêtres modales admin
admin-modal-title-add-server = Ajouter un ID de serveur à la liste autorisée
admin-modal-label-server-name = Nom du serveur
admin-modal-placeholder-server-name = Entrez un nom court pour le serveur Discord
admin-modal-label-server-id = ID du serveur
admin-modal-placeholder-server-id = Entrez l'ID du serveur Discord
admin-select-placeholder-server = Sélectionnez un serveur à retirer
admin-modal-title-cog-action = { $action } un Cog
admin-modal-label-cog-name = Nom
admin-modal-placeholder-cog-name = Entrez le nom du Cog à { $action }

# Vues admin
admin-title-main-menu = Administration - Menu principal
admin-desc-allowlist = Configurer la liste autorisée des serveurs pour les restrictions d'invitation.
admin-desc-cogs = Charger ou recharger des cogs.
admin-desc-guild-list = Renvoie une liste de tous les serveurs dont le bot est membre.
admin-desc-shutdown = Arrête le bot
admin-title-allowlist = Administration - Liste autorisée des serveurs
admin-desc-allowlist-warning =
    Ajouter un nouvel ID de serveur Discord à la liste autorisée.
    {"**"}ATTENTION : Il n'y a aucun moyen de vérifier que l'ID de serveur fourni est valide sans que le bot soit membre du serveur. Vérifiez bien vos saisies !{"**"}
admin-msg-no-servers = Aucun serveur dans la liste autorisée.

# Fenêtres de confirmation admin
admin-modal-title-confirm-server-removal = Confirmer le retrait du serveur
admin-modal-label-server-removal = Retirer le serveur de la liste autorisée ?

# Vue des cogs admin
admin-title-cogs = Administration - Cogs
admin-desc-load-cog = Charger un cog du bot par son nom. Le fichier doit être nommé `<nom>.py` et stocké dans ReQuest/cogs/.
admin-desc-reload-cog = Recharger un cog chargé par son nom. Les mêmes restrictions de nom et de chemin s'appliquent.
