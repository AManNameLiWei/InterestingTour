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
#import <BmobSDK/Bmob.h>
#import <Toast.h>
#import <MBProgressHUD.h>

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
    [[loginView.loginBtnClickSubject ignore:nil] subscribeNext:^(NSDictionary * _Nullable x) {
        MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithFrame:CGRectMake((kScreenWidth - 200)/2.0, (kScreenHeight - 200)/2.0, 200, 200)];
        [self.view addSubview:progressHud];
        progressHud.detailsLabel.text = @"登录中";
        progressHud.detailsLabel.font = [UIFont boldSystemFontOfSize:14.f];
        [progressHud showAnimated:YES];
        [BmobUser loginInbackgroundWithAccount:x[@"phoneNum"] andPassword:x[@"pwd"] block:^(BmobUser *user, NSError *error) {
            if (user) {
                KPostNotification(kNotificationNameLoginSuccess, nil);
                [progressHud hideAnimated:YES];
            } else {
                [self.view makeToast:@"账号或密码错误，请重新输入"];
                DLog(@"%@",error.localizedDescription);
            }
        }];
    }];
    [self.view addSubview:loginView];
}

- (void)registerBarBtnItemClick {
    QYRegisterViewController *registerVc = [QYRegisterViewController new];
    [self.navigationController pushViewController:registerVc animated:YES];
}

@end
