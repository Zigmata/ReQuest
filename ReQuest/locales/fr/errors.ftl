## Chaînes d'erreur et d'échec de vérification

# Embed d'erreur
error-oops-title = ⚠️ Oups !
error-report-description =
    Une exception est survenue :

    ```{ $exception }```

    Si cette erreur est inattendue, ou si vous pensez que le bot ne fonctionne pas correctement, veuillez soumettre un rapport de bug sur le [Discord officiel de support ReQuest](https://discord.gg/Zq37gj4).

# Échecs de vérification
error-owner-only = Seul le propriétaire du bot peut utiliser cette commande !
error-no-permission = Vous n'avez pas les permissions nécessaires pour exécuter cette commande !
error-no-active-character = Vous n'avez pas de personnage actif sur ce serveur !
error-no-registered-characters = Vous n'avez aucun personnage enregistré !
error-no-characters = Le joueur ciblé n'a aucun personnage enregistré.
error-no-active-character-target = Le joueur ciblé n'a pas de personnage activé sur ce serveur.
error-player-not-found = Données du joueur introuvables.
error-character-not-found = Données du personnage introuvables.

# Erreurs de monnaie/transaction
error-transaction-cannot-complete = La transaction ne peut pas être finalisée :
    { $reason }
error-insufficient-item-trade = Vous possédez { $owned }x { $itemName } mais essayez d'en donner { $quantity }.
error-currency-process-failed = La monnaie { $currencyName } n'a pas pu être traitée.
error-insufficient-funds-transaction = Fonds insuffisants pour couvrir cette transaction.
error-insufficient-funds = Fonds insuffisants.
error-insufficient-items = Objet(s) insuffisant(s) : { $itemName }
error-currency-not-configured = La monnaie « { $currencyName } » n'est pas configurée sur ce serveur.
error-cost-currency-system-mismatch = La monnaie de coût « { $currencyName } » ne fait pas partie de son propre système monétaire.
error-currency-config-error = Erreur de configuration de la monnaie : valeur de dénomination nulle ou négative.
error-currency-validation = Une erreur est survenue lors de la validation de la monnaie : { $error }
error-invalid-currency = { $itemName } n'est pas une monnaie valide.
error-insufficient-funds-for-transaction = Fonds insuffisants pour cette transaction.

# Erreurs de panier
error-cart-not-found = Panier introuvable.
error-item-not-in-cart = Objet absent du panier.
error-not-enough-stock = Stock disponible insuffisant.

# Erreurs de conteneur
error-container-not-found = Conteneur introuvable.
error-container-name-empty = Le nom du conteneur ne peut pas être vide.
error-container-name-too-long = Le nom du conteneur ne peut pas dépasser { $maxLength } caractères.
error-max-containers-reached = Vous ne pouvez pas créer plus de { $maxContainers } conteneurs.
error-container-name-exists = Un conteneur nommé « { $containerName } » existe déjà.
error-item-already-in-container = L'objet est déjà dans ce conteneur.
error-quantity-minimum = La quantité doit être d'au moins 1.
error-source-container-not-found = Conteneur source introuvable.
error-item-not-in-source = L'objet « { $itemName } » est introuvable dans le conteneur source.
error-insufficient-quantity-in-container = Quantité insuffisante. Vous en avez { $available } dans ce conteneur.
error-dest-container-not-found = Conteneur de destination introuvable.
error-item-not-in-container = L'objet « { $itemName } » est introuvable dans ce conteneur.
error-insufficient-quantity-consume = Vous n'avez que { $available } de cet objet dans ce conteneur.
