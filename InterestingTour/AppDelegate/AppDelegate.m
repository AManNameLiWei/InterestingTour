//
//  AppDelegate.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "AppDelegate.h"
#import "QYTabBarController.h"
#import <BmobSDK/Bmob.h>
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //后端云
    [Bmob registerWithAppKey:BMOB_APP_KEY];
    
    //IQKeyboardManager
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = [[QYTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
