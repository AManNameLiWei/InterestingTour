//
//  QYRegisterViewController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/20.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYRegisterViewController.h"
#import "QYMineViewController.h"
#import "QYRegisterView.h"

@interface QYRegisterViewController ()

@end

@implementation QYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = UIColor.whiteColor;
    [self initViews];
}

- (void)initViews {
    QYRegisterView *registerView = [[QYRegisterView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeight, kScreenWidth, kScreenHeight-kStatusBarHeight-kNavigationBarHeight-kTabbarHeight)];
    [self.view addSubview:registerView];
}

@end
