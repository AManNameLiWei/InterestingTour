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
#import <BmobSDK/Bmob.h>
#import <Toast.h>

@interface QYRegisterViewController ()
@property (nonatomic, strong) NSString *phoneNum;
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
    [[registerView.getVerificationCodeSubject ignore:nil] subscribeNext:^(id  _Nullable x) {
        self.phoneNum = [NSString stringWithFormat:@"%@",x];
        //获取验证码
        [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:x andTemplate:@"趣游" resultBlock:^(int msgId, NSError *error) {
            if (error) {
                [self.view makeToast:@"获取验证码失败，请稍后再试。"];
            } else {
                //获得smsID
                //                NSLog(@"sms ID：%d",msgId);
            }
        }];
    }];
    
    [[registerView.registerBtnClickSubject ignore:nil] subscribeNext:^(NSDictionary * _Nullable x) {
        [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:self.phoneNum andSMSCode:x[@"msgCode"] resultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                BmobUser *bUser = [[BmobUser alloc] init];
                [bUser setUsername:self.phoneNum];
                [bUser setPassword:x[@"pwd"]];
                [bUser setMobilePhoneNumber:self.phoneNum];
                [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
                    if (isSuccessful){
                        KPostNotification(kNotificationNameLoginSuccess, nil);
                    } else {
                        NSLog(@"%@",error);
                        [self.view makeToast:@"服务器繁忙，请稍后再试。"];
                    }
                }];
            } else {
                [self.view makeToast:@"验证码错误，请重新输入验证码。"];
            }
        }];
    }];
    [self.view addSubview:registerView];
}

@end
