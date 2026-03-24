## Chaînes du module Boutique

# Cog boutique
shop-error-no-shops = Aucune boutique n'est configurée pour ce serveur.
shop-error-not-shop-channel =
    Ce canal n'est pas enregistré comme canal de boutique.
    Si vous pensez qu'une boutique devrait se trouver ici, prévenez l'administrateur de votre serveur.

# Boutons de boutique
shop-btn-out-of-stock = Rupture de stock
shop-btn-view-options = Voir les options d'achat
shop-btn-add-to-cart = Ajouter au panier ({ $cost })
shop-btn-view-cart = Voir le panier
shop-btn-view-cart-count = Voir le panier ({ $count })
shop-btn-back-to-shop = Retour à la boutique
shop-btn-clear-cart = Vider le panier
shop-btn-checkout = Passer à la caisse
shop-btn-edit-quantity = Modifier la quantité

# Fenêtres modales de boutique
shop-modal-title-edit-cart-qty = Modifier la quantité du panier
shop-modal-label-quantity = Quantité
shop-modal-placeholder-quantity = Entrez la nouvelle quantité pour cet objet
shop-error-invalid-number = Veuillez entrer un nombre valide.

# Vues de boutique
shop-label-shopkeeper = Commerçant : {"**"}{ $name }{"**"}
shop-label-unknown-item = Objet inconnu
shop-label-out-of-stock = RUPTURE DE STOCK
shop-label-stock-available = Stock : { $available }
shop-label-in-cart = (Dans le panier : { $quantity })
shop-title-cart = 🛒 {"**"}Panier{"**"}
shop-msg-cart-empty = Votre panier est vide.
shop-warning-no-active-character = ⚠️ Aucun personnage actif trouvé. Impossible de vérifier les fonds.
shop-warning-insufficient-funds = ⚠️ Fonds insuffisants pour { $currency }
shop-label-invalid-cost = Coût invalide
shop-label-total-cost = {"**"}Coût total :{"**"}
shop-label-warning = {"**"}Attention :{"**"}
shop-error-no-active-character = Vous n'avez pas de personnage actif sur ce serveur.
shop-error-checkout-insufficient = Échec du paiement : { $currency } insuffisant.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} est en rupture de stock.

# Embed de rapport de boutique
shop-embed-title-report = Rapport d'achat
shop-embed-field-purchased = Acheté
shop-label-no-items = Aucun objet
shop-embed-field-total-paid = Total payé

# Options d'achat
shop-title-purchase-options = Options d'achat : { $itemName }
shop-msg-no-options = Aucune option d'achat disponible pour cet objet.

# Messages de boutique
shop-msg-item-removed = Objet retiré du panier.
shop-msg-cart-updated = Panier mis à jour.

# Notifications de réapprovisionnement
shop-restock-more-items = . . . et { $remaining } de plus.
shop-embed-title-restocked = Boutique réapprovisionnée !
shop-embed-footer-restocked = { $count } { $count ->
    [one] article réapprovisionné
   *[other] articles réapprovisionnés
}
