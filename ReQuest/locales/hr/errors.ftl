## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ Ups!
error-report-description =
    { $exception }

    Ako je ova greška neočekivana ili sumnjate da bot ne radi ispravno, molimo prijavite grešku u [Službenom ReQuest Discord poslužitelju](https://discord.gg/Zq37gj4).

error-report-unexpected =
    Došlo je do neočekivane greške. Pokušajte ponovno.

    Ako se to nastavi, molimo prijavite grešku u [Službenom ReQuest Discord poslužitelju](https://discord.gg/Zq37gj4).

error-invalid-image-url =
    Jedan ili više URL-ova slika nisu valjani. Discord zahtijeva potpuni link koji počinje s `http://` ili `https://` i vodi izravno na sliku (na primjer, `https://example.com/banner.png`).

    Uredite zadatak i navedite valjane URL-ove slika ili ostavite polja prazna.
error-invalid-image-url-field = URL polja { $fieldName } nije valjan. Navedite potpuni link koji počinje s `http://` ili `https://`, ili ga ostavite praznim.
error-field-thumbnail = sličica
error-field-large-image = velika slika

# Check failures
error-owner-only = Samo vlasnik bota može koristiti ovu naredbu!
error-no-permission = Nemate dozvolu za pokretanje ove naredbe!
error-no-active-character = Nemate aktivnog lika na ovom poslužitelju!
error-no-registered-characters = Nemate nijednog registriranog lika!
error-no-characters = Ciljani igrač nema nijednog registriranog lika.
error-no-active-character-target = Ciljani igrač nema aktiviranog lika na ovom poslužitelju.
error-player-not-found = Podaci o igraču nisu pronađeni.
error-character-not-found = Podaci o liku nisu pronađeni.

# Currency/transaction errors
error-transaction-cannot-complete = Transakcija se ne može dovršiti:
    { $reason }
error-insufficient-item-trade = Imate { $owned }x { $itemName }, ali pokušavate dati { $quantity }.
error-currency-process-failed = Valuta { $currencyName } se nije mogla obraditi.
error-insufficient-funds-transaction = Nedovoljno sredstava za pokriće ove transakcije.
error-insufficient-funds = Nedovoljno sredstava.
error-insufficient-items = Nedovoljno predmeta: { $itemName }
error-currency-not-configured = Valuta '{ $currencyName }' nije konfigurirana na ovom poslužitelju.
error-cost-currency-system-mismatch = Valuta troška '{ $currencyName }' nije dio vlastitog valutnog sustava.
error-currency-config-error = Greška u konfiguraciji valute: 0 ili negativna vrijednost apoena.
error-currency-validation = Došlo je do greške pri validaciji valute: { $error }
error-invalid-currency = { $itemName } nije valjana valuta.
error-insufficient-funds-for-transaction = Nedovoljno sredstava za ovu transakciju.

# Cart errors
error-cart-not-found = Košarica nije pronađena.
error-item-not-in-cart = Predmet nije u košarici.
error-not-enough-stock = Nema dovoljno zaliha.

# Container errors
error-container-not-found = Spremnik nije pronađen.
error-container-name-empty = Naziv spremnika ne smije biti prazan.
error-container-name-too-long = Naziv spremnika ne smije imati više od { $maxLength } znakova.
error-max-containers-reached = Ne možete stvoriti više od { $maxContainers } spremnika.
error-container-name-exists = Spremnik s nazivom "{ $containerName }" već postoji.
error-item-already-in-container = Predmet je već u ovom spremniku.
error-quantity-minimum = Količina mora biti najmanje 1.
error-source-container-not-found = Izvorni spremnik nije pronađen.
error-item-not-in-source = Predmet "{ $itemName }" nije pronađen u izvornom spremniku.
error-insufficient-quantity-in-container = Nedovoljna količina. Imate { $available } u ovom spremniku.
error-dest-container-not-found = Odredišni spremnik nije pronađen.
error-item-not-in-container = Predmet "{ $itemName }" nije pronađen u ovom spremniku.
error-insufficient-quantity-consume = Imate samo { $available } ovog predmeta u ovom spremniku.
