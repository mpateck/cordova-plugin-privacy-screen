var exec = require('cordova/exec');


 var PrivacyScreen = function () {};

 PrivacyScreen.enabled = function(enabled) {
     exec(null, null, "CordovaPluginPrivacyScreen", "enabled", [enabled]);
 };

 module.exports = PrivacyScreen; 