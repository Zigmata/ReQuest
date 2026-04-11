## Player module strings

# --- Cog ---

player-cmd-name = व्यापार
player-cmd-desc = खिलाड़ी मेनू

# --- Buttons ---

# Character management
player-btn-register-character = नया चरित्र पंजीकृत करें
player-btn-activate = सक्रिय करें
player-btn-active = सक्रिय

# Player board
player-btn-create-post = पोस्ट बनाएँ
player-btn-open-starting-shop = शुरुआती दुकान खोलें
player-btn-select-kit = किट चुनें
player-btn-input-inventory = सामान दर्ज करें

# Wizard / shop buttons
player-btn-add-to-cart = कार्ट में डालें
player-btn-add-to-cart-cost = कार्ट में डालें ({ $costString })
player-btn-view-purchase-options = खरीद विकल्प देखें
player-btn-review-submit = समीक्षा और सबमिट ({ $count })
player-btn-submit-character = चरित्र सबमिट करें
player-btn-keep-shopping = खरीदारी जारी रखें
player-btn-edit-quantity = मात्रा संपादित करें
player-btn-clear-cart = कार्ट खाली करें

# Kit buttons
player-btn-confirm-selection = चयन की पुष्टि करें
player-btn-back-to-kits = किट पर वापस जाएँ

# Inventory management
player-btn-spend-currency = मुद्रा खर्च करें
player-btn-print-inventory = सामान प्रिंट करें

# Container management
player-btn-manage-containers = कंटेनर प्रबंधित करें
player-btn-create-new = + नया बनाएँ
player-btn-consume-destroy = उपभोग/नष्ट करें
player-btn-move = स्थानांतरित करें
player-btn-move-all = सभी स्थानांतरित करें
player-btn-move-some = कुछ स्थानांतरित करें...
player-btn-back-to-overview = ← अवलोकन पर वापस
player-btn-cancel-move = ← रद्द करें
player-btn-up = ▲ ऊपर
player-btn-down = ▼ नीचे

# --- Modals ---

# Trade modal
player-modal-title-trade = { $targetName } के साथ व्यापार
player-modal-label-trade-name = नाम
player-modal-placeholder-trade-name = जिस वस्तु का व्यापार कर रहे हैं उसका नाम दर्ज करें
player-modal-label-trade-quantity = मात्रा
player-modal-placeholder-trade-quantity = व्यापार की मात्रा दर्ज करें

# Character register modal
player-modal-title-register = नया चरित्र पंजीकृत करें
player-modal-label-char-name = नाम
player-modal-placeholder-char-name = अपने चरित्र का नाम दर्ज करें।
player-modal-label-char-note = नोट
player-modal-placeholder-char-note = अपने चरित्र की पहचान के लिए एक नोट दर्ज करें

# Open inventory input modal
player-modal-title-starting-inventory = शुरुआती सामान इनपुट
player-modal-label-inventory = सामान
player-modal-placeholder-inventory-input =
    प्रति पंक्ति एक, <नाम>: <मात्रा> प्रारूप में, जैसे:
    तलवार: 1
    सोना: 30

# Spend currency modal
player-modal-title-spend-currency = मुद्रा खर्च करें
player-modal-label-currency-name = मुद्रा का नाम
player-modal-placeholder-currency-name = जो मुद्रा खर्च कर रहे हैं उसका नाम दर्ज करें
player-modal-label-currency-amount = राशि
player-modal-placeholder-currency-amount = खर्च की जाने वाली राशि दर्ज करें

# Create player post modal
player-modal-title-create-post = खिलाड़ी बोर्ड पोस्ट बनाएँ
player-modal-label-post-title = शीर्षक
player-modal-placeholder-post-title = अपनी पोस्ट के लिए शीर्षक दर्ज करें
player-modal-label-post-content = पोस्ट सामग्री
player-modal-placeholder-post-content = अपनी पोस्ट का मुख्य भाग दर्ज करें

# Edit player post modal
player-modal-title-edit-post = खिलाड़ी बोर्ड पोस्ट संपादित करें

# Wizard edit cart item modal
player-modal-title-edit-cart-qty = कार्ट मात्रा संपादित करें
player-modal-label-cart-qty = मात्रा
player-modal-placeholder-cart-qty = नई मात्रा दर्ज करें (हटाने के लिए 0)

# Create container modal
player-modal-title-create-container = नया कंटेनर बनाएँ
player-modal-label-container-name = कंटेनर का नाम
player-modal-placeholder-container-name = अपने कंटेनर का नाम दर्ज करें (जैसे, बैकपैक)

# Rename container modal
player-modal-title-rename-container = कंटेनर का नाम बदलें
player-modal-label-new-container-name = नया कंटेनर नाम
player-modal-placeholder-new-container-name = नया नाम दर्ज करें

# Consume from container modal
player-modal-title-consume = वस्तु उपभोग/नष्ट करें
player-modal-label-consume-qty = मात्रा (अधिकतम: { $maxQuantity })
player-modal-placeholder-consume-qty = उपभोग/नष्ट करने की मात्रा दर्ज करें

# Move item quantity modal
player-modal-title-move-item = वस्तु स्थानांतरित करें
player-modal-label-move-qty = स्थानांतरित करने की मात्रा (अधिकतम: { $maxQuantity })
player-modal-placeholder-move-qty = स्थानांतरित करने की मात्रा दर्ज करें

# --- Selects ---

player-select-placeholder-no-characters = आपका कोई पंजीकृत चरित्र नहीं है
player-select-placeholder-remove-character = हटाने के लिए चरित्र चुनें
player-select-placeholder-post = एक पोस्ट चुनें
player-select-placeholder-container-view = देखने के लिए कंटेनर चुनें...
player-select-placeholder-item = एक वस्तु चुनें...
player-select-placeholder-destination = गंतव्य चुनें...
player-select-placeholder-container = एक कंटेनर चुनें...
player-select-option-no-containers = कोई कंटेनर नहीं
player-select-option-no-items = कोई वस्तु नहीं
player-select-option-no-destinations = कोई गंतव्य नहीं

# --- Views ---

# PlayerBaseView - Main menu
player-title-main-menu = {"**"}खिलाड़ी कमांड - मुख्य मेनू{"**"}
player-menu-btn-characters = चरित्र
player-menu-desc-characters = खिलाड़ी चरित्र पंजीकृत करें, देखें और सक्रिय करें।
player-menu-btn-inventory = सामान
player-menu-desc-inventory = अपने सक्रिय चरित्र का सामान देखें और मुद्रा खर्च करें।
player-menu-btn-player-board = खिलाड़ी बोर्ड
player-menu-btn-player-board-disabled = खिलाड़ी बोर्ड (कॉन्फ़िगर नहीं)
player-menu-desc-player-board = खिलाड़ी बोर्ड के लिए पोस्ट बनाएँ

# CharacterBaseView
player-title-characters = {"**"}खिलाड़ी कमांड - चरित्र{"**"}
player-desc-register-character = एक नया चरित्र पंजीकृत करें।
player-msg-no-characters = आपका कोई चरित्र पंजीकृत नहीं है।
player-label-active = (सक्रिय)
player-label-xp = { $xp } XP

# Pending character
player-title-character-in-progress =
    {"**"}प्रगति में चरित्र: { $characterName }{"**"}
    आपका चरित्र पंजीकरण इन्वेंटरी सेटअप की प्रतीक्षा कर रहा है।
player-btn-resume = जारी रखें
player-btn-discard = त्यागें
player-modal-title-discard-character = चरित्र त्यागें
player-modal-label-discard-confirm = { $characterName } त्यागें?

# Confirm character removal
player-modal-title-confirm-char-removal = चरित्र हटाने की पुष्टि करें
player-modal-label-confirm-char-delete = { $characterName } हटाएँ?

# Confirm post removal
player-modal-title-confirm-post-removal = पोस्ट हटाने की पुष्टि करें
player-modal-label-post-removal-warning = चेतावनी: यह क्रिया अपरिवर्तनीय है!

# InventoryOverviewView
player-title-inventory = {"**"}खिलाड़ी कमांड - सामान{"**"}
player-title-char-inventory = {"**"}{ $characterName } का सामान{"**"}
player-msg-no-active-character = कोई सक्रिय चरित्र नहीं: इन मेनू का उपयोग करने के लिए इस सर्वर के लिए एक चरित्र सक्रिय करें।
player-msg-no-characters-registered = कोई चरित्र नहीं: इन मेनू का उपयोग करने के लिए एक चरित्र पंजीकृत करें।
player-label-container-summary = {"**"}{ $containerName }{"**"} — { $count } वस्तुएँ
player-label-currency = {"**"}मुद्रा{"**"}
player-msg-inventory-empty = सामान खाली है।

# Print inventory embed
player-embed-title-inventory = { $characterName } का सामान

# ContainerItemsView
player-msg-container-empty = यह कंटेनर खाली है।
player-label-selected-item = चयनित: {"**"}{ $itemName }{"**"}

# MoveDestinationView
player-title-move-item = {"**"}"{ $itemName }" स्थानांतरित करें{"**"} ({ $available } उपलब्ध)
player-msg-no-other-containers = कोई अन्य कंटेनर उपलब्ध नहीं।
player-msg-select-destination = गंतव्य कंटेनर चुनें:
player-label-destination = गंतव्य: {"**"}{ $destinationName }{"**"}

# ContainerManagementView
player-title-manage-containers = {"**"}कंटेनर प्रबंधित करें{"**"}
player-label-container-line = { $prefix }{"**"}{ $containerName }{"**"} ({ $count } वस्तुएँ){ $suffix }
player-label-default-suffix = { " " }(डिफ़ॉल्ट)
player-msg-no-containers = कोई कंटेनर नहीं।
player-label-selected-container = चयनित: {"**"}{ $containerName }{"**"}

# Confirm container deletion
player-modal-title-confirm-container-delete = कंटेनर हटाने की पुष्टि करें
player-modal-label-container-has-items = { $itemCount } वस्तुएँ हैं। खुली वस्तुओं में स्थानांतरित हो जाएँगी।
player-modal-label-confirm-container-delete = "{ $containerName }" हटाएँ?

# Container errors
player-error-cannot-rename-loose = खुली वस्तुओं का नाम नहीं बदला जा सकता।
player-error-cannot-delete-loose = खुली वस्तुएँ हटाई नहीं जा सकतीं।

# PlayerBoardView
player-title-player-board = {"**"}खिलाड़ी कमांड - खिलाड़ी बोर्ड{"**"}
player-desc-create-post = खिलाड़ी बोर्ड के लिए एक नई पोस्ट बनाएँ।
player-msg-no-posts = आपकी कोई मौजूदा पोस्ट नहीं है।
player-label-post-info = {"**"}{ $title }{"**"} (आईडी: `{ $postId }`)
player-embed-field-author = लेखक
player-embed-footer-post-id = पोस्ट ID: { $postId }
player-error-board-channel-not-found = खिलाड़ी बोर्ड चैनल नहीं मिला।

# NewCharacterWizardView
player-title-setup-inventory = {"**"}{ $characterName } के लिए सामान सेटअप{"**"}
player-desc-browse-shop = अपने चरित्र को सुसज्जित करने के लिए शुरुआती दुकान ब्राउज़ करें।
player-desc-select-kit = एक शुरुआती किट चुनें।
player-desc-input-inventory = अपना शुरुआती सामान मैन्युअल रूप से दर्ज करें।

# StaticKitSelectView
player-title-select-kit = {"**"}{ $characterName } के लिए किट चुनें{"**"}
player-msg-no-kits = कोई शुरुआती किट उपलब्ध नहीं है।
player-label-and-more-items = ...और { $count } और वस्तुएँ
player-label-empty-kit = {"*"}खाली किट{"*"}

# StaticKitConfirmView
player-title-confirm-kit = {"**"}चयन की पुष्टि करें: { $kitName }{"**"}
player-label-items-heading = {"**"}वस्तुएँ:{"**"}
player-label-currency-heading = {"**"}मुद्रा:{"**"}
player-msg-kit-empty = यह किट खाली है।

# NewCharacterComplexItemPurchaseView
player-title-purchase-options = {"**"}खरीद विकल्प: { $itemName }{"**"}
player-msg-no-cost-options = इस वस्तु के लिए कोई मूल्य विकल्प उपलब्ध नहीं है।
player-label-cost-option = {"**"}विकल्प { $index }:{"**"} { $costString }

# NewCharacterShopView
player-title-starting-shop = {"**"}शुरुआती दुकान ({ $inventoryType }){"**"}
player-label-starting-wealth = शुरुआती धन: { $formattedCurrency }
player-label-in-cart = {"**"}(कार्ट में: { $quantity }){"**"}

# NewCharacterCartView
player-title-review-cart = {"**"}कार्ट समीक्षा{"**"}
player-msg-cart-empty = आपका कार्ट खाली है।
player-label-cart-item = {"**"}{ $name }{"**"} x{ $quantity }
player-label-cart-item-total = (कुल: { $totalQuantity })
player-label-insufficient-currency = अपर्याप्त { $currencyName }
player-label-total-cost = {"**"}कुल लागत:{"**"}
player-label-total-cost-free = {"**"}कुल लागत:{"**"} मुफ़्त
player-label-cart-page = पृष्ठ { $current } / { $total }

# Trade embed
player-embed-title-trade = व्यापार रिपोर्ट
player-embed-desc-trade-sender = प्रेषक: { $senderMention } `{ $senderCharacter }` के रूप में
player-embed-desc-trade-recipient = प्राप्तकर्ता: { $recipientMention } `{ $recipientCharacter }` के रूप में
player-embed-field-currency = मुद्रा
player-embed-field-amount = राशि
player-embed-field-balance = { $characterName } का शेष
player-embed-field-item = वस्तु
player-embed-field-quantity = मात्रा
player-embed-footer-transaction-id = लेन-देन ID: { $transactionId }

# Trade errors
player-error-trade-no-characters = जिस खिलाड़ी के साथ आप व्यापार करने का प्रयास कर रहे हैं उसका कोई चरित्र नहीं है!
player-error-trade-no-active = जिस खिलाड़ी के साथ आप व्यापार करने का प्रयास कर रहे हैं उसका इस सर्वर पर कोई सक्रिय चरित्र नहीं है!

# Spend currency embed
player-embed-title-spend = खिलाड़ी लेन-देन रिपोर्ट
player-embed-desc-spend-player = खिलाड़ी: { $playerMention } `{ $characterName }` के रूप में
player-embed-desc-spend-transaction = लेन-देन: {"**"}{ $characterName }{"**"} ने {"**"}{ $formattedAmount }{"**"} खर्च किया।
player-embed-field-channel = चैनल
player-embed-field-receipt = रसीद

# Spend currency errors
player-error-amount-not-number = राशि एक संख्या होनी चाहिए।
player-error-amount-positive = आपको एक धनात्मक राशि खर्च करनी होगी।
player-error-amount-exceeds-maximum = राशि { $max } से अधिक नहीं हो सकती।
player-error-no-active-character-server = इस सर्वर पर आपका कोई सक्रिय चरित्र नहीं है।
player-error-no-currency-config = इस सर्वर के लिए मुद्रा कॉन्फ़िगरेशन नहीं मिला।

# Consume item embed
player-embed-title-consume = वस्तु उपभोग रिपोर्ट
player-embed-desc-consume = खिलाड़ी: { $playerMention } `{ $characterName }` के रूप में
player-embed-desc-consume-removed = हटाया गया: {"**"}{ $quantity }x { $itemName }{"**"} {"**"}{ $containerName }{"**"} से

# Consume item errors
player-error-qty-positive-integer = मात्रा एक धनात्मक पूर्णांक होनी चाहिए।
player-error-qty-at-least-one = मात्रा कम से कम 1 होनी चाहिए।
player-error-qty-only-have = आपके पास इस वस्तु की केवल { $maxQuantity } है।

# Inventory input errors
player-error-invalid-format = अमान्य प्रारूप: "{ $line }"। <नाम>: <मात्रा> का उपयोग करें।
player-error-empty-name = पंक्ति "{ $line }" में वस्तु का नाम खाली नहीं हो सकता।
player-error-invalid-quantity = "{ $name }" के लिए अमान्य मात्रा: "{ $quantity }"। एक धनात्मक पूर्णांक होनी चाहिए।
player-error-input-errors-header = सामान इनपुट में त्रुटियाँ:
player-msg-no-valid-items = कोई मान्य वस्तु नहीं दी गई। खाली सामान से आरंभ किया जा रहा है।

# Validation error view
player-validation-error-title = इनपुट त्रुटियां
player-validation-btn-retry = पुनः प्रयास करें

# Cart quantity validation
player-error-enter-valid-number = कृपया एक मान्य धनात्मक संख्या दर्ज करें।

# Submission embeds (approval queue)
player-embed-title-approval = सामान स्वीकृति: { $characterName }
player-embed-desc-submitted-by = { $userMention } द्वारा सबमिट
player-embed-field-items = वस्तुएँ
player-embed-field-currency-received = मुद्रा
player-embed-footer-submission-id = सबमिशन ID: { $submissionId }
player-label-approval-thread = स्वीकृति: { $characterName }
player-embed-title-submission-sent = सामान सबमिशन भेजा गया
player-embed-desc-submission-sent =
    {"**"}{ $characterName }{"**"} के लिए आपकी सबमिशन GM टीम को स्वीकृति के लिए भेज दी गई है!
    समीक्षा होने पर आपको सूचित किया जाएगा।
    [सबमिशन Thread देखें]({ $threadUrl })

# Direct apply embeds (no approval queue)
player-embed-title-starting-inventory = शुरुआती सामान लागू
player-embed-desc-starting-inventory = खिलाड़ी: { $playerMention } `{ $characterName }` के रूप में
player-embed-field-items-received = प्राप्त वस्तुएँ
player-embed-field-currency-received-label = प्राप्त मुद्रा
player-label-untitled = बिना शीर्षक

# ApprovalPostView
player-approval-post-header =
    {"**"}सामान सबमिशन: { $characterName }{"**"}
    { $userMention } द्वारा सबमिट
player-approval-post-items = वस्तुएं
player-approval-post-currency = मुद्रा
player-approval-resolved = यह अनुरोध हल हो गया है।
player-approval-btn-approve = स्वीकृत
player-approval-btn-deny = अस्वीकृत
player-approval-btn-edit = संपादित
player-approval-error-no-permission = आपको यह कार्य करने की अनुमति नहीं है।
player-approval-error-not-submitter = केवल मूल प्रस्तुतकर्ता ही इस अनुरोध को संपादित कर सकता है।
player-approval-thread-instructions =
    यह थ्रेड {"**"}{ $characterName }{"**"} की स्वीकृति के लिए बनाया गया था।
    एक Game Master सबमिशन की समीक्षा करेगा और इसे स्वीकृत या अस्वीकृत करेगा।
    स्वीकृत या अस्वीकृत होने के बाद, यह थ्रेड लॉक कर दिया जाएगा।

    {"**"}Game Masters:{"**"} अपने खिलाड़ी के साथ आवश्यक बदलावों पर
    चर्चा करें जब तक सामान स्वीकार्य स्थिति में न हो। `अस्वीकृत`
    बटन का उपयोग केवल असमाधेय सबमिशन के लिए करें।

    { $playerMention }: Game Master द्वारा यहाँ अनुरोधित बदलाव करने
    के लिए `संपादित` बटन का उपयोग करें।
player-approval-approved-by = यह अनुरोध { $approver } द्वारा स्वीकृत किया गया।
player-approval-denied-by = यह अनुरोध { $denier } द्वारा अस्वीकृत किया गया।
player-approval-deny-reason = कारण: { $reason }
player-msg-submission-updated = आपका अनुरोध अपडेट किया गया है।


# Denial modal
player-modal-title-deny-reason = अनुरोध अस्वीकार
player-modal-label-deny-reason = अस्वीकृति का कारण
player-modal-placeholder-deny-reason = वैकल्पिक: अस्वीकृति का कारण बताएं
# Approval DM notifications
player-dm-title-approved = चरित्र स्वीकृत
player-dm-desc-approved =
    आपका चरित्र {"**"}{ $characterName }{"**"} को { $approver } द्वारा
    {"**"}{ $guildName }{"**"} में स्वीकृत किया गया है!
player-dm-title-denied = चरित्र अस्वीकृत
player-dm-desc-denied =
    आपका चरित्र {"**"}{ $characterName }{"**"} को { $denier } द्वारा
    {"**"}{ $guildName }{"**"} में अस्वीकृत किया गया है।
