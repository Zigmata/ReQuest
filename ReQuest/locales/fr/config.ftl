## Chaînes du module Configuration

# ==========================================
# BOUTONS
# ==========================================

# Rôles
config-btn-clear = Effacer
config-btn-remove-gm-roles = Retirer les rôles GM
config-btn-forbidden-roles = Rôles interdits

# Quêtes
config-btn-toggle-quest-summary = Basculer le résumé de quête
config-btn-toggle-player-experience = Basculer l'expérience joueur
config-btn-toggle-display = Basculer l'affichage
config-btn-purge-player-board = Purger le tableau des joueurs
config-btn-add-modify-rewards = Ajouter/Modifier les récompenses

# Monnaie
config-btn-add-denomination = Ajouter une dénomination
config-btn-add-new-currency = Ajouter une nouvelle monnaie
config-btn-remove-currency = Supprimer la monnaie

# Boutiques - création
config-btn-add-shop-wizard = Ajouter une boutique (assistant)
config-btn-add-shop-json = Ajouter une boutique (JSON)
config-btn-edit-shop-wizard = Modifier la boutique (assistant)
config-btn-edit-shop-json = Modifier la boutique (JSON)
config-btn-remove-shop = Supprimer la boutique
config-btn-add-item = Ajouter un objet
config-btn-edit-shop-details = Modifier les détails de la boutique
config-btn-download-json = Télécharger le JSON
config-btn-done-editing = Modifications terminées
config-btn-scan-server-configs = Scanner les configurations du serveur
config-btn-re-scan = Re-scanner

# Boutique de nouveau personnage
config-btn-upload-json = Envoyer un JSON
config-btn-configure-new-character-wealth = Configurer la richesse de départ
config-btn-configure-new-character-shop = Configurer la boutique de nouveau personnage
config-btn-clear-shop = Vider la boutique
config-btn-configure-static-kits = Configurer les kits statiques
config-btn-new-character-settings = Paramètres de nouveau personnage
config-btn-disabled-no-currency = Désactivé (aucune monnaie configurée)
config-btn-disabled-no-wealth = Désactivé (aucune richesse de départ configurée)

# Kits statiques
config-btn-create-new-kit = Créer un nouveau kit
config-btn-delete-kit = Supprimer le kit
config-btn-add-currency = Ajouter une monnaie

# Jeu de rôle
config-btn-toggle-rp-rewards = Basculer les récompenses de RP
config-btn-clear-channels = Effacer les canaux
config-btn-edit-settings = Modifier les paramètres
config-btn-configure-rewards = Configurer les récompenses

# Stock
config-btn-stock-limits = Limites de stock
config-btn-set-limit = Définir la limite
config-btn-edit-limit = Modifier la limite
config-btn-remove-limit = Supprimer la limite
config-btn-configure-restock-schedule = Configurer le calendrier de réapprovisionnement
config-btn-back-to-shop-editor = Retour à l'éditeur de boutique

# Boutique en forum
config-btn-create-new-thread = Créer un nouveau fil
config-btn-use-existing-thread = Utiliser un fil existant

# Assistant
config-btn-quit = Quitter
config-btn-configure-channels = Configurer les canaux
config-btn-configure-roles = Configurer les rôles
config-btn-configure-quests = Configurer les quêtes
config-btn-configure-players = Configurer les joueurs
config-btn-configure-currency = Configurer la monnaie
config-btn-configure-rp-rewards = Configurer les récompenses de RP
config-btn-configure-shops = Configurer les boutiques
config-btn-new-char-setup = Config. nouveau perso.

# Titres des fenêtres de confirmation (passés au ConfirmModal commun)
config-modal-title-confirm-role-removal = Confirmer le retrait du rôle
config-modal-title-confirm-removal = Confirmer le retrait
config-modal-title-confirm-currency-removal = Confirmer la suppression de la monnaie
config-modal-title-confirm-shop-removal = Confirmer la suppression de la boutique
config-modal-title-confirm-kit-deletion = Confirmer la suppression du kit
config-modal-title-confirm-remove-stock-limit = Confirmer la suppression de la limite de stock
config-modal-title-clear-shop = Confirmer le vidage

# Libellés des fenêtres de confirmation
config-modal-label-remove-role = Retirer { $roleName } ?
config-modal-label-remove-denomination = Retirer { $denominationName } ?
config-modal-label-remove-currency = Retirer { $currencyName } ?
config-modal-label-shop-removal-warning = ATTENTION : Cette action est irréversible !
config-modal-label-kit-deletion-warning = ATTENTION : Irréversible !
config-modal-label-remove-stock-limit = Tapez CONFIRMER pour supprimer la limite de stock
config-modal-label-clear-shop = Supprimer tous les articles de cette boutique ?

# Messages d'erreur des boutons
config-error-shop-data-not-found = Erreur : Impossible de trouver les données de cette boutique.
config-msg-shop-json-download = Voici la définition JSON de {"**"}{ $shopName }{"**"}.
config-msg-new-char-shop-json-download = Voici la définition JSON de la boutique de nouveau personnage.
config-error-select-forum-first = Veuillez d'abord sélectionner un canal forum.
config-error-select-thread-first = Veuillez d'abord sélectionner un fil.

# ==========================================
# FENÊTRES MODALES
# ==========================================

# AddCurrencyTextModal
config-modal-title-add-currency = Ajouter une nouvelle monnaie
config-modal-label-currency-name = Nom de la monnaie
config-error-currency-already-exists = Une monnaie ou une dénomination nommée { $name } existe déjà !

# RenameCurrencyModal
config-modal-title-rename-currency = Renommer la monnaie
config-modal-label-new-currency-name = Nouveau nom de la monnaie
config-error-currency-name-exists = Une monnaie nommée « { $name } » existe déjà.
config-error-denomination-name-exists = Une dénomination nommée « { $name } » existe déjà.

# RenameDenominationModal
config-modal-title-rename-denomination = Renommer la dénomination
config-modal-label-new-denomination-name = Nouveau nom de la dénomination

# AddCurrencyDenominationModal
config-modal-title-add-denomination = Ajouter une dénomination de { $currencyName }
config-modal-label-denomination-name = Nom
config-modal-placeholder-denomination-name = ex. : Argent
config-modal-label-denomination-value = Valeur
config-modal-placeholder-denomination-value = ex. : 0.1
config-error-denomination-matches-currency = Le nom de la nouvelle dénomination ne peut pas correspondre à une monnaie existante sur ce serveur ! Monnaie existante trouvée nommée « { $existingName } ».
config-error-denomination-matches-denomination = Le nom de la nouvelle dénomination ne peut pas correspondre à une dénomination existante sur ce serveur ! Dénomination existante trouvée nommée « { $denominationName } » sous la monnaie nommée « { $currencyName } ».
config-error-denomination-value-exists = Les dénominations d'une même monnaie doivent avoir des valeurs uniques ! { $denominationName } a déjà cette valeur assignée.

# ForbiddenRolesModal
config-modal-title-forbidden-roles = Noms de rôles interdits
config-modal-label-names = Noms
config-modal-placeholder-names = Entrez les noms séparés par des virgules
config-msg-forbidden-roles-updated = Rôles interdits mis à jour !

# PlayerBoardPurgeModal
config-modal-title-purge-player-board = Purger le tableau des joueurs
config-modal-label-age = Âge
config-modal-placeholder-age = Entrez l'âge maximum des publications (en jours) à conserver
config-msg-posts-purged = Les publications de plus de { $days } jours ont été purgées !

# GMRewardsModal
config-modal-title-gm-rewards = Ajouter/Modifier les récompenses GM
config-modal-label-experience = Expérience
config-modal-placeholder-enter-number = Entrez un nombre
config-modal-label-items = Objets
config-modal-placeholder-items =
    Nom : Quantité
    Nom2 : Quantité
    etc.
config-error-experience-invalid = L'expérience doit être un entier valide (ex. : 2000).
config-error-item-format-invalid = Format d'objet invalide : « { $item } ». Chaque objet doit être sur une nouvelle ligne, au format « Nom : Quantité ».

# ConfigShopDetailsModal
config-modal-title-shop-details = Ajouter/Modifier les détails de la boutique
config-modal-label-shop-channel = Sélectionner un canal
config-modal-placeholder-shop-channel = Sélectionnez le canal pour cette boutique
config-modal-label-shop-name = Nom de la boutique
config-modal-placeholder-shop-name = Entrez le nom de la boutique
config-modal-label-shopkeeper-name = Nom du commerçant
config-modal-placeholder-shopkeeper-name = Entrez le nom du commerçant
config-modal-label-shop-description = Description de la boutique
config-modal-placeholder-shop-description = Entrez une description pour la boutique
config-modal-label-shop-image-url = URL de l'image de la boutique
config-modal-placeholder-shop-image-url = Entrez une URL pour l'image de la boutique
config-error-no-channel-selected = Aucun canal sélectionné pour la boutique.
config-error-shop-already-in-channel = Une boutique est déjà enregistrée dans le canal sélectionné. Veuillez choisir un autre canal ou modifier la boutique existante.

# build_shop_header_view
config-label-shopkeeper = {"**"}Commerçant :{"**"} { $name }
config-msg-use-shop-command = Utilisez la commande `/shop` pour parcourir et acheter des objets.

# ForumThreadShopModal
config-modal-title-forum-thread-shop = Créer une boutique en fil de forum
config-modal-label-thread-name = Nom du fil
config-modal-placeholder-thread-name = Entrez le nom du fil de la boutique
config-error-forum-not-found = Impossible de trouver le canal forum sélectionné.
config-error-shop-already-in-thread = Une boutique est déjà enregistrée dans ce fil. Cela ne devrait pas arriver pour un nouveau fil.

# ConfigShopJSONModal
config-modal-title-add-shop-json = Ajouter une nouvelle boutique via JSON
config-modal-label-upload-json = Envoyez un fichier .json contenant les données de la boutique
config-error-no-json-uploaded = Aucun fichier JSON envoyé pour la boutique.
config-error-file-must-be-json = Le fichier envoyé doit être un fichier JSON (.json).
config-error-invalid-json = Format JSON invalide : { $error }
config-error-json-validation-failed = Le JSON n'est pas conforme au schéma : { $error }

# ShopItemModal
config-modal-title-shop-item = Ajouter/Modifier un objet de boutique
config-modal-label-item-name = Nom de l'objet
config-modal-placeholder-item-name = Entrez le nom de l'objet
config-modal-label-item-description = Description de l'objet
config-modal-placeholder-item-description = Entrez une description pour l'objet
config-modal-label-item-quantity = Quantité de l'objet
config-modal-placeholder-item-quantity = Entrez la quantité vendue par achat
config-modal-label-item-costs = Coûts de l'objet
config-modal-placeholder-item-costs = Ex. : 10 or + 5 argent\nOU : 50 rep\n(Utilisez + pour ET, Nouvelles lignes pour OU)
config-error-item-quantity-positive = La quantité de l'objet doit être un entier positif.
config-error-cost-format-invalid = Format de coût invalide dans l'option : « { $option } ». Chaque coût doit comporter un montant et une monnaie séparés par un espace, ex. : « 10 or ».
config-error-cost-amount-invalid = Montant invalide « { $amount } » pour la monnaie : « { $currency } ». Le montant doit être un nombre positif.
config-error-unknown-currency = Monnaie inconnue `{ $currency }`. Veuillez utiliser une monnaie valide configurée pour ce serveur.
config-error-item-already-exists = Un objet nommé { $itemName } existe déjà dans cette boutique.

# ConfigUpdateShopJSONModal
config-modal-title-update-shop-json = Mettre à jour la boutique via JSON
config-modal-label-upload-new-json = Envoyer une nouvelle définition JSON
config-error-no-file-uploaded = Aucun fichier n'a été envoyé.
config-error-file-must-be-json-ext = Le fichier doit être un fichier `.json`.
config-error-json-validation-message = Échec de la validation JSON : { $error }

# NewCharacterShopItemModal
config-modal-title-new-char-item = Ajouter/Modifier l'équipement de nouveau personnage
config-modal-placeholder-item-quantity-selection = Entrez la quantité reçue par sélection
config-modal-label-item-cost = Coût de l'objet
config-error-cost-format-short = Format de coût invalide : « { $component } ». Attendu « Montant Monnaie ».
config-error-amount-invalid-short = Montant invalide « { $amount } » pour la monnaie « { $currency } ».
config-error-item-exists-new-char = Un objet nommé { $itemName } existe déjà dans la boutique de nouveau personnage.

# NewCharacterShopJSONModal
config-modal-title-upload-new-char-json = Envoyer la boutique de nouveau personnage (JSON)
config-error-no-json-uploaded-short = Aucun fichier JSON envoyé.
config-error-json-must-have-shopstock = Le JSON doit contenir un tableau « shopStock ».
config-error-items-must-have-name-price = Tous les objets doivent avoir un « name » et un « price ».

# ConfigNewCharacterWealthModal
config-modal-title-set-wealth = Définir la richesse de nouveau personnage
config-modal-label-amount = Montant
config-modal-placeholder-amount = Entrez le montant de cette monnaie.
config-modal-placeholder-currency-name = Entrez le nom d'une monnaie définie sur ce serveur
config-error-no-currencies-configured = Aucune monnaie n'est configurée sur ce serveur.
config-error-currency-not-found = Monnaie ou dénomination nommée { $name } introuvable. Veuillez utiliser une monnaie valide.

# CreateStaticKitModal
config-modal-title-create-kit = Créer un nouveau kit statique
config-modal-label-kit-name = Nom du kit
config-modal-placeholder-kit-name = ex. : Kit de démarrage guerrier
config-modal-label-description = Description
config-modal-placeholder-kit-description = Description facultative pour ce kit
config-error-kit-name-exists = Un kit statique nommé « { $kitName } » existe déjà. Veuillez choisir un autre nom.

# StaticKitItemModal
config-modal-title-kit-item = Ajouter/Modifier un objet du kit
config-modal-placeholder-kit-item-quantity = Entrez la quantité de cet objet à inclure dans le kit

# StaticKitCurrencyModal
config-modal-title-kit-currency = Ajouter une monnaie au kit
config-modal-placeholder-currency-eg = ex. : Or
config-modal-placeholder-amount-eg = ex. : 100
config-error-amount-must-be-number = Le montant doit être un nombre.
config-error-amount-exceeds-maximum = Le montant ne peut pas dépasser { $max }.
config-error-no-currencies-on-server = Aucune monnaie configurée sur le serveur.
config-error-currency-not-found-short = Monnaie « { $currency } » introuvable.
config-error-denomination-not-found = Dénomination « { $denomination } » introuvable dans la configuration des monnaies.

# RoleplaySettingsModal
config-modal-title-rp-settings = Paramètres de jeu de rôle
config-modal-label-min-message-length = Longueur minimale du message (caractères)
config-modal-placeholder-min-message-length = Nombre de caractères requis pour qu'un message soit éligible. 0 pour aucune limite
config-modal-label-cooldown = Temps de recharge (secondes)
config-modal-placeholder-cooldown = Temps d'attente, en secondes, entre les messages comptés comme éligibles aux récompenses
config-modal-label-message-threshold = Seuil de messages
config-modal-placeholder-message-threshold = Nombre de messages requis pour déclencher la récompense
config-modal-label-frequency = Fréquence (nombre de messages)
config-modal-placeholder-frequency = Nombre de messages éligibles requis pour gagner des récompenses
config-error-min-length-invalid = La longueur minimale du message doit être un entier non négatif.
config-error-cooldown-invalid = Le temps de recharge doit être un entier non négatif.
config-error-threshold-invalid = Le seuil de messages doit être un entier positif.
config-error-frequency-invalid = La fréquence doit être un entier positif.

# RoleplayRewardsModal
config-modal-title-rp-rewards = Configurer les récompenses de jeu de rôle
config-modal-label-items-name-quantity = Objets (Nom : Quantité)
config-modal-label-currency-name-amount = Monnaie (Nom : Montant)
config-error-experience-non-negative = L'expérience doit être un entier non négatif.
config-error-item-quantity-positive-named = La quantité pour « { $itemName } » doit être un entier positif.
config-error-currency-amount-positive = Le montant pour « { $currencyName } » doit être un nombre positif.

# SetItemStockModal
config-modal-title-stock-limit = Limite de stock : { $itemName }
config-modal-label-max-stock = Stock maximum
config-modal-placeholder-max-stock = Entrez le stock maximum (ex. : 10)
config-modal-label-current-stock = Stock actuel
config-modal-placeholder-current-stock = Entrez le stock disponible actuel
config-modal-label-restock-increment = Quantité de réappro. (par cycle)
config-modal-placeholder-restock-increment = Quantité ajoutée par cycle (par défaut : 1)
config-error-max-stock-positive = Le stock maximum doit être un entier positif.
config-error-current-stock-non-negative = Le stock actuel doit être un entier non négatif.
config-error-current-exceeds-max = Le stock actuel ne peut pas dépasser le stock maximum.
config-error-item-not-in-shop = L'objet « { $itemName } » est introuvable dans la boutique.

# RestockScheduleModal
config-modal-title-restock-schedule = Configurer le calendrier de réapprovisionnement
config-modal-restock-schedule-label = Planification
config-modal-restock-schedule-none = Aucun (Désactivé)
config-modal-restock-schedule-hourly = Toutes les heures
config-modal-restock-schedule-daily = Quotidien
config-modal-restock-schedule-weekly = Hebdomadaire
config-modal-label-time = Heure (HH:MM en UTC)
config-modal-desc-current-time = Heure actuelle : { $utcTime }
config-modal-placeholder-time = ex. : 14:30 pour 14h30 UTC
config-modal-restock-day-label = Jour de la semaine (hebdomadaire uniquement)
config-modal-restock-mode-label = Mode de réapprovisionnement
config-modal-restock-mode-full = Complet (réinitialiser au maximum)
config-modal-restock-mode-incremental = Incrémentiel (ajouter une quantité)
config-error-time-format-invalid = L'heure doit être au format HH:MM (ex. : 14:30).
config-error-increment-positive = Le montant incrémental doit être un entier positif.

# ==========================================
# SÉLECTEURS
# ==========================================

# SingleChannelConfigSelect
config-select-placeholder-channel = Recherchez votre canal { $configName }

# QuestAnnounceRoleSelect
config-select-placeholder-announce-role = Choisissez votre rôle d'annonce de quête

# AddGMRoleSelect
config-select-placeholder-gm-roles = Choisissez votre/vos rôle(s) GM

# ConfigWaitListSelect
config-select-placeholder-wait-list = Sélectionnez la taille de la liste d'attente
config-select-option-disabled = 0 (Désactivé)

# InventoryTypeSelect
config-select-placeholder-inventory-mode = Sélectionnez le mode d'inventaire
config-select-option-disabled-label = Désactivé
config-select-desc-disabled = Les joueurs commencent avec des inventaires vides.
config-select-option-selection = Sélection
config-select-desc-selection = Les joueurs choisissent librement des objets dans la boutique de nouveau personnage.
config-select-option-purchase = Achat
config-select-desc-purchase = Les joueurs achètent des objets dans la boutique de nouveau personnage avec un montant de monnaie donné.
config-select-option-open = Ouvert
config-select-desc-open = Les joueurs saisissent manuellement leur propre inventaire.
config-select-option-static = Statique
config-select-desc-static = Les joueurs reçoivent un inventaire de départ prédéfini.

# RoleplayChannelSelect
config-select-placeholder-rp-channels = Sélectionnez les canaux éligibles

# RoleplayModeSelect
config-select-placeholder-rp-mode = Sélectionnez le mode
config-select-option-scheduled = Planifié
config-select-desc-scheduled = Les récompenses sont accordées une fois dans une période de réinitialisation définie.
config-select-option-accrued = Cumulé
config-select-desc-accrued = Les récompenses sont accordées de manière répétée en fonction des niveaux d'activité définis.

# RoleplayResetSelect
config-select-placeholder-reset-period = Sélectionnez la période de réinitialisation
config-select-option-hourly = Toutes les heures
config-select-desc-hourly = Réinitialisation toutes les heures.
config-select-option-daily = Quotidien
config-select-desc-daily = Réinitialisation toutes les 24 heures.
config-select-option-weekly = Hebdomadaire
config-select-desc-weekly = Réinitialisation tous les 7 jours.

# RoleplayResetDaySelect
config-select-placeholder-reset-day = Sélectionnez le jour de réinitialisation

# RoleplayResetTimeSelect
config-select-placeholder-reset-time = Sélectionnez l'heure de réinitialisation (UTC)
config-select-option-utc-time = { $hour }:00 UTC

# ForumChannelSelect
config-select-placeholder-forum-channel = Sélectionnez un canal forum

# ForumThreadSelect
config-select-placeholder-thread = Sélectionnez un fil
config-select-option-no-threads = Aucun fil actif trouvé
config-select-desc-no-threads = Créez un nouveau fil ou vérifiez les fils archivés
config-select-option-select-forum-first = Sélectionnez d'abord un forum
config-select-desc-select-forum-first = Veuillez sélectionner un canal forum ci-dessus
config-select-desc-thread-id = ID du fil : { $threadId }
config-error-select-valid-thread = Veuillez sélectionner un fil valide ou en créer un nouveau.
config-error-thread-not-found = Impossible de trouver le fil sélectionné. Il a peut-être été supprimé ou archivé.

# ==========================================
# VUES
# ==========================================

## Menu principal
config-title-main-menu = Configuration du serveur - Menu principal
config-menu-config-wizard = Assistant de configuration
config-menu-desc-config-wizard = Vérifiez que votre serveur est prêt à utiliser ReQuest avec un scan rapide.
config-menu-channels = Canaux
config-menu-desc-channels = Définir les canaux désignés pour les publications de ReQuest.
config-menu-currency = Monnaie
config-menu-desc-currency = Paramètres globaux de monnaie.
config-menu-players = Joueurs
config-menu-desc-players = Paramètres globaux des joueurs, comme le suivi des points d'expérience.
config-menu-quests = Quêtes
config-menu-desc-quests = Paramètres globaux des quêtes, comme les listes d'attente.
config-menu-rp-rewards = Récompenses de RP
config-menu-desc-rp-rewards = Configurer les récompenses de jeu de rôle.
config-menu-roles = Rôles
config-menu-desc-roles = Options de configuration pour les rôles mentionnables ou privilégiés.
config-menu-shops = Boutiques
config-menu-desc-shops = Configurer les boutiques personnalisées.
config-menu-language = Langue
config-menu-desc-language = Définir la langue par défaut pour ce serveur.

## Vue de l'assistant
config-title-wizard = {"**"}Configuration du serveur - Assistant{"**"}
config-wizard-intro =
    {"**"}Bienvenue dans l'assistant de configuration ReQuest !{"**"}

    Cet assistant vous aidera à vous assurer que votre serveur est correctement configuré pour utiliser les fonctionnalités de ReQuest.
    Il analysera vos paramètres actuels et fournira des recommandations pour les ajustements nécessaires.

    Utilisez le bouton « Lancer le scan » ci-dessous pour démarrer le processus de validation. Une fois le scan terminé,
    vous recevrez un rapport détaillé de la configuration de votre serveur ainsi que les modifications recommandées.

# Assistant - Validation des permissions du bot
config-wizard-bot-permissions-header = __{"**"}Permissions globales du bot{"**"}__
config-wizard-bot-permissions-desc = Cette section vérifie que ReQuest dispose des permissions correctes pour fonctionner correctement.
config-wizard-bot-role = Rôle du bot : { $roleMention }
config-wizard-status-warnings = {"**"}Statut : ⚠️ AVERTISSEMENTS TROUVÉS{"**"}
config-wizard-missing-perm = - ⚠️ Manquante : `{ $permissionName }`
config-wizard-ensure-permissions = Veuillez vous assurer que le rôle le plus élevé du bot dispose de ces permissions accordées globalement.
config-wizard-status-ok = {"**"}Statut : ✅ OK{"**"}
config-wizard-bot-permissions-ok = Le bot dispose de toutes les permissions globales requises.
config-wizard-status-scan-failed = {"**"}Statut : ❌ ÉCHEC DU SCAN{"**"}
config-wizard-scan-error = Une erreur inattendue est survenue lors de la vérification des permissions du bot.
config-wizard-error-type = Erreur : { $errorType }
config-wizard-required-permissions = {"**"}Permissions requises pour le rôle du bot :{"**"}

# Assistant - Noms des permissions
config-wizard-perm-view-channels = Voir les canaux
config-wizard-perm-manage-roles = Gérer les rôles
config-wizard-perm-send-messages = Envoyer des messages
config-wizard-perm-attach-files = Joindre des fichiers
config-wizard-perm-add-reactions = Ajouter des réactions
config-wizard-perm-use-external-emoji = Utiliser des émojis externes
config-wizard-perm-manage-messages = Gérer les messages
config-wizard-perm-read-message-history = Lire l'historique des messages

# Assistant - Validation des rôles
config-wizard-role-header = __{"**"}Configurations des rôles{"**"}__
config-wizard-role-desc =
    Cette section vérifie les éléments suivants :

    - Les rôles GM (requis) et le rôle d'annonce (facultatif) sont configurés.
    - Le rôle par défaut (@everyone) dispose des permissions requises pour que les utilisateurs accèdent aux fonctionnalités du bot.
    - Le rôle par défaut (@everyone) ne dispose pas de permissions dangereuses.
    - Les rôles GM et d'annonce sont vérifiés pour détecter toute escalade de permissions au-delà du rôle par défaut.

    Les avertissements ici sont uniquement des recommandations basées sur une configuration par défaut. Selon les besoins de votre serveur, vous pouvez avoir des raisons d'ignorer certaines de ces recommandations.

config-wizard-default-role-label = {"**"}Rôle par défaut :{"**"}
config-wizard-default-role-dangerous = ⚠️ @everyone : Permissions dangereuses trouvées :
config-wizard-default-role-ok = - ✅ @everyone : OK
config-wizard-missing-permission = - Permission manquante : `{ $permissionName }`
config-wizard-gm-roles-label = {"**"}Rôles GM :{"**"}
config-wizard-no-gm-roles = - ⚠️ Aucun rôle GM configuré
config-wizard-role-not-found = - ⚠️ {"**"}{ $roleName } :{"**"} Rôle configuré introuvable/supprimé du serveur
config-wizard-role-ok = - ✅ { $roleMention } : OK
config-wizard-announcement-role-label = {"**"}Rôle d'annonce :{"**"}
config-wizard-no-announcement-role = - ℹ️ Aucun rôle d'annonce configuré
config-wizard-announcement-role-not-found = - ⚠️ Rôle configuré introuvable/supprimé du serveur
config-wizard-escalation-detected = - ⚠️ { $roleMention } : Escalades de permissions détectées - { $escalations }
config-wizard-escalation-more = , et { $count } de plus...

# Assistant - Permissions par défaut requises
config-wizard-perm-send-messages-in-threads = Envoyer des messages dans les fils
config-wizard-perm-use-application-commands = Utiliser les commandes d'application

# Assistant - Permissions dangereuses
config-wizard-perm-manage-channels = Gérer les canaux
config-wizard-perm-manage-webhooks = Gérer les webhooks
config-wizard-perm-manage-server = Gérer le serveur
config-wizard-perm-manage-nicknames = Gérer les pseudonymes
config-wizard-perm-kick-members = Expulser des membres
config-wizard-perm-ban-members = Bannir des membres
config-wizard-perm-timeout-members = Exclure temporairement des membres
config-wizard-perm-mention-everyone = Mentionner @everyone
config-wizard-perm-manage-threads = Gérer les fils
config-wizard-perm-administrator = Administrateur

# Assistant - Validation des canaux
config-wizard-channel-header = __{"**"}Configurations des canaux{"**"}__
config-wizard-channel-desc =
    Cette section vérifie les éléments suivants :

    - Les canaux configurés existent.
    - Le bot a la permission de voir et d'envoyer des messages dans les canaux configurés.
    - Le rôle par défaut (@everyone) n'a pas la permission « Envoyer des messages ».

config-wizard-channel-no-config-required = - ⚠️ Aucun canal configuré
config-wizard-channel-not-configured = - ℹ️ Non configuré (facultatif)
config-wizard-channel-not-found = - ⚠️ Canal configuré introuvable/supprimé du serveur
config-wizard-channel-ok = - ✅ OK
config-wizard-bot-cannot-view = - ⚠️ { $botMention } ne peut pas voir ce canal.
config-wizard-bot-cannot-send = - ⚠️ { $botMention } ne peut pas envoyer de messages dans ce canal.
config-wizard-everyone-can-send = - ⚠️ @everyone peut envoyer des messages dans ce canal.

# Assistant - Noms des canaux
config-wizard-channel-quest-board = Tableau des quêtes
config-wizard-channel-player-board = Tableau des joueurs
config-wizard-channel-quest-archive = Archive des quêtes
config-wizard-channel-gm-transaction-log = Journal des transactions GM
config-wizard-channel-player-transaction-log = Journal des transactions joueurs
config-wizard-channel-shop-log = Journal des boutiques
config-wizard-channel-approval-queue = File d'approbation des personnages

# Assistant - Tableau de bord
config-wizard-dashboard-header = __{"**"}Tableau de bord des paramètres{"**"}__
config-wizard-dashboard-desc = Cette section fournit un aperçu des configurations non essentielles pour référence rapide.
config-wizard-quest-settings = {"**"}Paramètres des quêtes{"**"}
config-wizard-quest-wait-list = - Taille de la liste d'attente des quêtes : { $size }
config-wizard-quest-summary = - Résumé de quête : { $status }
config-wizard-gm-rewards-per-quest = {"**"}Récompenses GM (par quête){"**"}
config-wizard-player-settings = {"**"}Paramètres des joueurs{"**"}
config-wizard-player-experience = - Expérience joueur : { $status }
config-wizard-currency-settings = {"**"}Paramètres de monnaie{"**"}
config-wizard-rp-rewards = {"**"}Récompenses de jeu de rôle{"**"}
config-wizard-rp-status = - Statut : { $status }
config-wizard-rp-mode = - Mode : { $mode }
config-wizard-rp-channels = - Canaux surveillés : { $count }
config-wizard-shops = {"**"}Boutiques{"**"}
config-wizard-shops-count = - Boutiques configurées : { $count }
config-wizard-shops-more = - ...et { $count } de plus
config-wizard-new-char-setup = {"**"}Configuration de nouveau personnage{"**"}
config-wizard-inventory-type = - Type d'inventaire : { $type }
config-wizard-new-char-shop-items = - Objets de la boutique de nouveau personnage : { $count }
config-wizard-static-kits = - Kits statiques : { $count }

# Assistant - Rapport des récompenses GM
config-wizard-no-currencies = - ℹ️ Aucune monnaie configurée
config-wizard-configured-currencies = {"**"}Monnaies configurées :{"**"}
config-wizard-no-denominations = - Aucune dénomination configurée
config-wizard-gm-rewards-disabled = {"**"}Statut :{"**"} Désactivé
config-wizard-gm-rewards-enabled = {"**"}Statut :{"**"} Activé
config-wizard-gm-rewards-experience = - Expérience : { $xp }
config-wizard-gm-rewards-items = - Objets :
config-wizard-unnamed-shop = Boutique sans nom

## Vue des rôles
config-title-roles = {"**"}Configuration du serveur - Rôles{"**"}
config-label-announcement-role = {"**"}Rôle d'annonce :{"**"} { $status }
config-desc-announcement-role = Ce rôle est mentionné lorsqu'une quête est publiée.
config-label-announcement-role-default = {"**"}Rôle d'annonce :{"**"} Non configuré
config-label-gm-roles = {"**"}Rôle(s) GM :{"**"} { $roles }
config-desc-gm-roles = Ces rôles accorderont l'accès aux commandes et fonctionnalités de Game Master.
config-label-gm-roles-default = {"**"}Rôle(s) GM :{"**"} Non configuré
config-title-forbidden-roles = __{"**"}Rôles interdits{"**"}__
config-desc-forbidden-roles =
    Configure une liste de noms de rôles qui ne peuvent pas être utilisés par les Game Masters pour leurs rôles de groupe.
    Par défaut, `everyone`, `administrator`, `gm` et `game master` ne peuvent pas être utilisés. Cette configuration
    étend cette liste.

## Vue de retrait des rôles GM
config-title-remove-gm-roles = {"**"}Configuration du serveur - Retirer les rôle(s) GM{"**"}
config-msg-no-gm-roles = Aucun rôle GM configuré.

## Vue des canaux
config-title-channels = {"**"}Configuration du serveur - Canaux{"**"}

config-label-quest-board = {"**"}Tableau des quêtes :{"**"} { $channel }
config-desc-quest-board = Le canal où les quêtes nouvelles/actives seront publiées.
config-label-quest-board-default = {"**"}Tableau des quêtes :{"**"} Non configuré

config-label-player-board = {"**"}Tableau des joueurs :{"**"} { $channel }
config-desc-player-board = Un canal facultatif d'annonces/messages à l'usage des joueurs.
config-label-player-board-default = {"**"}Tableau des joueurs :{"**"} Non configuré

config-label-quest-archive = {"**"}Archive des quêtes :{"**"} { $channel }
config-desc-quest-archive = Un canal facultatif où les quêtes terminées seront déplacées, avec des informations de résumé.
config-label-quest-archive-default = {"**"}Archive des quêtes :{"**"} Non configuré

config-label-gm-transaction-log = {"**"}Journal des transactions GM :{"**"} { $channel }
config-desc-gm-transaction-log = Un canal facultatif où les transactions GM (c.-à-d. les commandes Modifier le joueur) sont enregistrées.
config-label-gm-transaction-log-default = {"**"}Journal des transactions GM :{"**"} Non configuré

config-label-player-transaction-log = {"**"}Journal des transactions joueurs :{"**"} { $channel }
config-desc-player-transaction-log = Un canal facultatif où les transactions des joueurs telles que les échanges et la consommation d'objets sont enregistrées.
config-label-player-transaction-log-default = {"**"}Journal des transactions joueurs :{"**"} Non configuré

config-label-shop-log = {"**"}Journal des boutiques :{"**"} { $channel }
config-desc-shop-log = Un canal facultatif où les transactions des boutiques sont enregistrées.
config-label-shop-log-default = {"**"}Journal des boutiques :{"**"} Non configuré

## Vue des quêtes
config-title-quests = {"**"}Configuration du serveur - Quêtes{"**"}

config-label-wait-list = {"**"}Taille de la liste d'attente des quêtes :{"**"} { $size }
config-desc-wait-list = Une liste d'attente permet au nombre spécifié de joueurs de s'inscrire en file d'attente pour une quête complète, au cas où un joueur se désisterait.
config-label-wait-list-disabled = {"**"}Taille de la liste d'attente des quêtes :{"**"} Désactivée

config-label-quest-summary = {"**"}Résumé de quête :{"**"} { $status }
config-desc-quest-summary = Cette option permet aux GM de fournir un bref résumé lors de la clôture des quêtes.
config-label-quest-summary-disabled = {"**"}Résumé de quête :{"**"} Désactivé

config-label-gm-rewards = Récompenses GM
config-desc-gm-rewards = Configurer les récompenses que les GM reçoivent à la fin des quêtes.

## Vue des récompenses GM
config-title-gm-rewards = {"**"}Configuration du serveur - Récompenses GM{"**"}
config-desc-gm-rewards-detail =
    {"**"}Ajouter/Modifier les récompenses{"**"}
    Ouvre une fenêtre de saisie pour ajouter, modifier ou supprimer les récompenses GM.

    > Les récompenses configurées sont sur une base par quête. Chaque fois qu'un Game Master termine une quête, il
    recevra les récompenses configurées ci-dessous sur son personnage actif.
config-msg-no-rewards = Aucune récompense configurée.
config-label-gm-experience = {"**"}Expérience :{"**"} { $xp }
config-label-gm-items = {"**"}Objets :{"**"}

## Vue des joueurs
config-title-players = {"**"}Configuration du serveur - Joueurs{"**"}

config-label-player-experience = {"**"}Expérience joueur :{"**"} { $status }
config-desc-player-experience = Active/Désactive l'utilisation des points d'expérience (ou d'un système similaire de progression basé sur la valeur).
config-label-player-experience-disabled = {"**"}Expérience joueur :{"**"} Désactivée

config-label-new-char-settings = {"**"}Paramètres de nouveau personnage{"**"}
config-desc-new-char-settings = Configurer les paramètres liés aux nouveaux personnages joueurs et à l'initialisation de leur inventaire.

config-label-player-board-purge = {"**"}Purge du tableau des joueurs{"**"}
config-desc-player-board-purge = Purge les publications du tableau des joueurs (si activé).

## Vue des paramètres de nouveau personnage
config-title-new-character = {"**"}Configuration du serveur - Paramètres de nouveau personnage{"**"}

config-label-inventory-type = {"**"}Type d'inventaire de nouveau personnage :{"**"} { $type }
config-desc-inventory-type = Détermine comment les personnages nouvellement enregistrés initialisent leur inventaire.
config-label-inventory-type-disabled = {"**"}Type d'inventaire de nouveau personnage :{"**"} Désactivé

config-label-new-char-wealth = {"**"}Richesse de nouveau personnage :{"**"} { $wealth }
config-label-new-char-wealth-disabled = {"**"}Richesse de nouveau personnage :{"**"} Désactivée

config-label-approval-queue = {"**"}File d'approbation :{"**"} { $channel }
config-desc-approval-queue = Si définie, les nouveaux personnages doivent être approuvés par un GM dans ce canal forum avant d'être actifs.
config-label-approval-queue-disabled = {"**"}File d'approbation :{"**"} Désactivée
config-label-approval-queue-not-configured = {"**"}File d'approbation :{"**"} Non configurée

# Descriptions des types d'inventaire (utilisées lors de la configuration)
config-desc-inv-type-disabled = Les joueurs commencent avec des inventaires vides.
config-desc-inv-type-selection = Les joueurs choisissent librement des objets dans la boutique de nouveau personnage.
config-desc-inv-type-purchase = Les joueurs achètent des objets dans la boutique de nouveau personnage avec un montant de monnaie donné.
config-desc-inv-type-open = Les joueurs saisissent manuellement les objets de leur inventaire.
config-desc-inv-type-static = Les joueurs reçoivent un inventaire de départ prédéfini.

## Vue de la boutique de nouveau personnage
config-title-new-char-shop = {"**"}Configuration du serveur - Boutique de nouveau personnage{"**"}
config-label-inv-type-selection = {"**"}Type d'inventaire :{"**"} Sélection
config-desc-inv-type-selection-shop = Les joueurs choisissent librement des objets dans la boutique de nouveau personnage.
config-label-inv-type-purchase = {"**"}Type d'inventaire :{"**"} Achat
config-desc-inv-type-purchase-shop = Les joueurs achètent des objets dans la boutique de nouveau personnage avec un montant de monnaie donné.
config-label-inv-type-other = {"**"}Type d'inventaire :{"**"} { $type }
config-desc-inv-type-not-in-use = La boutique de nouveau personnage n'est pas utilisée.
config-msg-define-shop-items = Définissez les objets de la boutique.
config-msg-no-items = Aucun objet configuré.

## Vue des kits statiques
config-title-static-kits = {"**"}Configuration du serveur - Kits statiques{"**"}
config-desc-create-kit = Créer une nouvelle définition de kit.
config-msg-no-kits = Aucun kit configuré.
config-label-kit-more-items = ...et { $count } objets de plus
config-label-empty-kit = {"*"}Kit vide{"*"}

## Vue de modification du kit statique
config-title-editing-kit = {"**"}Modification du kit : { $kitName }{"**"}
config-msg-kit-empty = Ce kit est vide. Utilisez les boutons ci-dessus pour ajouter de la monnaie ou des objets.
config-label-kit-currency = {"**"}Monnaie :{"**"} { $display }
config-label-kit-item = {"**"}Objet :{"**"} { $name }

## Vue de la monnaie
config-title-currency = {"**"}Configuration du serveur - Monnaie{"**"}
config-desc-create-currency = Créer une nouvelle monnaie.
config-msg-no-currencies = Aucune monnaie configurée.
config-label-currency-display-type = Type d'affichage : { $type } | Dénominations : { $count }
config-label-currency-type-double = Décimal
config-label-currency-type-integer = Entier

## Vue de modification de la monnaie
config-title-manage-currency = {"**"}Gérer la monnaie : { $currencyName }{"**"}
config-desc-currency-info =
    __{"**"}Monnaie et dénominations{"**"}__
    - Le nom donné à votre monnaie est considéré comme la monnaie de base et a une valeur de 1.
    {"```"}Exemple : « or » est configuré comme monnaie.{"```"}
    - L'ajout d'une dénomination nécessite de spécifier un nom et une valeur relative à la monnaie de base.
    {"```"}Exemple : L'or reçoit deux dénominations : argent (valeur de 0.1) et cuivre (valeur de 0.01).{"```"}
    - Toute transaction impliquant une monnaie de base ou ses dénominations les convertira automatiquement.
    {"```"}Exemple : Un joueur a 10 or et dépense 3 cuivre. Son nouveau solde affichera automatiquement
    9 or, 9 argent et 7 cuivre.{"```"}
    - Les monnaies affichées en entier montreront chaque dénomination, tandis que les monnaies affichées en décimal
    afficheront uniquement la monnaie de base.
    {"```"}Exemple : Le joueur ci-dessus avec l'affichage décimal activé affichera 9.97 or.{"```"}
config-btn-toggle-display-current = Basculer l'affichage (Actuel : { $type })
config-msg-no-denominations = Aucune dénomination configurée.

## Vue des boutiques
config-title-shops = {"**"}Configuration du serveur - Boutiques{"**"}
config-desc-add-shop-wizard =
    {"**"}Ajouter une boutique (assistant){"**"}
    Créer une nouvelle boutique vide à partir d'un formulaire.
config-desc-add-shop-json =
    {"**"}Ajouter une boutique (JSON){"**"}
    Créer une nouvelle boutique en fournissant une définition JSON complète. (Avancé)
config-btn-example-json = JSON Exemple
config-desc-example-json =
    {"**"}JSON Exemple{"**"}
    Téléchargez un fichier JSON exemple montrant le format attendu.
config-msg-example-json = Voici un fichier JSON exemple montrant le format attendu.
config-msg-no-shops = Aucune boutique configurée.
config-label-shop-type-forum = (Forum)
config-label-shop-channel = Canal : <#{ $channelId }>

## Vue de sélection du type de canal de boutique
config-title-choose-location = {"**"}Ajouter une boutique - Choisir le type d'emplacement{"**"}
config-label-text-channel = {"**"}Canal texte{"**"}
config-desc-text-channel = Créer une boutique dans un canal texte standard.
config-label-forum-thread = {"**"}Fil de forum{"**"}
config-desc-forum-thread = Créer une boutique dans un fil de forum (nouveau ou existant).

## Vue de configuration de boutique en forum
config-title-forum-setup = {"**"}Ajouter une boutique - Configuration du fil de forum{"**"}
config-label-step1 = {"**"}Étape 1 : Sélectionnez un canal forum{"**"}
config-label-step2 = {"**"}Étape 2 : Choisissez l'option de fil{"**"}
config-label-step3 = {"**"}Étape 3 : Sélectionnez un fil existant{"**"}
config-desc-create-new-thread =
    {"**"}Créer un nouveau fil{"**"}
    Ouvre un formulaire pour créer un nouveau fil et configurer la boutique.
config-label-selected-thread = {"**"}Fil sélectionné :{"**"} { $threadName }
config-desc-click-to-configure = Cliquez pour configurer la boutique dans ce fil.

## Vue de gestion de boutique
config-title-manage-shop = {"**"}Gérer la boutique : { $shopName }{"**"}
config-label-shop-type = {"**"}Type :{"**"} { $type }
config-label-shop-type-text = Canal texte
config-label-shop-type-forum-thread = Fil de forum
config-label-shopkeeper = {"**"}Commerçant :{"**"} { $name }
config-label-shop-description = {"**"}Description :{"**"} { $description }
config-label-shop-channel-info = {"**"}Canal :{"**"} <#{ $channelId }>
config-desc-edit-wizard = Modifier les détails et objets de la boutique via l'assistant.
config-desc-upload-json = Envoyer une nouvelle définition JSON pour cette boutique.
config-desc-download-json = Télécharger la définition JSON actuelle.
config-desc-remove-shop = Supprimer définitivement cette boutique.

## Vue de modification de boutique
config-title-editing-shop = {"**"}Modification de la boutique : { $shopName }{"**"}
config-label-shop-shopkeeper = Commerçant : {"**"}{ $name }{"**"}

## Vue des limites de stock
config-title-stock-config = {"**"}Configuration du stock : { $shopName }{"**"}
config-label-current-utc = Heure UTC actuelle : {"**"}{ $time }{"**"}
config-label-restock-schedule = {"**"}Calendrier de réapprovisionnement :{"**"} { $schedule }
config-label-restock-hourly = à la minute :{ $minute }
config-label-restock-daily = à { $time } UTC
config-label-restock-weekly = le { $day } à { $time } UTC
config-label-restock-mode = {"**"}Mode :{"**"} { $mode }
config-label-restock-full = Réapprovisionnement complet
config-label-restock-incremental = Incrémentiel (quantités par article)
config-label-restock-disabled = {"**"}Calendrier de réapprovisionnement :{"**"} Désactivé
config-label-item-stock-limits = {"**"}Limites de stock des objets{"**"}
config-msg-no-items-in-shop = Aucun objet dans cette boutique.
config-label-stock-with-available = Max : { $max } | Disponible : { $available }
config-label-stock-increment = Réappro. : +{ $increment }/cycle
config-label-stock-reserved = Réservé : { $reserved }
config-label-stock-not-initialized = Max : { $max } | Disponible : (non initialisé)
config-label-stock-unlimited = Stock : Illimité

## Vue du jeu de rôle
config-title-roleplay = {"**"}Configuration du serveur - Récompenses de jeu de rôle{"**"}
config-label-rp-status = {"**"}Statut :{"**"} { $status }
config-label-rp-server-time = ℹ️ {"**"}Heure du serveur :{"**"} `{ $time }`
config-label-rp-enabled = Activé
config-label-rp-disabled = Désactivé

config-desc-rp-mode-scheduled = {"```"}Les récompenses sont distribuées une seule fois, après l'envoi du nombre requis de messages éligibles dans la période définie (toutes les heures, quotidiennement ou hebdomadairement).{"```"}
config-desc-rp-mode-accrued = {"```"}Les récompenses sont distribuées de manière récurrente chaque fois qu'un nombre défini de messages éligibles est envoyé.{"```"}

config-label-rp-config-details = {"**"}Détails de la configuration :{"**"}
config-label-rp-mode = {"**"}Mode :{"**"} { $mode }
config-label-rp-min-length = {"**"}Longueur minimale du message :{"**"} { $length } caractères
config-label-rp-cooldown = {"**"}Temps de recharge :{"**"} { $seconds } secondes
config-label-rp-frequency-once = {"**"}Fréquence :{"**"} Une fois par { $period }
config-label-rp-reset-time = {"**"}Heure de réinitialisation :{"**"} { $dayAndTime } UTC
config-label-rp-threshold = {"**"}Seuil :{"**"} { $count } messages éligibles
config-label-rp-frequency-every = {"**"}Fréquence :{"**"} Tous les { $count } messages éligibles

config-label-rp-channels = {"**"}Canaux de jeu de rôle :{"**"}
config-msg-rp-no-channels = Aucun configuré.
config-label-rp-channels-more = ...et { $count } de plus.

config-label-rp-rewards = {"**"}Récompenses :{"**"}
config-msg-rp-no-rewards = Aucune configurée.
config-label-rp-experience = {"**"}Expérience :{"**"} { $xp }
config-label-rp-items = {"**"}Objets :{"**"}
config-label-rp-currency = {"**"}Monnaie :{"**"}

## Vue de la langue
config-title-language = {"**"}Configuration du serveur - Langue{"**"}
config-server-language-help =
    Ce paramètre vous permet de spécifier la langue par défaut pour les réponses et messages {"**"}publics{"**"} de ReQuest sur ce serveur. Les réponses publiques incluent :
    - Les publications du tableau des quêtes et du tableau des joueurs
    - Les messages de résumé de quête et des canaux de journal
    - Le réapprovisionnement des boutiques
    - La consommation d'objets par les joueurs

    Ce paramètre n'affecte que le texte statique généré par le bot, et ne traduit pas le contenu dynamique tel que les noms d'objets ou les descriptions de quêtes saisis par les utilisateurs.

    Les réponses et menus personnels ne sont pas affectés par ce paramètre.
config-label-server-language = {"**"}Langue du serveur :{"**"} { $language }
config-label-server-language-default = {"**"}Langue du serveur :{"**"} Par défaut (aucun remplacement)
config-select-placeholder-server-language = Sélectionnez la langue du serveur
config-select-option-default = Par défaut (aucun remplacement)
config-select-desc-default = Utiliser la préférence de chaque utilisateur ou la langue Discord.

# Quest Roles
config-btn-quest-roles = Rôles de quête
config-btn-manage-gm-quest-roles = Gérer

config-modal-title-confirm-quest-role-removal = Confirmer la suppression du rôle
config-modal-label-remove-quest-role = Retirer { $roleName } de { $gmName } ?

# QuestRoleModeSelect
config-select-placeholder-quest-role-mode = Sélectionnez le mode de rôles de quête
config-select-option-quest-role-disabled = Désactivé
config-select-desc-quest-role-disabled = Aucun rôle n'est créé ou attribué.
config-select-option-quest-role-temporary = Temporaire
config-select-desc-quest-role-temporary = Les GMs peuvent créer des rôles temporaires par quête.
config-select-option-quest-role-static = Statique
config-select-desc-quest-role-static = Les GMs choisissent parmi des rôles serveur pré-attribués.

# AddGMQuestRoleSelect
config-select-placeholder-add-quest-role = Attribuer un/des rôle(s) serveur à ce GM

## Quest Roles View
config-title-quest-roles = {"**"}Configuration du serveur - Rôles de quête{"**"}
config-label-quest-roles = Rôles de quête
config-desc-quest-roles =
    Configurez la gestion des rôles du groupe pendant les quêtes.

config-label-quest-role-mode-disabled = {"**"}Mode de rôles de quête :{"**"} Désactivé
    Aucun rôle n'est créé ou attribué pendant les quêtes.
config-label-quest-role-mode-temporary = {"**"}Mode de rôles de quête :{"**"} Temporaire
    Les GMs peuvent optionnellement créer un rôle temporaire lors de la création de la quête.
    Le rôle est supprimé lorsque la quête est terminée ou annulée.
config-label-quest-role-mode-static = {"**"}Mode de rôles de quête :{"**"} Statique
    Les GMs choisissent parmi des rôles serveur pré-attribués. Les rôles sont attribués
    aux membres du groupe pendant les quêtes mais ne sont jamais supprimés.

## Static Quest Role Assignments View
config-title-static-quest-roles = {"**"}Configuration du serveur - Attributions de rôles statiques de quête{"**"}
config-label-manage-assignments = Gérer les attributions de rôles
config-desc-manage-assignments =
    Attribuez des rôles serveur existants aux GMs pour les utiliser pendant les quêtes.
    Les rôles doivent être en dessous du rôle le plus élevé de ReQuest dans la hiérarchie du serveur.
config-msg-no-gm-members = Aucun membre avec un rôle GM n'a été trouvé sur ce serveur.
config-label-no-roles-assigned = Aucun rôle de quête attribué
config-label-more-roles = (+{ $count } de plus)

## GM Quest Role Assign View
config-title-gm-quest-role-assign = {"**"}Gérer les rôles de quête — { $gmName }{"**"}
config-error-unmanageable-roles = Les rôles suivants ne peuvent pas être attribués car ils sont gérés par une intégration, sont le rôle par défaut ou sont au-dessus du rôle le plus élevé de ReQuest : { $roles }
config-error-quest-role-limit = Ce GM a atteint le maximum de { $limit } rôles de quête attribués.
config-label-quest-role-count = Rôles attribués : { $count }/{ $limit }
