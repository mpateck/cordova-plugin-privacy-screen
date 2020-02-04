#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface CordovaPluginPrivacyScreen : CDVPlugin {
    @protected
    BOOL _privacyScreenEnabled;
}

@property (readwrite, assign) BOOL privacyScreenEnabled;

- (void)enabled:(CDVInvokedUrlCommand*)command;

@end