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

@interface QYTabBarController ()

@end

@implementation QYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadViewControllers];
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


@end
