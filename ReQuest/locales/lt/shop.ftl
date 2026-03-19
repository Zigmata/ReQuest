## Shop module strings

# Shop cog
shop-error-no-shops = Šiam serveriui nesukonfigūruota jokių parduotuvių.
shop-error-not-shop-channel =
    Šis kanalas nėra registruotas kaip parduotuvės kanalas.
    Jei manote, kad čia turėtų būti parduotuvė, praneškite savo serverio administratoriui.

# Shop buttons
shop-btn-out-of-stock = Išparduota
shop-btn-view-options = Peržiūrėti pirkimo parinktis
shop-btn-add-to-cart = Įdėti į krepšelį ({ $cost })
shop-btn-view-cart = Peržiūrėti krepšelį
shop-btn-view-cart-count = Peržiūrėti krepšelį ({ $count })
shop-btn-back-to-shop = Grįžti į parduotuvę
shop-btn-clear-cart = Išvalyti krepšelį
shop-btn-checkout = Atsiskaityti
shop-btn-edit-quantity = Redaguoti kiekį

# Shop modals
shop-modal-title-edit-cart-qty = Redaguoti krepšelio kiekį
shop-modal-label-quantity = Kiekis
shop-modal-placeholder-quantity = Įveskite naują šio daikto kiekį
shop-error-invalid-number = Įveskite tinkamą skaičių.

# Shop views
shop-label-shopkeeper = Pardavėjas: {"**"}{ $name }{"**"}
shop-label-unknown-item = Nežinomas daiktas
shop-label-out-of-stock = IŠPARDUOTA
shop-label-stock-available = Likutis: { $available }
shop-label-in-cart = (Krepšelyje: { $quantity })
shop-title-cart = 🛒 {"**"}Pirkinių krepšelis{"**"}
shop-msg-cart-empty = Jūsų krepšelis tuščias.
shop-warning-no-active-character = ⚠️ Aktyvus veikėjas nerastas. Nepavyksta patikrinti lėšų.
shop-warning-insufficient-funds = ⚠️ Nepakanka lėšų: { $currency }
shop-label-invalid-cost = Netinkama kaina
shop-label-total-cost = {"**"}Bendra kaina:{"**"}
shop-label-warning = {"**"}Įspėjimas:{"**"}
shop-error-no-active-character = Neturite aktyvaus veikėjo šiame serveryje.
shop-error-checkout-insufficient = Atsiskaitymas nepavyko: nepakanka { $currency }.
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} išparduota.

# Shop report embed
shop-embed-title-report = Apsipirkimo ataskaita
shop-embed-field-purchased = Nupirkta
shop-label-no-items = Nėra daiktų
shop-embed-field-total-paid = Iš viso sumokėta

# Purchase options
shop-title-purchase-options = Pirkimo parinktys: { $itemName }
shop-msg-no-options = Šiam daiktui nėra galimų pirkimo parinkčių.

# Shop messages
shop-msg-item-removed = Daiktas pašalintas iš krepšelio.
shop-msg-cart-updated = Krepšelis atnaujintas.

# Restock notifications
shop-restock-more-items = . . . ir dar { $remaining }.
shop-embed-title-restocked = Parduotuvė papildyta!
shop-embed-footer-restocked = { $count } { $count ->
    [one] daiktas
    [few] daiktai
   *[other] daiktų
} papildyta
