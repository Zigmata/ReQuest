## Chaînes du module Joueur

# --- Cog ---

player-cmd-name = Échange
player-cmd-desc = Menus joueur

# --- Boutons ---

# Gestion des personnages
player-btn-register-character = Enregistrer un nouveau personnage
player-btn-activate = Activer
player-btn-active = Actif

# Tableau des joueurs
player-btn-create-post = Créer une publication
player-btn-open-starting-shop = Ouvrir la boutique de départ
player-btn-select-kit = Sélectionner un kit
player-btn-input-inventory = Saisir l'inventaire

# Boutons assistant / boutique
player-btn-add-to-cart = Ajouter au panier
player-btn-add-to-cart-cost = Ajouter au panier ({ $costString })
player-btn-view-purchase-options = Voir les options d'achat
player-btn-review-submit = Vérifier et soumettre ({ $count })
player-btn-submit-character = Soumettre le personnage
player-btn-keep-shopping = Continuer les achats
player-btn-edit-quantity = Modifier la quantité
player-btn-clear-cart = Vider le panier

# Boutons de kit
player-btn-confirm-selection = Confirmer la sélection
player-btn-back-to-kits = Retour aux kits

# Gestion de l'inventaire
player-btn-spend-currency = Dépenser de la monnaie
player-btn-print-inventory = Imprimer l'inventaire

# Gestion des conteneurs
player-btn-manage-containers = Gérer les conteneurs
player-btn-create-new = + Créer nouveau
player-btn-consume-destroy = Consommer/Détruire
player-btn-move = Déplacer
player-btn-move-all = Tout déplacer
player-btn-move-some = Déplacer une partie...
player-btn-back-to-overview = ← Retour à l'aperçu
player-btn-cancel-move = ← Annuler
player-btn-up = ▲ Haut
player-btn-down = ▼ Bas

# --- Fenêtres modales ---

# Fenêtre d'échange
player-modal-title-trade = Échange avec { $targetName }
player-modal-label-trade-name = Nom
player-modal-placeholder-trade-name = Entrez le nom de l'objet que vous échangez
player-modal-label-trade-quantity = Quantité
player-modal-placeholder-trade-quantity = Entrez la quantité que vous échangez

# Fenêtre d'enregistrement de personnage
player-modal-title-register = Enregistrer un nouveau personnage
player-modal-label-char-name = Nom
player-modal-placeholder-char-name = Entrez le nom de votre personnage.
player-modal-label-char-note = Note
player-modal-placeholder-char-note = Entrez une note pour identifier votre personnage

# Fenêtre de saisie d'inventaire ouvert
player-modal-title-starting-inventory = Saisie de l'inventaire de départ
player-modal-label-inventory = Inventaire
player-modal-placeholder-inventory-input =
    Un par ligne au format <nom> : <quantité>, ex. :
    Épée : 1
    or : 30

# Fenêtre de dépense de monnaie
player-modal-title-spend-currency = Dépenser de la monnaie
player-modal-label-currency-name = Nom de la monnaie
player-modal-placeholder-currency-name = Entrez le nom de la monnaie que vous dépensez
player-modal-label-currency-amount = Montant
player-modal-placeholder-currency-amount = Entrez le montant à dépenser

# Fenêtre de création de publication joueur
player-modal-title-create-post = Créer une publication sur le tableau des joueurs
player-modal-label-post-title = Titre
player-modal-placeholder-post-title = Entrez un titre pour votre publication
player-modal-label-post-content = Contenu de la publication
player-modal-placeholder-post-content = Entrez le corps de votre publication

# Fenêtre de modification de publication joueur
player-modal-title-edit-post = Modifier la publication sur le tableau des joueurs

# Fenêtre de modification de quantité dans le panier
player-modal-title-edit-cart-qty = Modifier la quantité du panier
player-modal-label-cart-qty = Quantité
player-modal-placeholder-cart-qty = Entrez la nouvelle quantité (0 pour retirer)

# Fenêtre de création de conteneur
player-modal-title-create-container = Créer un nouveau conteneur
player-modal-label-container-name = Nom du conteneur
player-modal-placeholder-container-name = Entrez un nom pour votre conteneur (ex. : Sac à dos)

# Fenêtre de renommage de conteneur
player-modal-title-rename-container = Renommer le conteneur
player-modal-label-new-container-name = Nouveau nom du conteneur
player-modal-placeholder-new-container-name = Entrez le nouveau nom

# Fenêtre de consommation depuis un conteneur
player-modal-title-consume = Consommer/Détruire un objet
player-modal-label-consume-qty = Quantité (max : { $maxQuantity })
player-modal-placeholder-consume-qty = Entrez la quantité à consommer/détruire

# Fenêtre de déplacement d'objet
player-modal-title-move-item = Déplacer un objet
player-modal-label-move-qty = Quantité à déplacer (max : { $maxQuantity })
player-modal-placeholder-move-qty = Entrez la quantité à déplacer

# --- Sélecteurs ---

player-select-placeholder-no-characters = Vous n'avez aucun personnage enregistré
player-select-placeholder-remove-character = Sélectionnez un personnage à retirer
player-select-placeholder-post = Sélectionnez une publication
player-select-placeholder-container-view = Sélectionnez un conteneur à consulter...
player-select-placeholder-item = Sélectionnez un objet...
player-select-placeholder-destination = Sélectionnez la destination...
player-select-placeholder-container = Sélectionnez un conteneur...
player-select-option-no-containers = Aucun conteneur
player-select-option-no-items = Aucun objet
player-select-option-no-destinations = Aucune destination

# --- Vues ---

# PlayerBaseView - Menu principal
player-title-main-menu = {"**"}Commandes joueur - Menu principal{"**"}
player-menu-btn-characters = Personnages
player-menu-desc-characters = Enregistrer, consulter et activer des personnages joueurs.
player-menu-btn-inventory = Inventaire
player-menu-desc-inventory = Consulter l'inventaire de votre personnage actif et dépenser de la monnaie.
player-menu-btn-player-board = Tableau des joueurs
player-menu-btn-player-board-disabled = Tableau des joueurs (non configuré)
player-menu-desc-player-board = Créer une publication pour le tableau des joueurs

# CharacterBaseView
player-title-characters = {"**"}Commandes joueur - Personnages{"**"}
player-desc-register-character = Enregistrer un nouveau personnage.
player-msg-no-characters = Vous n'avez aucun personnage enregistré.
player-label-active = (Actif)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Personnage en cours : { $characterName }{"**"}
    L'inscription de votre personnage est en attente de configuration d'inventaire.
player-btn-resume = Reprendre
player-btn-discard = Abandonner
player-modal-title-discard-character = Abandonner le personnage
player-modal-label-discard-confirm = Abandonner { $characterName } ?

# Confirmation de retrait de personnage
player-modal-title-confirm-char-removal = Confirmer le retrait du personnage
player-modal-label-confirm-char-delete = Supprimer { $characterName } ?

# Confirmation de retrait de publication
player-modal-title-confirm-post-removal = Confirmer le retrait de la publication
player-modal-label-post-removal-warning = ATTENTION : Cette action est irréversible !

# InventoryOverviewView
player-title-inventory = {"**"}Commandes joueur - Inventaire{"**"}
player-title-char-inventory = {"**"}Inventaire de { $characterName }{"**"}
player-msg-no-active-character = Aucun personnage actif : activez un personnage pour ce serveur afin d'utiliser ces menus.
player-msg-no-characters-registered = Aucun personnage : enregistrez un personnage pour utiliser ces menus.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } objets
player-label-currency = {"**"}Monnaie{"**"}
player-msg-inventory-empty = L'inventaire est vide.

# Embed d'impression d'inventaire
player-embed-title-inventory = Inventaire de { $characterName }

# ContainerItemsView
player-msg-container-empty = Ce conteneur est vide.
player-label-selected-item = Sélectionné : {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Déplacer « { $itemName } »{"**"} ({ $available } disponibles)
player-msg-no-other-containers = Aucun autre conteneur disponible.
player-msg-select-destination = Sélectionnez le conteneur de destination :
player-label-destination = Destination : {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Gérer les conteneurs{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } objets){ $suffix }
player-label-default-suffix = { " " }(par défaut)
player-msg-no-containers = Aucun conteneur.
player-label-selected-container = Sélectionné : {"**"}{ $containerName }{"**"}

# Confirmation de suppression de conteneur
player-modal-title-confirm-container-delete = Confirmer la suppression du conteneur
player-modal-label-container-has-items = Contient { $itemCount } objets. Sera déplacé vers Objets non rangés.
player-modal-label-confirm-container-delete = Supprimer « { $containerName } » ?

# Erreurs de conteneur
player-error-cannot-rename-loose = Impossible de renommer les Objets non rangés.
player-error-cannot-delete-loose = Impossible de supprimer les Objets non rangés.

# PlayerBoardView
player-title-player-board = {"**"}Commandes joueur - Tableau des joueurs{"**"}
player-desc-create-post = Créer une nouvelle publication pour le tableau des joueurs.
player-msg-no-posts = Vous n'avez aucune publication en cours.
player-label-post-info = {"**"}{ $title }{"**"} (ID : `{ $postId }`)
player-embed-field-author = Auteur
player-embed-footer-post-id = ID de publication : { $postId }
player-error-board-channel-not-found = Canal du tableau des joueurs introuvable.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Configurer l'inventaire de { $characterName }{"**"}
player-desc-browse-shop = Parcourez la boutique de départ pour équiper votre personnage.
player-desc-select-kit = Sélectionnez un kit de départ.
player-desc-input-inventory = Saisissez manuellement votre inventaire de départ.

# StaticKitSelectView
player-title-select-kit = {"**"}Sélectionner un kit pour { $characterName }{"**"}
player-msg-no-kits = Aucun kit de départ disponible.
player-label-and-more-items = ...et { $count } objets de plus
player-label-empty-kit = {"*"}Kit vide{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Confirmer la sélection : { $kitName }{"**"}
player-label-items-heading = {"**"}Objets :{"**"}
player-label-currency-heading = {"**"}Monnaie :{"**"}
player-msg-kit-empty = Ce kit est vide.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Options d'achat : { $itemName }{"**"}
player-msg-no-cost-options = Cet objet n'a aucune option de coût disponible.
player-label-cost-option = {"**"}Option { $index } :{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Boutique de départ ({ $inventoryType }){"**"}
player-label-starting-wealth = Richesse de départ : { $formattedCurrency }
player-label-in-cart = {"**"}(Dans le panier : { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Vérifier le panier{"**"}
player-msg-cart-empty = Votre panier est vide.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Total : { $totalQuantity })
player-label-insufficient-currency = { $currencyName } insuffisant
player-label-total-cost = {"**"}Coût total :{"**"}
player-label-total-cost-free = {"**"}Coût total :{"**"} Gratuit
player-label-cart-page = Page { $current } sur { $total }

# Embed d'échange
player-embed-title-trade = Rapport d'échange
player-embed-desc-trade-sender = Expéditeur : { $senderMention } en tant que `{ $senderCharacter }`
player-embed-desc-trade-recipient = Destinataire : { $recipientMention } en tant que `{ $recipientCharacter }`
player-embed-field-currency = Monnaie
player-embed-field-amount = Montant
player-embed-field-balance = Solde de { $characterName }
player-embed-field-item = Objet
player-embed-field-quantity = Quantité
player-embed-footer-transaction-id = ID de transaction : { $transactionId }

# Erreurs d'échange
player-error-trade-no-characters = Le joueur avec lequel vous essayez d'échanger n'a aucun personnage !
player-error-trade-no-active = Le joueur avec lequel vous essayez d'échanger n'a pas de personnage actif sur ce serveur !

# Embed de dépense de monnaie
player-embed-title-spend = Rapport de transaction joueur
player-embed-desc-spend-player = Joueur : { $playerMention } en tant que `{ $characterName }`
player-embed-desc-spend-transaction = Transaction : {"**"}{ $characterName }{"**"} a dépensé {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Canal
player-embed-field-receipt = Reçu

# Erreurs de dépense de monnaie
player-error-amount-not-number = Le montant doit être un nombre.
player-error-amount-positive = Vous devez dépenser un montant positif.
player-error-amount-exceeds-maximum = Le montant ne peut pas dépasser { $max }.
player-error-no-active-character-server = Vous n'avez pas de personnage actif sur ce serveur.
player-error-no-currency-config = Aucune configuration de monnaie n'a été trouvée pour ce serveur.

# Embed de consommation d'objet
player-embed-title-consume = Rapport de consommation d'objet
player-embed-desc-consume = Joueur : { $playerMention } en tant que `{ $characterName }`
player-embed-desc-consume-removed = Retiré : {"**"}{ $quantity }x { $itemName }{"**"} de {"**"}{ $containerName }{"**"}

# Erreurs de consommation d'objet
player-error-qty-positive-integer = La quantité doit être un entier positif.
player-error-qty-at-least-one = La quantité doit être d'au moins 1.
player-error-qty-only-have = Vous n'avez que { $maxQuantity } de cet objet.

# Erreurs de saisie d'inventaire
player-error-invalid-format = Format invalide : « { $line } ». Utilisez <nom> : <quantité>.
player-error-empty-name = Le nom de l'objet ne peut pas être vide dans la ligne : « { $line } ».
player-error-invalid-quantity = Quantité invalide pour « { $name } » : « { $quantity } ». Doit être un entier positif.
player-error-input-errors-header = Erreurs dans la saisie de l'inventaire :
player-msg-no-valid-items = Aucun objet valide fourni. Initialisation avec un inventaire vide.

# Validation de quantité dans le panier
player-error-enter-valid-number = Veuillez entrer un nombre positif valide.

# Embeds de soumission (file d'approbation)
player-embed-title-approval = Approbation d'inventaire : { $characterName }
player-embed-desc-submitted-by = Soumis par { $userMention }
player-embed-field-items = Objets
player-embed-field-currency-received = Monnaie
player-embed-footer-submission-id = ID de soumission : { $submissionId }
player-label-approval-thread = Approbation : { $characterName }
player-embed-title-submission-sent = Soumission d'inventaire envoyée
player-embed-desc-submission-sent =
    Votre soumission pour {"**"}{ $characterName }{"**"} a été envoyée à l'équipe GM pour approbation !
    Vous serez notifié une fois qu'elle aura été examinée.
    [Voir le fil de soumission]({ $threadUrl })

# Embeds d'application directe (sans file d'approbation)
player-embed-title-starting-inventory = Inventaire de départ appliqué
player-embed-desc-starting-inventory = Joueur : { $playerMention } en tant que `{ $characterName }`
player-embed-field-items-received = Objets reçus
player-embed-field-currency-received-label = Monnaie reçue
player-label-untitled = Sans titre

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Objets
player-approval-post-currency = Monnaie
player-approval-resolved = Cette soumission a été traitée.
player-approval-btn-approve = Approuver
player-approval-btn-deny = Refuser
player-approval-btn-edit = Modifier
player-approval-error-no-permission = Vous n'avez pas la permission d'effectuer cette action.
player-approval-error-not-submitter = Seul le soumetteur original peut modifier cette soumission.
player-approval-thread-instructions =
    This thread was created for the approval of {"**"}{ $characterName }{"**"}.
    A Game Master will review the submission and approve or deny it.
    Once approved or denied, this thread will be locked.

    {"**"}Game Masters:{"**"} Discuss any required changes with your
    player until the inventory is in an acceptable state. Only use
    the `Deny` button for irreconcilable submissions.

    { $playerMention }: Use the `Edit` button to make any changes
    requested here by a Game Master.
player-approval-approved-by = Cette soumission a été approuvée par { $approver }.
player-approval-denied-by = Cette soumission a été refusée par { $denier }.
player-approval-deny-reason = Raison : { $reason }
player-msg-submission-updated = Votre soumission a été mise à jour.


# Denial modal
player-modal-title-deny-reason = Refuser la soumission
player-modal-label-deny-reason = Raison du refus
player-modal-placeholder-deny-reason = Optionnel : expliquez la raison du refus
# Approval DM notifications
player-dm-title-approved = Personnage approuvé
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Personnage refusé
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}.
