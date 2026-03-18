## Error and check failure strings

# Error embed wrapper
error-oops-title = ⚠️ ओह!
error-report-description =
    एक अपवाद आया:

    ```{ $exception }```

    यदि यह त्रुटि अप्रत्याशित है, या आपको लगता है कि बॉट सही ढंग से काम नहीं कर रहा है, तो कृपया [आधिकारिक ReQuest सहायता Discord](https://discord.gg/Zq37gj4) में बग रिपोर्ट सबमिट करें।

# Check failures
error-owner-only = केवल बॉट मालिक ही इस कमांड का उपयोग कर सकता है!
error-no-permission = आपके पास इस कमांड को चलाने की अनुमति नहीं है!
error-no-active-character = इस सर्वर पर आपका कोई सक्रिय चरित्र नहीं है!
error-no-registered-characters = आपका कोई पंजीकृत चरित्र नहीं है!
error-no-characters = लक्षित खिलाड़ी के पास कोई पंजीकृत चरित्र नहीं है।
error-no-active-character-target = लक्षित खिलाड़ी के पास इस सर्वर पर कोई सक्रिय चरित्र नहीं है।
error-player-not-found = खिलाड़ी डेटा नहीं मिला।
error-character-not-found = चरित्र डेटा नहीं मिला।

# Currency/transaction errors
error-transaction-cannot-complete = लेन-देन पूरा नहीं किया जा सकता:
    { $reason }
error-insufficient-item-trade = आपके पास { $owned }x { $itemName } है लेकिन आप { $quantity } देने की कोशिश कर रहे हैं।
error-currency-process-failed = मुद्रा { $currencyName } को संसाधित नहीं किया जा सका।
error-insufficient-funds-transaction = इस लेन-देन के लिए अपर्याप्त धनराशि।
error-insufficient-funds = अपर्याप्त धनराशि।
error-insufficient-items = अपर्याप्त वस्तु(एँ): { $itemName }
error-currency-not-configured = मुद्रा '{ $currencyName }' इस सर्वर पर कॉन्फ़िगर नहीं है।
error-cost-currency-system-mismatch = लागत मुद्रा '{ $currencyName }' अपने स्वयं के मुद्रा तंत्र का हिस्सा नहीं है।
error-currency-config-error = मुद्रा कॉन्फ़िगरेशन त्रुटि: 0 या नकारात्मक मूल्यवर्ग मान।
error-currency-validation = मुद्रा सत्यापन के दौरान त्रुटि आई: { $error }
error-invalid-currency = { $itemName } एक वैध मुद्रा नहीं है।
error-insufficient-funds-for-transaction = इस लेन-देन के लिए अपर्याप्त धनराशि।

# Cart errors
error-cart-not-found = कार्ट नहीं मिला।
error-item-not-in-cart = वस्तु कार्ट में नहीं है।
error-not-enough-stock = पर्याप्त स्टॉक उपलब्ध नहीं है।

# Container errors
error-container-not-found = कंटेनर नहीं मिला।
error-container-name-empty = कंटेनर का नाम खाली नहीं हो सकता।
error-container-name-too-long = कंटेनर का नाम { $maxLength } अक्षरों से अधिक नहीं हो सकता।
error-max-containers-reached = आप { $maxContainers } से अधिक कंटेनर नहीं बना सकते।
error-container-name-exists = "{ $containerName }" नाम का कंटेनर पहले से मौजूद है।
error-item-already-in-container = वस्तु पहले से इस कंटेनर में है।
error-quantity-minimum = मात्रा कम से कम 1 होनी चाहिए।
error-source-container-not-found = स्रोत कंटेनर नहीं मिला।
error-item-not-in-source = वस्तु "{ $itemName }" स्रोत कंटेनर में नहीं मिली।
error-insufficient-quantity-in-container = अपर्याप्त मात्रा। इस कंटेनर में आपके पास { $available } है।
error-dest-container-not-found = गंतव्य कंटेनर नहीं मिला।
error-item-not-in-container = वस्तु "{ $itemName }" इस कंटेनर में नहीं मिली।
error-insufficient-quantity-consume = इस कंटेनर में इस वस्तु की आपके पास केवल { $available } मात्रा है।
