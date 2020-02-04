#import "CordovaPluginPrivacyScreen.h"

@implementation CordovaPluginPrivacyScreen

- (void)pluginInitialize
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppDidBecomeActive:)
                                               name:UIApplicationDidBecomeActiveNotification object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppWillResignActive:)
                                               name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)onAppWillResignActive:(UIApplication *)application {
    if (self.privacyScreenEnabled) {
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        window.backgroundColor = [UIColor clearColor];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = window.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        blurEffectView.tag = 1234;
        blurEffectView.alpha = 0;
        [window addSubview:blurEffectView];
        [window bringSubviewToFront:blurEffectView];

        // fade in the view
        [UIView animateWithDuration:0.5 animations:^{
            blurEffectView.alpha = 1;
        }];
    }
}

- (void)onAppDidBecomeActive:(UIApplication *)application {
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];

    // grab a reference to our custom blur view
    UIView *blurEffectView = [window viewWithTag:1234];

    // fade away colour view from main view
    [UIView animateWithDuration:0.5 animations:^{
        blurEffectView.alpha = 0;
    } completion:^(BOOL finished) {
        // remove when finished fading
        [blurEffectView removeFromSuperview];
    }];
}

- (void)enabled:(CDVInvokedUrlCommand*)command
 {
     id value = [command.arguments objectAtIndex:0];
     if (!([value isKindOfClass:[NSNumber class]])) {
         value = [NSNumber numberWithBool:NO];
     }

     self.privacyScreenEnabled = [value boolValue];
 }
@end




