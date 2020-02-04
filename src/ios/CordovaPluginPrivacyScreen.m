#import "CordovaPluginPrivacyScreen.h"

@implementation CordovaPluginPrivacyScreen {

- (void)pluginInitialize
{
  if ([self settingForKey:@"PrivacyScreenEnabled"]) {
      self.privacyScreenEnabled = [(NSNumber*)[self settingForKey:@"PrivacyScreenEnabled"] boolValue];
  }

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppDidBecomeActive:)
                                               name:UIApplicationDidBecomeActiveNotification object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppWillResignActive:)
                                               name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)onAppWillResignActive:(UIApplication *)application {
    self.window.backgroundColor = [UIColor clearColor];

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.window.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    blurEffectView.tag = 1234;
    blurEffectView.alpha = 0;
    [self.window addSubview:blurEffectView];
    [self.window bringSubviewToFront:blurEffectView];

    // fade in the view
    [UIView animateWithDuration:0.5 animations:^{
        blurEffectView.alpha = 1;
    }];
}

- (void)onAppDidBecomeActive:(UIApplication *)application {
    // grab a reference to our custom blur view
    UIView *blurEffectView = [self.window viewWithTag:1234];

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




