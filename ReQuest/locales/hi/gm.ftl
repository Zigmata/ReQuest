## Game Master module strings

# GM buttons
gm-btn-create = बनाएँ
gm-btn-edit-details = विवरण संपादित करें
gm-btn-toggle-ready = तैयारी टॉगल करें
gm-btn-configure-rewards = पुरस्कार कॉन्फ़िगर करें
gm-btn-remove-player = खिलाड़ी हटाएँ
gm-btn-cancel-quest = Quest रद्द करें
gm-btn-manage-party-rewards = पार्टी पुरस्कार प्रबंधित करें
gm-btn-manage-individual-rewards = व्यक्तिगत पुरस्कार प्रबंधित करें
gm-btn-join = शामिल हों
gm-btn-leave = छोड़ें
gm-btn-complete-quest = Quest पूर्ण करें
gm-btn-review-submission = सबमिशन समीक्षा करें
gm-btn-approve = स्वीकृत करें
gm-btn-deny = अस्वीकृत करें

# GM modals
gm-modal-title-create-quest = नई Quest बनाएँ
gm-modal-label-quest-title = Quest शीर्षक
gm-modal-placeholder-quest-title = अपनी quest का शीर्षक
gm-modal-label-restrictions = प्रतिबंध
gm-modal-placeholder-restrictions = प्रतिबंध, यदि कोई हों, जैसे खिलाड़ी स्तर
gm-modal-label-max-party = अधिकतम पार्टी आकार
gm-modal-placeholder-max-party = इस quest के लिए पार्टी का अधिकतम आकार
gm-modal-label-party-role = पार्टी भूमिका
gm-modal-placeholder-party-role = इस quest के लिए एक भूमिका बनाएँ (वैकल्पिक)
gm-modal-label-description = विवरण
gm-modal-placeholder-description = अपनी quest का विवरण यहाँ लिखें
gm-modal-title-editing-quest = { $questTitle } संपादित करें
gm-modal-label-title = शीर्षक
gm-modal-label-max-party-size = अधिकतम पार्टी आकार
gm-modal-title-add-reward = पुरस्कार जोड़ें
gm-modal-label-experience = अनुभव अंक
gm-modal-placeholder-experience = एक संख्या दर्ज करें
gm-modal-label-items = वस्तुएँ
gm-modal-placeholder-items =
    वस्तु: मात्रा
    वस्तु2: मात्रा
    आदि।
gm-modal-title-add-summary = Quest सारांश जोड़ें
gm-modal-label-summary = सारांश
gm-modal-placeholder-summary = Quest का कहानी सारांश जोड़ें
gm-modal-title-modifying-player = { $playerName } में बदलाव
gm-modal-placeholder-xp-add-remove = एक धनात्मक या ऋणात्मक संख्या दर्ज करें।
gm-modal-label-inventory = सामान
gm-modal-placeholder-inventory-modify =
    वस्तु: मात्रा
    वस्तु2: मात्रा
    आदि।
gm-modal-title-review-submission = सबमिशन समीक्षा
gm-modal-label-submission-id = सबमिशन ID
gm-modal-placeholder-submission-id = 8-अक्षर का ID दर्ज करें

# GM errors
gm-error-forbidden-role-name = पार्टी भूमिका के लिए दिया गया नाम प्रतिबंधित है।
gm-error-role-already-exists = इस सर्वर में उस नाम की भूमिका पहले से मौजूद है।
gm-error-no-quest-channel = Quest पोस्ट के लिए अभी तक कोई चैनल निर्धारित नहीं किया गया है। Quest चैनल कॉन्फ़िगर करने के लिए सर्वर एडमिन से संपर्क करें।
gm-error-cannot-ping-announce = चैनल { $channel } में घोषणा भूमिका { $role } को पिंग नहीं किया जा सका। अपने सर्वर एडमिन से चैनल और ReQuest भूमिका अनुमतियाँ जाँचें।
gm-error-invalid-item-format = अमान्य वस्तु प्रारूप: "{ $item }"। प्रत्येक वस्तु एक नई पंक्ति में होनी चाहिए, और प्रारूप "नाम: मात्रा" होना चाहिए।
gm-error-submission-not-found = सबमिशन नहीं मिली।
gm-error-already-on-quest = आप पहले से इस quest में { $characterName } के रूप में हैं।
gm-error-no-active-character-long = इस सर्वर पर आपका कोई सक्रिय चरित्र नहीं है। चरित्र पंजीकृत या सक्रिय करने के लिए `/player` का उपयोग करें।
gm-error-quest-locked = Quest {"**"}{ $questTitle }{"**"} में शामिल होने में त्रुटि: Quest GM द्वारा लॉक है।
gm-error-quest-full = Quest {"**"}{ $questTitle }{"**"} में शामिल होने में त्रुटि: Quest की सूची भरी हुई है!
gm-error-not-signed-up = आप इस quest के लिए पंजीकृत नहीं हैं।
gm-error-quest-channel-not-set = Quest चैनल सेट नहीं किया गया है!
gm-error-empty-roster = खाली सूची के साथ quest पूर्ण नहीं की जा सकती। इसके बजाय रद्द करने का प्रयास करें।
gm-error-invalid-xp-value = XP मान एक धनात्मक पूर्णांक होना चाहिए!

# GM confirm modals
gm-modal-title-cancel-quest = Quest रद्द करें
gm-modal-label-cancel-quest = Quest रद्द करने के लिए CONFIRM टाइप करें।
gm-modal-placeholder-cancel-quest = आगे बढ़ने के लिए "CONFIRM" टाइप करें।
gm-modal-title-remove-from-quest = चरित्र को quest से हटाएँ
gm-modal-label-remove-from-quest = चरित्र हटाने की पुष्टि करें?
gm-modal-placeholder-remove-from-quest = आगे बढ़ने के लिए "CONFIRM" टाइप करें।

# GM DM messages
gm-dm-quest-cancelled = Quest {"**"}{ $questTitle }{"**"} GM द्वारा रद्द कर दी गई।
gm-dm-quest-ready = Quest {"**"}{ $questTitle }{"**"} अब तैयार है!
gm-dm-quest-unlocked = Quest {"**"}{ $questTitle }{"**"} अब लॉक नहीं है।
gm-dm-quest-locked = Quest {"**"}{ $questTitle }{"**"} अब GM द्वारा लॉक है।
gm-dm-player-removed = आपको quest {"**"}{ $questTitle }{"**"} से हटा दिया गया।
gm-dm-player-removed-waitlist = आपको {"**"}{ $questTitle }{"**"} की प्रतीक्षा सूची से हटा दिया गया।
gm-dm-party-promotion = एक खिलाड़ी के हटने के कारण आपको {"**"}{ $questTitle }{"**"} की पार्टी में जोड़ दिया गया है!
gm-dm-roster-locked = Quest सूची लॉक और पार्टी को सूचित किया गया!
gm-dm-roster-unlocked = Quest सूची अनलॉक कर दी गई है।
gm-dm-rewards-no-characters =
    आपके सर्वर एडमिन ने GM के लिए quest पूर्ण करने पर पुरस्कार कॉन्फ़िगर किए हैं।
    हालाँकि, चूँकि आपका कोई पंजीकृत चरित्र नहीं है, इसलिए आपके पुरस्कार
    इस समय स्वचालित रूप से जारी नहीं किए जा सके।
gm-dm-rewards-no-active-character =
    आपके सर्वर एडमिन ने GM के लिए quest पूर्ण करने पर पुरस्कार कॉन्फ़िगर किए हैं।
    हालाँकि, चूँकि इस सर्वर पर आपका कोई सक्रिय चरित्र नहीं है, इसलिए आपके
    पुरस्कार इस समय स्वचालित रूप से जारी नहीं किए जा सके।
gm-dm-rewards-issued = आपके सक्रिय चरित्र { $characterName } को निम्नलिखित प्रदान किया गया है

# GM select menus
gm-select-placeholder-party-member = एक पार्टी सदस्य चुनें

# GM embeds
gm-embed-title-mod-report = GM खिलाड़ी संशोधन रिपोर्ट
gm-embed-field-experience = अनुभव
gm-embed-title-quest-complete = Quest पूर्ण: { $questTitle }
gm-embed-title-quest-completed = QUEST पूर्ण: { $questTitle }
gm-embed-field-rewards = पुरस्कार
gm-embed-field-party = __पार्टी__
gm-embed-field-summary = सारांश
gm-embed-title-gm-rewards = GM पुरस्कार जारी
gm-embed-field-items = वस्तुएँ
gm-msg-player-removed = खिलाड़ी हटाया गया और quest सूची अपडेट हो गई!

# GM views
gm-title-main-menu = GM - मुख्य मेनू
gm-menu-quests = Quests
gm-menu-desc-quests = Quest बनाएँ, संपादित करें और प्रबंधित करें।
gm-menu-players = खिलाड़ी
gm-menu-desc-players = खिलाड़ी सामान प्रबंधित करें और चरित्रों में बदलाव करें।
gm-menu-approvals = चरित्र स्वीकृतियाँ
gm-menu-desc-approvals = चरित्र सबमिशन की समीक्षा करें और स्वीकृत/अस्वीकृत करें।

gm-title-quest-management = GM - Quest प्रबंधन
gm-desc-create-quest = एक नई quest बनाएँ।
gm-msg-no-quests = कोई quest नहीं मिली।
gm-label-quest-locked = (लॉक)
gm-title-manage-quest = Quest प्रबंधित करें - { $questTitle } `{ $questId }`
gm-desc-edit-quest = शीर्षक, विवरण और पार्टी आकार जैसे quest विवरण संपादित करें।
gm-desc-toggle-ready = तैयारी स्थिति टॉगल करें (वर्तमान: {"**"}{ $status }{"**"})
    - Quest सूची लॉक करता है और पार्टी सदस्यों को सूचित करता है कि quest जल्द शुरू होगी। यदि कोई भूमिका कॉन्फ़िगर है, तो लॉक होने पर यह पार्टी सदस्यों को असाइन की जाएगी।
    - ओपन पर सेट करने पर सूची अनलॉक हो जाती है।
gm-label-ready-locked = लॉक/तैयार
gm-label-ready-open = ओपन
gm-desc-configure-rewards = चयनित quest के लिए पुरस्कार कॉन्फ़िगर करें।
gm-desc-complete-quest = Quest पूर्ण करें। पार्टी सदस्यों को पुरस्कार, यदि कोई हों, जारी करता है।
gm-desc-remove-player = Quest सूची से एक खिलाड़ी हटाएँ और उन्हें सूचित करें।
gm-desc-cancel-quest = Quest रद्द करें और quest बोर्ड से हटाएँ।
gm-title-player-management = GM - खिलाड़ी प्रबंधन
gm-desc-player-management =
    ये कमांड संदर्भ मेनू में स्थानांतरित हो गए हैं। निम्नलिखित मेनू विकल्पों के लिए किसी खिलाड़ी की प्रोफ़ाइल पर राइट-क्लिक (डेस्कटॉप) या लॉन्ग-प्रेस (मोबाइल) करें:

    - {"**"}खिलाड़ी संशोधन{"**"}: खिलाड़ी की वस्तुएँ और अनुभव जोड़ें या हटाएँ।
    - {"**"}खिलाड़ी देखें{"**"}: खिलाड़ी के सक्रिय चरित्र का विवरण देखें।
gm-title-remove-player = Quest से खिलाड़ी हटाएँ - { $questTitle }
gm-desc-remove-player-notes =
    __{"**"}खिलाड़ी हटाने के नोट्स{"**"}__

    - Quest सूची से हटाने के लिए नीचे ड्रॉपडाउन से एक खिलाड़ी चुनें।
    - यदि कोई खिलाड़ी प्रतीक्षा सूची में है, तो सूची का पहला खिलाड़ी पार्टी में प्रमोट किया जाएगा।
    - हटाए गए खिलाड़ी के व्यक्तिगत पुरस्कार quest से हटा दिए जाएँगे।
    - यदि आप पूर्व योगदान के लिए खिलाड़ी को पुरस्कृत करना चाहते हैं, तो सीधे पुरस्कार जारी करने के लिए `Modify Player` संदर्भ मेनू का उपयोग करें।
gm-label-no-players-in-roster = Quest सूची में कोई खिलाड़ी नहीं
gm-title-character-sheet = { $characterName } का चरित्र पत्र (<@{ $memberId }>)
gm-label-experience-points = __{"**"}अनुभव अंक:{"**"}__
gm-label-possessions = __{"**"}संपत्तियाँ{"**"}__
gm-label-currency-heading = {"**"}मुद्रा{"**"}
gm-msg-inventory-empty = सामान खाली है।

# GM approvals
gm-title-approvals = GM - सामान स्वीकृतियाँ
gm-desc-review-submission = समीक्षा और स्वीकृत/अस्वीकृत करने के लिए सबमिशन ID दर्ज करें।
gm-title-reviewing = समीक्षा: { $characterName }
gm-label-items = {"**"}वस्तुएँ:{"**"}
gm-label-currency = {"**"}मुद्रा:{"**"}
gm-embed-title-approved = सामान अपडेट स्वीकृत
gm-embed-desc-approved = {"**"}{ $characterName }{"**"} का सामान { $approver } द्वारा स्वीकृत किया गया है।
gm-embed-title-denied = सामान अपडेट अस्वीकृत
gm-embed-desc-denied = {"**"}{ $characterName }{"**"} का सामान { $denier } द्वारा अस्वीकृत किया गया है।

gm-modal-label-select-party-role = Party Role
gm-modal-desc-select-party-role = Select a role to assign to the quest party.
gm-select-option-no-role = None (No Party Role)

gm-error-role-hierarchy = ReQuest cannot manage the role "{ $roleName }" (ID: { $roleId }) because it is positioned higher than ReQuest's highest role in the server hierarchy. Please contact a server administrator to move the role below ReQuest's role, or assign ReQuest a higher role, then retry the operation.
gm-dm-role-removal-failed =
    ⚠️ Failed to remove the role {"**"}{ $roleName }{"**"} from the following members: { $members }.
    Please notify a server administrator to remove the role manually.
