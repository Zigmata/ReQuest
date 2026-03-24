## Admin module strings

# Admin cog
admin-embed-title-unauthorized = अनधिकृत सर्वर
admin-embed-desc-unauthorized =
    ReQuest में आपकी रुचि के लिए धन्यवाद! आपका सर्वर ReQuest के अधिकृत परीक्षण सर्वरों की सूची में नहीं है।
    कृपया नीचे दिए गए सहायता Discord में शामिल हों, और परीक्षण एक्सेस का अनुरोध करने के लिए विकास दल से संपर्क करें।

    [ReQuest विकास Discord](https://discord.gg/Zq37gj4)
admin-embed-title-sync-guild = निम्नलिखित कमांड { $guildName }, ID { $guildId } से सिंक्रनाइज़ किए गए
admin-embed-title-sync-global = निम्नलिखित कमांड विश्व स्तर पर सिंक्रनाइज़ किए गए
admin-error-missing-scope = लक्षित गिल्ड में ReQuest के पास सही स्कोप नहीं है। `applications.commands` अनुमति जोड़ें और पुनः प्रयास करें।
admin-error-sync-failed = कमांड सिंक करने में त्रुटि आई: { $error }
admin-msg-commands-cleared = कमांड साफ़ कर दिए गए।

# Admin buttons
admin-btn-shutdown = बंद करें
admin-modal-title-confirm-shutdown = बंद करने की पुष्टि करें
admin-modal-label-shutdown-warning = चेतावनी! यह बॉट को बंद कर देगा। आगे बढ़ने के लिए पुष्टि टाइप करें।
admin-msg-shutting-down = बंद हो रहा है!
admin-btn-add-server = नया सर्वर जोड़ें
admin-btn-load-cog = Cog लोड करें
admin-msg-extension-loaded = एक्सटेंशन सफलतापूर्वक लोड हुआ: `{ $module }`
admin-btn-reload-cog = Cog रीलोड करें
admin-msg-extension-reloaded = एक्सटेंशन सफलतापूर्वक रीलोड हुआ: `{ $module }`
admin-btn-output-guilds = गिल्ड सूची दिखाएँ
admin-msg-connected-guilds = { $count } गिल्ड से जुड़ा हुआ है:

# Admin modals
admin-modal-title-add-server = अनुमति सूची में सर्वर ID जोड़ें
admin-modal-label-server-name = सर्वर का नाम
admin-modal-placeholder-server-name = Discord सर्वर के लिए एक छोटा नाम टाइप करें
admin-modal-label-server-id = सर्वर ID
admin-modal-placeholder-server-id = Discord सर्वर का ID टाइप करें
admin-select-placeholder-server = हटाने के लिए एक सर्वर चुनें
admin-modal-title-cog-action = Cog { $action }
admin-modal-label-cog-name = नाम
admin-modal-placeholder-cog-name = { $action } करने के लिए Cog का नाम दर्ज करें

# Admin views
admin-title-main-menu = प्रशासन - मुख्य मेनू
admin-desc-allowlist = आमंत्रण प्रतिबंधों के लिए सर्वर अनुमति सूची कॉन्फ़िगर करें।
admin-desc-cogs = Cog लोड या रीलोड करें।
admin-desc-guild-list = बॉट जिन सभी गिल्ड का सदस्य है उनकी सूची दिखाता है।
admin-desc-shutdown = बॉट को बंद करता है
admin-title-allowlist = प्रशासन - सर्वर अनुमति सूची
admin-desc-allowlist-warning =
    अनुमति सूची में एक नया Discord सर्वर ID जोड़ें।
    {"**"}चेतावनी: बॉट के सर्वर सदस्य होने के बिना दिए गए सर्वर ID की वैधता सत्यापित करने का कोई तरीका नहीं है। अपने इनपुट दोबारा जाँचें!{"**"}
admin-msg-no-servers = अनुमति सूची में कोई सर्वर नहीं है।

# Admin confirm modals
admin-modal-title-confirm-server-removal = सर्वर हटाने की पुष्टि करें
admin-modal-label-server-removal = सर्वर को अनुमति सूची से हटाएँ?

# Admin cog view
admin-title-cogs = प्रशासन - Cog
admin-desc-load-cog = नाम से बॉट cog लोड करें। फ़ाइल का नाम `<name>.py` होना चाहिए और ReQuest/cogs/ में संग्रहीत होनी चाहिए।
admin-desc-reload-cog = नाम से लोड किया गया cog रीलोड करें। वही नामकरण और फ़ाइल पथ प्रतिबंध लागू होते हैं।
