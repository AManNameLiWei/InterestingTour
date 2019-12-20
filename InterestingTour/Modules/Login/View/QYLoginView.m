//
//  QYLoginView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/20.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYLoginView.h"
#import <ReactiveObjC.h>

@implementation QYLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
#warning 未设置icon图片
    UIImageView *iconIV = [[UIImageView alloc] init];
    iconIV.image = [UIImage imageNamed:@""];
    iconIV.backgroundColor = UIColor.redColor;
    [self addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.centerX.equalTo(self.mas_centerX);
        make.height.width.equalTo(@64);
    }];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.enabled = YES;
    [self addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconIV.mas_bottom).offset(40);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.equalTo(@45);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.lightGrayColor;
    [phoneTextField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.mas_bottom).offset(-1);
        make.left.right.offset(0);
        make.height.equalTo(@1);
    }];

    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.placeholder = @"请输入新密码";
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    [self addSubview:passwordTextField];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.mas_bottom).offset(10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.equalTo(@45);
    }];
    UIView *secondLineView = [[UIView alloc] init];
    secondLineView.backgroundColor = UIColor.lightGrayColor;
    [passwordTextField addSubview:secondLineView];
    [secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordTextField.mas_bottom).offset(-1);
        make.left.right.equalTo(passwordTextField);
        make.height.equalTo(@1);
    }];

    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn addTarget:self action:@selector(confirmLoginBtnclick) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn setTitle:NSLocalizedString(@"agree_protocal_login", nil) forState:UIControlStateNormal];
    [confirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor colorWithRed:0.0 green:182/255.0 blue:106/255.0 alpha:0.7]];
    RAC(confirmBtn, enabled) = [RACSignal combineLatest:@[phoneTextField.rac_textSignal, passwordTextField.rac_textSignal] reduce:^id _Nonnull(NSString *phoneNum, NSString *password){
        if (phoneNum.length > 10 && password.length > 7) {
            [confirmBtn setBackgroundColor:[UIColor colorWithRed:0.0 green:182/255.0 blue:106/255.0 alpha:1]];
        }else{
            [confirmBtn setBackgroundColor:[UIColor colorWithRed:0.0 green:182/255.0 blue:106/255.0 alpha:0.7]];
        }
        return @(phoneNum.length > 10 && password.length > 7);
    }];
    [self addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordTextField.mas_bottom).offset(30);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(45);
    }];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdBtn setTitle:NSLocalizedString(@"forget_password", nil) forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetPwdBtn addTarget:self action:@selector(forgetPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [forgetPwdBtn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [self addSubview:forgetPwdBtn];
    [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmBtn.mas_bottom).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@15);
    }];
}

#pragma mark ------- 确认登录按钮点击
- (void)confirmLoginBtnclick {
    
}

#pragma mark ------- 忘记密码按钮点击
- (void)forgetPasswordBtnClick {
    
}

@end
