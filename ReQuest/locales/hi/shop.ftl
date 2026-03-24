## Shop module strings

# Shop cog
shop-error-no-shops = इस सर्वर के लिए कोई दुकान कॉन्फ़िगर नहीं है।
shop-error-not-shop-channel =
    यह चैनल एक दुकान चैनल के रूप में पंजीकृत नहीं है।
    यदि आपको लगता है कि यहाँ एक दुकान होनी चाहिए, तो अपने सर्वर एडमिन को बताएँ।

# Shop buttons
shop-btn-out-of-stock = स्टॉक में नहीं
shop-btn-view-options = खरीद विकल्प देखें
shop-btn-add-to-cart = कार्ट में डालें ({ $cost })
shop-btn-view-cart = कार्ट देखें
shop-btn-view-cart-count = कार्ट देखें ({ $count })
shop-btn-back-to-shop = दुकान पर वापस
shop-btn-clear-cart = कार्ट खाली करें
shop-btn-checkout = चेकआउट
shop-btn-edit-quantity = मात्रा संपादित करें

# Shop modals
shop-modal-title-edit-cart-qty = कार्ट मात्रा संपादित करें
shop-modal-label-quantity = मात्रा
shop-modal-placeholder-quantity = इस वस्तु की नई मात्रा दर्ज करें
shop-error-invalid-number = कृपया एक मान्य संख्या दर्ज करें।

# Shop views
shop-label-shopkeeper = दुकानदार: {"**"}{ $name }{"**"}
shop-label-unknown-item = अज्ञात वस्तु
shop-label-out-of-stock = स्टॉक में नहीं
shop-label-stock-available = स्टॉक: { $available }
shop-label-in-cart = (कार्ट में: { $quantity })
shop-title-cart = 🛒 {"**"}शॉपिंग कार्ट{"**"}
shop-msg-cart-empty = आपका कार्ट खाली है।
shop-warning-no-active-character = ⚠️ कोई सक्रिय चरित्र नहीं मिला। धन सत्यापित नहीं किया जा सकता।
shop-warning-insufficient-funds = ⚠️ { $currency } के लिए अपर्याप्त धन
shop-label-invalid-cost = अमान्य मूल्य
shop-label-total-cost = {"**"}कुल लागत:{"**"}
shop-label-warning = {"**"}चेतावनी:{"**"}
shop-error-no-active-character = इस सर्वर पर आपका कोई सक्रिय चरित्र नहीं है।
shop-error-checkout-insufficient = चेकआउट विफल: अपर्याप्त { $currency }।
shop-error-item-out-of-stock = {"**"}{ $itemName }{"**"} स्टॉक में नहीं है।

# Shop report embed
shop-embed-title-report = खरीदारी रिपोर्ट
shop-embed-field-purchased = खरीदा गया
shop-label-no-items = कोई वस्तु नहीं
shop-embed-field-total-paid = कुल भुगतान

# Purchase options
shop-title-purchase-options = खरीद विकल्प: { $itemName }
shop-msg-no-options = इस वस्तु के लिए कोई खरीद विकल्प उपलब्ध नहीं है।

# Shop messages
shop-msg-item-removed = वस्तु कार्ट से हटाई गई।
shop-msg-cart-updated = कार्ट अपडेट हो गया।

# Restock notifications
shop-restock-more-items = . . . और { $remaining } और।
shop-embed-title-restocked = दुकान पुनःस्टॉक हुई!
shop-embed-footer-restocked = { $count } { $count ->
    [one] वस्तु
   *[other] वस्तुएँ
} पुनःस्टॉक हुई
