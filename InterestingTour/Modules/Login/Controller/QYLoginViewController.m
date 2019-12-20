//
//  QYLoginViewController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/20.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYLoginViewController.h"
#import "QYMineViewController.h"
#import "QYRegisterViewController.h"
#import "QYLoginView.h"

@interface QYLoginViewController ()

@end

@implementation QYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupNavigationBar];
    [self initViews];
}

- (void)setupNavigationBar {
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBarBtnItemClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:NSLocalizedString(@"register_btn", nil) forState:UIControlStateNormal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:registerBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)initViews {
    QYLoginView *loginView = [[QYLoginView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeight, kScreenWidth, kScreenHeight-kStatusBarHeight-kNavigationBarHeight-kTabbarHeight)];
    [self.view addSubview:loginView];
}

- (void)registerBarBtnItemClick {
    QYRegisterViewController *registerVc = [QYRegisterViewController new];
    [self.navigationController pushViewController:registerVc animated:YES];
}

@end
