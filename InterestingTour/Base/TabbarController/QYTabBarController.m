//
//  QYTabBarController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYTabBarController.h"
#import "QYHomeViewController.h"
#import "QYNavigationController.h"
#import "QYTravelViewController.h"
#import "QYMineViewController.h"
#import "QYLoginViewController.h"

@interface QYTabBarController ()

@end

@implementation QYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadViewControllers];
    [self receiveNotification];
}

- (void)loadViewControllers {
    QYHomeViewController *homeVc = [QYHomeViewController new];
    QYTravelViewController *travelVc = [QYTravelViewController new];
    QYMineViewController *mineVc = [QYMineViewController new];
    
    QYNavigationController *firstNavigationVC = [[QYNavigationController alloc] initWithRootViewController:homeVc];
    QYNavigationController *secondNavigationVC = [[QYNavigationController alloc] initWithRootViewController:travelVc];
    QYNavigationController *thirdNavigationVC = [[QYNavigationController alloc] initWithRootViewController:mineVc];

    self.viewControllers = @[firstNavigationVC,secondNavigationVC,thirdNavigationVC];
    
    firstNavigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"home"]];
    [firstNavigationVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    secondNavigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"行程" image:[UIImage imageNamed:@"travel"] selectedImage:[UIImage imageNamed:@"travel"]];
    [secondNavigationVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    thirdNavigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"mine"] selectedImage:[UIImage imageNamed:@"mine"]];
    [thirdNavigationVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
}

- (void)receiveNotification {
    // 监听登录成功
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNotificationNameLoginSuccess object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        QYNavigationController *mineNav = [self.viewControllers lastObject];
        mineNav.viewControllers = [NSArray arrayWithObject: [[QYMineViewController alloc] init]];
    }];
//    //退出登录成功
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:KNotificationLogOutSuccess object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//
//        TFBNavigationController *mineNav = [self.viewControllers lastObject];
//        mineNav.viewControllers = [NSArray arrayWithObject: [[TFBLoginManager new] getCurrentLoginController]];
//
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
//        // 延迟0.5秒执行。否则退出接口里获取不到tokenid,服务端无法完成token注销
//        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//            // 清除用户登录信息
//            [[TFBUserInfoManager sharedUserInfoManager] clearUserInfo];
//        });
//
//    }];
}


@end
