## Player module strings

# --- Cog ---

player-cmd-name = Vaihtokauppa
player-cmd-desc = Pelaajavalikot

# --- Buttons ---

# Character management
player-btn-register-character = Rekisteröi uusi hahmo
player-btn-activate = Aktivoi
player-btn-active = Aktiivinen

# Player board
player-btn-create-post = Luo julkaisu
player-btn-open-starting-shop = Avaa aloituskauppa
player-btn-select-kit = Valitse varustesarja
player-btn-input-inventory = Syötä inventaario

# Wizard / shop buttons
player-btn-add-to-cart = Lisää koriin
player-btn-add-to-cart-cost = Lisää koriin ({ $costString })
player-btn-view-purchase-options = Näytä ostovaihtoehdot
player-btn-review-submit = Tarkista ja lähetä ({ $count })
player-btn-submit-character = Lähetä hahmo
player-btn-keep-shopping = Jatka ostoksia
player-btn-edit-quantity = Muokkaa määrää
player-btn-clear-cart = Tyhjennä ostoskori

# Kit buttons
player-btn-confirm-selection = Vahvista valinta
player-btn-back-to-kits = Takaisin varustesarjoihin

# Inventory management
player-btn-spend-currency = Käytä valuuttaa
player-btn-print-inventory = Tulosta inventaario

# Container management
player-btn-manage-containers = Hallinnoi säiliöitä
player-btn-create-new = + Luo uusi
player-btn-consume-destroy = Kuluta/tuhoa
player-btn-move = Siirrä
player-btn-move-all = Siirrä kaikki
player-btn-move-some = Siirrä osa...
player-btn-back-to-overview = ← Takaisin yleiskatsaukseen
player-btn-cancel-move = ← Peruuta
player-btn-up = ▲ Ylös
player-btn-down = ▼ Alas

# --- Modals ---

# Trade modal
player-modal-title-trade = Vaihtokauppa pelaajan { $targetName } kanssa
player-modal-label-trade-name = Nimi
player-modal-placeholder-trade-name = Syötä vaihdettavan esineen nimi
player-modal-label-trade-quantity = Määrä
player-modal-placeholder-trade-quantity = Syötä vaihdettava määrä

# Character register modal
player-modal-title-register = Rekisteröi uusi hahmo
player-modal-label-char-name = Nimi
player-modal-placeholder-char-name = Syötä hahmosi nimi.
player-modal-label-char-note = Muistiinpano
player-modal-placeholder-char-note = Syötä muistiinpano hahmosi tunnistamiseksi

# Open inventory input modal
player-modal-title-starting-inventory = Aloitusinventaarion syöttö
player-modal-label-inventory = Inventaario
player-modal-placeholder-inventory-input =
    Yksi per rivi muodossa <nimi>: <määrä>, esim.:
    Miekka: 1
    kulta: 30

# Spend currency modal
player-modal-title-spend-currency = Käytä valuuttaa
player-modal-label-currency-name = Valuutan nimi
player-modal-placeholder-currency-name = Syötä käytettävän valuutan nimi
player-modal-label-currency-amount = Summa
player-modal-placeholder-currency-amount = Syötä käytettävä summa

# Create player post modal
player-modal-title-create-post = Luo pelaajataulun julkaisu
player-modal-label-post-title = Otsikko
player-modal-placeholder-post-title = Syötä julkaisusi otsikko
player-modal-label-post-content = Julkaisun sisältö
player-modal-placeholder-post-content = Syötä julkaisusi teksti

# Edit player post modal
player-modal-title-edit-post = Muokkaa pelaajataulun julkaisua

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = Muokkaa ostoskorin määrää
player-modal-label-cart-qty = Määrä
player-modal-placeholder-cart-qty = Syötä uusi määrä (0 poistaaksesi)

# Create container modal
player-modal-title-create-container = Luo uusi säiliö
player-modal-label-container-name = Säiliön nimi
player-modal-placeholder-container-name = Syötä säiliön nimi (esim. Reppu)

# Rename container modal
player-modal-title-rename-container = Nimeä säiliö uudelleen
player-modal-label-new-container-name = Uusi säiliön nimi
player-modal-placeholder-new-container-name = Syötä uusi nimi

# Consume from container modal
player-modal-title-consume = Kuluta/tuhoa esine
player-modal-label-consume-qty = Määrä (maks: { $maxQuantity })
player-modal-placeholder-consume-qty = Syötä kulutettava/tuhottava määrä

# Move item quantity modal
player-modal-title-move-item = Siirrä esine
player-modal-label-move-qty = Siirrettävä määrä (maks: { $maxQuantity })
player-modal-placeholder-move-qty = Syötä siirrettävä määrä

# --- Selects ---

player-select-placeholder-no-characters = Sinulla ei ole rekisteröityjä hahmoja
player-select-placeholder-remove-character = Valitse poistettava hahmo
player-select-placeholder-post = Valitse julkaisu
player-select-placeholder-container-view = Valitse tarkasteltava säiliö...
player-select-placeholder-item = Valitse esine...
player-select-placeholder-destination = Valitse kohde...
player-select-placeholder-container = Valitse säiliö...
player-select-option-no-containers = Ei säiliöitä
player-select-option-no-items = Ei esineitä
player-select-option-no-destinations = Ei kohteita

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}Pelaajakomennot - Päävalikko{"**"}
player-menu-btn-characters = Hahmot
player-menu-desc-characters = Rekisteröi, tarkastele ja aktivoi pelaajahahmoja.
player-menu-btn-inventory = Inventaario
player-menu-desc-inventory = Tarkastele aktiivisen hahmosi inventaariota ja käytä valuuttaa.
player-menu-btn-player-board = Pelaajataulu
player-menu-btn-player-board-disabled = Pelaajataulu (ei määritetty)
player-menu-desc-player-board = Luo julkaisu pelaajataululle

# CharacterBaseView
player-title-characters = {"**"}Pelaajakomennot - Hahmot{"**"}
player-desc-register-character = Rekisteröi uusi hahmo.
player-msg-no-characters = Sinulla ei ole rekisteröityjä hahmoja.
player-label-active = (Aktiivinen)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}Hahmo kesken: { $characterName }{"**"}
    Hahmosi rekisteröinti odottaa varusteluettelon määritystä.
player-btn-resume = Jatka
player-btn-discard = Hylkää
player-modal-title-discard-character = Hylkää hahmo
player-modal-label-discard-confirm = Hylkää { $characterName }?

# Confirm character removal
player-modal-title-confirm-char-removal = Vahvista hahmon poisto
player-modal-label-confirm-char-delete = Poistetaanko { $characterName }?

# Confirm post removal
player-modal-title-confirm-post-removal = Vahvista julkaisun poisto
player-modal-label-post-removal-warning = VAROITUS: Tätä toimintoa ei voi kumota!

# InventoryOverviewView
player-title-inventory = {"**"}Pelaajakomennot - Inventaario{"**"}
player-title-char-inventory = {"**"}{ $characterName } - Inventaario{"**"}
player-msg-no-active-character = Ei aktiivista hahmoa: Aktivoi hahmo tällä palvelimella käyttääksesi näitä valikkoja.
player-msg-no-characters-registered = Ei hahmoja: Rekisteröi hahmo käyttääksesi näitä valikkoja.
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } esinettä
player-label-currency = {"**"}Valuutta{"**"}
player-msg-inventory-empty = Inventaario on tyhjä.

# Print inventory embed
player-embed-title-inventory = { $characterName } - Inventaario

# ContainerItemsView
player-msg-container-empty = Tämä säiliö on tyhjä.
player-label-selected-item = Valittu: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}Siirrä "{ $itemName }"{"**"} ({ $available } saatavilla)
player-msg-no-other-containers = Muita säiliöitä ei ole saatavilla.
player-msg-select-destination = Valitse kohdesäiliö:
player-label-destination = Kohde: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}Hallinnoi säiliöitä{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } esinettä){ $suffix }
player-label-default-suffix = { " " }(oletus)
player-msg-no-containers = Ei säiliöitä.
player-label-selected-container = Valittu: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = Vahvista säiliön poisto
player-modal-label-container-has-items = Sisältää { $itemCount } esinettä. Siirretään irtonaisiin esineisiin.
player-modal-label-confirm-container-delete = Poistetaanko "{ $containerName }"?

# Container errors
player-error-cannot-rename-loose = Irtonaisia esineitä ei voi nimetä uudelleen.
player-error-cannot-delete-loose = Irtonaisia esineitä ei voi poistaa.

# PlayerBoardView
player-title-player-board = {"**"}Pelaajakomennot - Pelaajataulu{"**"}
player-desc-create-post = Luo uusi julkaisu pelaajataululle.
player-msg-no-posts = Sinulla ei ole julkaisuja.
player-label-post-info = {"**"}{ $title }{"**"} (ID: `{ $postId }`)
player-embed-field-author = Tekijä
player-embed-footer-post-id = Julkaisun ID: { $postId }
player-error-board-channel-not-found = Pelaajataulun kanavaa ei löytynyt.

# NewCharacterWizardView
player-title-setup-inventory = {"**"}Inventaarion asetukset: { $characterName }{"**"}
player-desc-browse-shop = Selaa aloituskauppaa varustaaksesi hahmosi.
player-desc-select-kit = Valitse aloitusvarustesarja.
player-desc-input-inventory = Syötä aloitusinventaariosi manuaalisesti.

# StaticKitSelectView
player-title-select-kit = {"**"}Valitse varustesarja: { $characterName }{"**"}
player-msg-no-kits = Aloitusvarustesarjoja ei ole saatavilla.
player-label-and-more-items = ...ja { $count } esinettä lisää
player-label-empty-kit = {"*"}Tyhjä varustesarja{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}Vahvista valinta: { $kitName }{"**"}
player-label-items-heading = {"**"}Esineet:{"**"}
player-label-currency-heading = {"**"}Valuutta:{"**"}
player-msg-kit-empty = Tämä varustesarja on tyhjä.

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}Ostovaihtoehdot: { $itemName }{"**"}
player-msg-no-cost-options = Tälle esineelle ei ole saatavilla ostovaihtoehtoja.
player-label-cost-option = {"**"}Vaihtoehto { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}Aloituskauppa ({ $inventoryType }){"**"}
player-label-starting-wealth = Aloitusvarallisuus: { $formattedCurrency }
player-label-in-cart = {"**"}(Korissa: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}Tarkista ostoskori{"**"}
player-msg-cart-empty = Ostoskorisi on tyhjä.
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (Yhteensä: { $totalQuantity })
player-label-insufficient-currency = Riittämätön { $currencyName }
player-label-total-cost = {"**"}Kokonaishinta:{"**"}
player-label-total-cost-free = {"**"}Kokonaishinta:{"**"} Ilmainen
player-label-cart-page = Sivu { $current }/{ $total }

# Trade embed
player-embed-title-trade = Vaihtokaupparaportti
player-embed-desc-trade-sender = Lähettäjä: { $senderMention } hahmona `{ $senderCharacter }`
player-embed-desc-trade-recipient = Vastaanottaja: { $recipientMention } hahmona `{ $recipientCharacter }`
player-embed-field-currency = Valuutta
player-embed-field-amount = Summa
player-embed-field-balance = { $characterName } - Saldo
player-embed-field-item = Esine
player-embed-field-quantity = Määrä
player-embed-footer-transaction-id = Tapahtumatunnus: { $transactionId }

# Trade errors
player-error-trade-no-characters = Pelaajalla, jonka kanssa yrität vaihtaa, ei ole hahmoja!
player-error-trade-no-active = Pelaajalla, jonka kanssa yrität vaihtaa, ei ole aktiivista hahmoa tällä palvelimella!

# Spend currency embed
player-embed-title-spend = Pelaajan tapahtumaraportti
player-embed-desc-spend-player = Pelaaja: { $playerMention } hahmona `{ $characterName }`
player-embed-desc-spend-transaction = Tapahtuma: {"**"}{ $characterName }{"**"} käytti {"**"}{ $formattedAmount }{"**"}.
player-embed-field-channel = Kanava
player-embed-field-receipt = Kuitti

# Spend currency errors
player-error-amount-not-number = Summan on oltava numero.
player-error-amount-positive = Käytettävän summan on oltava positiivinen.
player-error-amount-exceeds-maximum = Summa ei voi ylittää { $max }.
player-error-no-active-character-server = Sinulla ei ole aktiivista hahmoa tällä palvelimella.
player-error-no-currency-config = Tälle palvelimelle ei löytynyt valuuttamääritystä.

# Consume item embed
player-embed-title-consume = Esineen kulutusraportti
player-embed-desc-consume = Pelaaja: { $playerMention } hahmona `{ $characterName }`
player-embed-desc-consume-removed = Poistettu: {"**"}{ $quantity }x { $itemName }{"**"} säiliöstä {"**"}{ $containerName }{"**"}

# Consume item errors
player-error-qty-positive-integer = Määrän on oltava positiivinen kokonaisluku.
player-error-qty-at-least-one = Määrän on oltava vähintään 1.
player-error-qty-only-have = Sinulla on vain { $maxQuantity } tätä esinettä.

# Inventory input errors
player-error-invalid-format = Virheellinen muoto: "{ $line }". Käytä muotoa <nimi>: <määrä>.
player-error-empty-name = Esineen nimi ei voi olla tyhjä rivillä: "{ $line }".
player-error-invalid-quantity = Virheellinen määrä esineelle "{ $name }": "{ $quantity }". Arvon on oltava positiivinen kokonaisluku.
player-error-input-errors-header = Virheitä inventaarion syötteessä:
player-msg-no-valid-items = Kelvollisia esineitä ei annettu. Alustetaan tyhjällä inventaariolla.

# Cart quantity validation
player-error-enter-valid-number = Syötä kelvollinen positiivinen numero.

# Submission embeds (approval queue)
player-embed-title-approval = Inventaarion hyväksyntä: { $characterName }
player-embed-desc-submitted-by = Lähettäjä: { $userMention }
player-embed-field-items = Esineet
player-embed-field-currency-received = Valuutta
player-embed-footer-submission-id = Hakemustunnus: { $submissionId }
player-label-approval-thread = Hyväksyntä: { $characterName }
player-embed-title-submission-sent = Inventaariohakemus lähetetty
player-embed-desc-submission-sent =
    Hakemuksesi hahmolle {"**"}{ $characterName }{"**"} on lähetetty GM-tiimille hyväksyttäväksi!
    Saat ilmoituksen, kun se on tarkistettu.
    [Näytä hakemusketju]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = Aloitusinventaario sovellettu
player-embed-desc-starting-inventory = Pelaaja: { $playerMention } hahmona `{ $characterName }`
player-embed-field-items-received = Saadut esineet
player-embed-field-currency-received-label = Saatu valuutta
player-label-untitled = Nimetön

# ApprovalPostView
player-approval-post-header =
    {"**"}Inventory Submission: { $characterName }{"**"}
    Submitted by { $userMention }
player-approval-post-items = Esineet
player-approval-post-currency = Valuutta
player-approval-resolved = Tämä hakemus on käsitelty.
player-approval-btn-approve = Hyväksy
player-approval-btn-deny = Hylkää
player-approval-btn-edit = Muokkaa
player-approval-error-no-permission = Sinulla ei ole oikeutta tähän toimintoon.
player-approval-error-not-submitter = Vain alkuperäinen lähettäjä voi muokata tätä hakemusta.
player-approval-thread-instructions =
    This thread was created for the approval of a character's starting inventory.
    A Game Master will review the submission and approve or deny it.
    The submitting player may use the Edit button to modify and re-submit.
    Once approved or denied, this thread will be locked.
player-msg-submission-updated = Hakemuksesi on päivitetty.

# Approval DM notifications
player-dm-title-approved = Hahmo hyväksytty
player-dm-desc-approved =
    Your character {"**"}{ $characterName }{"**"} has been approved
    by { $approver } in {"**"}{ $guildName }{"**"}!
player-dm-title-denied = Hahmo hylätty
player-dm-desc-denied =
    Your character {"**"}{ $characterName }{"**"} has been denied
    by { $denier } in {"**"}{ $guildName }{"**"}. You may re-submit.
