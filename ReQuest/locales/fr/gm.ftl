## Chaînes du module Game Master

# Boutons GM
gm-btn-create = Créer
gm-btn-edit-details = Modifier la quête
gm-btn-toggle-ready = Basculer prêt
gm-btn-configure-rewards = Configurer les récompenses
gm-btn-remove-player = Retirer un joueur
gm-btn-cancel-quest = Annuler la quête
gm-btn-manage-party-rewards = Gérer les récompenses du groupe
gm-btn-manage-individual-rewards = Gérer les récompenses individuelles
gm-btn-join = Rejoindre
gm-btn-leave = Quitter
gm-btn-complete-quest = Terminer la quête
gm-btn-edit-details-modal = Modifier les détails
gm-btn-edit-images = Modifier les images
gm-btn-publish = Publier
gm-btn-update-post = Mettre à jour la publication
gm-select-placeholder-party-role = Sélectionnez un rôle de groupe...
gm-modal-title-edit-details = Modifier les détails de la quête
gm-modal-title-edit-images = Modifier les images de la quête

# Fenêtres modales GM
gm-modal-title-create-quest = Créer une nouvelle quête
gm-modal-label-quest-title = Titre de la quête
gm-modal-placeholder-quest-title = Titre de votre quête
gm-modal-label-restrictions = Restrictions
gm-modal-placeholder-restrictions = Restrictions éventuelles, comme le niveau des joueurs
gm-modal-label-max-party = Taille maximale du groupe
gm-modal-placeholder-max-party = Taille maximale du groupe pour cette quête
gm-modal-label-party-role = Rôle du groupe
gm-modal-placeholder-party-role = Créer un rôle pour cette quête (facultatif)
gm-modal-label-description = Description
gm-modal-placeholder-description = Rédigez les détails de votre quête ici
gm-modal-label-image-url = URL de la miniature
gm-modal-label-large-image-url = URL de la grande image
gm-modal-placeholder-image-url = Entrez une URL d'image (ou laissez vide pour supprimer)
gm-modal-title-add-reward = Ajouter une récompense
gm-modal-label-experience = Points d'expérience
gm-modal-placeholder-experience = Entrez un nombre
gm-modal-label-items = Objets
gm-modal-placeholder-items =
    objet : quantité
    objet2 : quantité
    etc.
gm-modal-title-add-summary = Ajouter un résumé de quête
gm-modal-label-summary = Résumé
gm-modal-placeholder-summary = Ajoutez un résumé narratif de la quête
gm-modal-title-modifying-player = Modification de { $playerName }
gm-modal-placeholder-xp-add-remove = Entrez un nombre positif ou négatif.
gm-modal-label-inventory = Inventaire
gm-modal-placeholder-inventory-modify =
    objet : quantité
    objet2 : quantité
    etc.

# Erreurs GM
gm-error-forbidden-role-name = Le nom fourni pour le rôle du groupe est interdit.
gm-error-role-already-exists = Un rôle portant ce nom existe déjà dans ce serveur.
gm-error-no-quest-channel = Aucun canal n'a encore été désigné pour les publications de quêtes. Contactez un administrateur du serveur pour configurer le canal de quêtes.
gm-error-cannot-ping-announce = Impossible de mentionner le rôle d'annonce { $role } dans le canal { $channel }. Vérifiez les permissions du canal et du rôle ReQuest auprès de votre/vos administrateur(s) de serveur.
gm-error-invalid-item-format = Format d'objet invalide : « { $item } ». Chaque objet doit être sur une nouvelle ligne, au format « Nom : Quantité ».
gm-error-already-on-quest = Vous êtes déjà inscrit à cette quête en tant que { $characterName }.
gm-error-no-active-character-long = Vous n'avez pas de personnage actif sur ce serveur. Utilisez `/player` pour enregistrer ou activer un personnage.
gm-error-quest-locked = Erreur lors de l'inscription à la quête {"**"}{ $questTitle }{"**"} : La quête est verrouillée par le GM.
gm-error-quest-full = Erreur lors de l'inscription à la quête {"**"}{ $questTitle }{"**"} : Le groupe est complet !
gm-error-not-signed-up = Vous n'êtes pas inscrit à cette quête.
gm-error-quest-channel-not-set = Le canal de quêtes n'a pas été défini !
gm-error-empty-roster = Vous ne pouvez pas terminer une quête avec un groupe vide. Essayez plutôt d'annuler.
gm-error-invalid-xp-value = La valeur de XP doit être un entier positif !
gm-error-party-size-positive = La taille du groupe doit être un nombre positif.
gm-error-party-size-too-small = La taille du groupe ne peut pas être inférieure au groupe actuel ({ $currentSize } membres).
gm-error-role-name-forbidden = Le nom de rôle « { $roleName } » est interdit sur ce serveur.
gm-error-role-name-exists = Un rôle nommé « { $roleName } » existe déjà sur ce serveur.

# Fenêtres de confirmation GM
gm-modal-title-cancel-quest = Annuler la quête
gm-modal-label-cancel-quest = Tapez CONFIRMER pour annuler la quête.
gm-modal-title-remove-from-quest = Retirer un personnage de la quête
gm-modal-label-remove-from-quest = Confirmer le retrait du personnage ?

# GM DM embeds
gm-dm-title-quest-cancelled = Quête annulée
gm-dm-desc-quest-cancelled = La quête {"**"}{ $questTitle }{"**"} a été annulée par le GM.
gm-dm-title-quest-ready = Quête prête
gm-dm-desc-quest-ready = La quête {"**"}{ $questTitle }{"**"} est maintenant prête ! Votre GM commencera la quête bientôt.
gm-dm-title-player-removed = Retiré de la quête
gm-dm-desc-player-removed = Vous avez été retiré de la quête {"**"}{ $questTitle }{"**"} par le GM.
gm-dm-desc-player-removed-waitlist = Vous avez été retiré de la liste d'attente pour {"**"}{ $questTitle }{"**"}.
gm-dm-title-party-promotion = Promotion dans le groupe
gm-dm-desc-party-promotion =
    Vous avez été promu dans le groupe principal de {"**"}{ $questTitle }{"**"}
    car un joueur a quitté la quête.
gm-dm-title-roster-locked = Liste verrouillée
gm-dm-desc-roster-locked =
    La liste du groupe de {"**"}{ $questTitle }{"**"} a été verrouillée
    et tous les membres du groupe ont été notifiés.
gm-dm-title-roster-unlocked = Liste déverrouillée
gm-dm-desc-roster-unlocked = La liste du groupe de {"**"}{ $questTitle }{"**"} a été déverrouillée.
gm-dm-title-player-removed-confirm = Joueur retiré
gm-dm-desc-player-removed-confirm =
    Le joueur a été retiré de {"**"}{ $questTitle }{"**"}
    et la liste de la quête a été mise à jour.
gm-dm-footer-quest = ID de la quête : { $questId } • { $guildName }
gm-dm-rewards-no-characters =
    L'administrateur de votre serveur a configuré des récompenses pour les Game Masters lorsqu'ils
    terminent des quêtes. Cependant, comme vous n'avez aucun personnage enregistré, vos récompenses
    n'ont pas pu être attribuées automatiquement pour le moment.
gm-dm-rewards-no-active-character =
    L'administrateur de votre serveur a configuré des récompenses pour les Game Masters lorsqu'ils
    terminent des quêtes. Cependant, comme vous n'avez pas de personnage actif sur ce serveur, vos
    récompenses n'ont pas pu être attribuées automatiquement pour le moment.
gm-dm-rewards-issued = Les éléments suivants ont été attribués à votre personnage actif, { $characterName }
gm-dm-role-removal-failed =
    ⚠️ Impossible de retirer le rôle {"**"}{ $roleName }{"**"} des membres suivants : { $members }.
    Veuillez prévenir un administrateur du serveur pour retirer le rôle manuellement.
gm-dm-role-not-found =
    ⚠️ Le rôle de quête (ID : { $roleId }) pour la quête {"**"}{ $questTitle }{"**"} n'existe plus sur le serveur.
    Les opérations de rôle ont été ignorées. Veuillez prévenir un administrateur du serveur si cela est inattendu.

# Menus de sélection GM
gm-select-placeholder-party-member = Sélectionnez un membre du groupe
gm-modal-label-select-party-role = Rôle du groupe
gm-modal-desc-select-party-role = Sélectionnez un rôle à attribuer au groupe de la quête.
gm-select-option-no-role = Aucun (Pas de rôle de groupe)

# Embeds GM
gm-embed-title-mod-report = Rapport de modification de joueur par le GM
gm-embed-field-experience = Expérience
gm-embed-title-quest-complete = Quête terminée : { $questTitle }
gm-embed-title-quest-completed = QUÊTE TERMINÉE : { $questTitle }
gm-embed-field-rewards = Récompenses
gm-embed-field-party = __Groupe__
gm-embed-field-summary = Résumé
gm-embed-title-gm-rewards = Récompenses GM attribuées
gm-embed-field-items = Objets

# Vues GM
gm-title-main-menu = Game Master - Menu principal
gm-menu-quests = Quêtes
gm-menu-desc-quests = Créer, modifier et gérer des quêtes.
gm-menu-players = Joueurs
gm-menu-desc-players = Gérer les inventaires des joueurs et modifier les personnages.

gm-title-quest-management = Game Master - Gestion des quêtes
gm-desc-create-quest = Créer une nouvelle quête.
gm-msg-no-quests = Aucune quête trouvée.
gm-label-quest-locked = (Verrouillée)
gm-label-quest-draft = (Brouillon)
gm-title-manage-quest = Gérer la quête - { $questTitle } `{ $questId }`
gm-desc-edit-quest = Modifier les détails de la quête tels que le titre, la description et la taille du groupe.
gm-title-edit-quest = Modifier la quête - { $questTitle }
gm-label-field-not-set = Non défini
gm-label-description-not-set = Description non définie
gm-label-current-title = {"**"}Titre :{"**"} { $value }
gm-label-current-description = {"**"}Description{"**"}
gm-label-current-restrictions = {"**"}Restrictions :{"**"} { $value }
gm-label-current-party-size = {"**"}Taille max. du groupe :{"**"} { $value }
gm-label-current-party-role = {"**"}Rôle du groupe :{"**"} { $value }
gm-label-current-image = {"**"}Miniature{"**"}
gm-label-current-large-image = {"**"}Image{"**"}
gm-desc-publish-quest = Publier cette quête sur le tableau des quêtes.
gm-desc-update-quest-post = Mettre à jour la publication de la quête sur le tableau des quêtes.
gm-desc-toggle-ready = Basculer l'état de préparation (Actuel : {"**"}{ $status }{"**"})
    - Verrouille le groupe de la quête et notifie les membres que la quête va bientôt commencer. Si un rôle est configuré, il sera attribué aux membres du groupe une fois verrouillé.
    - Déverrouille le groupe lorsque défini sur Ouvert.
gm-label-ready-locked = Verrouillé/Prêt
gm-label-ready-open = Ouvert
gm-desc-configure-rewards = Configurer les récompenses pour la quête sélectionnée.
gm-desc-complete-quest = Terminer une quête. Distribue les récompenses, le cas échéant, aux membres du groupe.
gm-desc-remove-player = Retirer un joueur du groupe de la quête et le notifier.
gm-desc-cancel-quest = Annuler la quête et la supprimer du tableau des quêtes.
gm-title-player-management = Game Master - Gestion des joueurs
gm-desc-player-management =
    Ces commandes ont été déplacées vers les menus contextuels. Faites un clic droit (bureau) ou appuyez longuement (mobile) sur le profil d'un joueur pour accéder aux options de menu suivantes :

    - {"**"}Modifier le joueur{"**"} : Ajouter ou retirer des objets et de l'expérience d'un joueur.
    - {"**"}Voir le joueur{"**"} : Voir les détails du personnage actif d'un joueur.
gm-title-remove-player = Retirer un joueur de la quête - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}Notes sur le retrait de joueur{"**"}__

    - Choisissez un joueur dans le menu déroulant ci-dessous pour le retirer du groupe de la quête.
    - Si des joueurs sont en liste d'attente, le premier joueur de la liste sera promu dans le groupe.
    - Les récompenses individuelles du joueur retiré seront supprimées de la quête.
    - Si vous souhaitez récompenser le joueur pour ses contributions antérieures, utilisez le menu contextuel « Modifier le joueur » pour lui attribuer directement des récompenses.
gm-label-no-players-in-roster = Aucun joueur dans le groupe de la quête
gm-title-character-sheet = Fiche de personnage de { $characterName } (<@{ $memberId }>)
gm-label-experience-points = __{"**"}Points d'expérience :{"**"}__
gm-label-possessions = __{"**"}Possessions{"**"}__
gm-label-currency-heading = {"**"}Monnaie{"**"}
gm-msg-inventory-empty = L'inventaire est vide.

# Approbations GM

gm-error-role-hierarchy = ReQuest ne peut pas gérer le rôle « { $roleName } » (ID : { $roleId }) car il est positionné plus haut que le rôle le plus élevé de ReQuest dans la hiérarchie du serveur. Veuillez contacter un administrateur du serveur pour déplacer le rôle en dessous du rôle de ReQuest, ou attribuer un rôle plus élevé à ReQuest, puis réessayez l'opération.
