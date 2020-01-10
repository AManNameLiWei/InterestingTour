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
#import "QYUserInfoManager.h"

@interface QYLoginViewController ()

@end

@implementation QYLoginViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupNavigationBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self initViews];
}

- (void)setupNavigationBar {
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBarBtnItemClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:NSLocalizedString(@"register_btn", nil) forState:UIControlStateNormal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:registerBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBarBtnItemClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"blackBack"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)initViews {
    QYLoginView *loginView = [[QYLoginView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeight+50, kScreenWidth, kScreenHeight-kStatusBarHeight-kNavigationBarHeight-kTabbarHeight)];
    [[loginView.loginBtnClickSubject ignore:nil] subscribeNext:^(NSDictionary * _Nullable x) {
        MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithFrame:CGRectMake((kScreenWidth - 200)/2.0, (kScreenHeight - 200)/2.0, 200, 200)];
        [self.view addSubview:progressHud];
        progressHud.detailsLabel.text = @"登录中";
        progressHud.detailsLabel.font = [UIFont boldSystemFontOfSize:14.f];
        [progressHud showAnimated:YES];
        [BmobUser loginInbackgroundWithAccount:x[@"phoneNum"] andPassword:x[@"pwd"] block:^(BmobUser *user, NSError *error) {
            if (user) {
                // 发送登录成功的通知并保存user
                KPostNotification(kNotificationNameLoginSuccess, nil);
                // 保存user
                [QYUserInfoManager sharedManager].user = user;
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

- (void)backBarBtnItemClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
