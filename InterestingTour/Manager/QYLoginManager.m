//
//  QYLoginManager.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/9.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYLoginManager.h"
#import "QYLoginViewController.h"
#import "QYLoginNavigationController.h"

static QYLoginManager *manager = nil;

@interface QYLoginManager ()
@property (nonatomic, strong) QYLoginNavigationController *loginNavigationController;
@end

@implementation QYLoginManager

+ (QYLoginManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [QYLoginManager new];
            [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(loginSuccess) name:kNotificationNameLoginSuccess object:nil];
        }
    });
    return manager;
}

#pragma mark ------- 弹出登录控制器
- (void)presentLoginViewController:(UIViewController *)viewController {
    self.loginNavigationController = [[QYLoginNavigationController alloc] init];
    [viewController presentViewController:self.loginNavigationController animated:YES completion:nil];
}

#pragma mark ------- 收到登录成功的通知
- (void)loginSuccess {
    [self.loginNavigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
