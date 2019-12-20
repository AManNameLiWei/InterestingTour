//
//  QYRegisterView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/20.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYRegisterView.h"
#import <ReactiveObjC.h>

@interface QYRegisterView ()

@end

@implementation QYRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"欢迎注册趣游！";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Oblique" size:25];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.width.equalTo(self);
        make.height.equalTo(@28);
    }];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.enabled = YES;
    [self addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.offset(20);
        make.right.offset(-110);
        make.height.equalTo(@45);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.lightGrayColor;
    [phoneTextField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.mas_bottom).offset(-1);
        make.left.offset(0);
        make.right.equalTo(phoneTextField.mas_right).offset(90);
        make.height.equalTo(@1);
    }];
    
    UIButton *getVerificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getVerificationCodeBtn addTarget:self action:@selector(getVerificationCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [getVerificationCodeBtn setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
    [getVerificationCodeBtn setTitle:NSLocalizedString(@"get_verification_code", nil) forState:UIControlStateNormal];
    RAC(getVerificationCodeBtn,enabled) = [RACSignal combineLatest:@[phoneTextField.rac_textSignal] reduce:^id _Nonnull(NSString *phoneNumLength){
        if (phoneNumLength.length > 10) {
            [getVerificationCodeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        }else{
            [getVerificationCodeBtn setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        }
        return @(phoneNumLength.length > 10);
    }];
    [self addSubview:getVerificationCodeBtn];
    [getVerificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneTextField.mas_centerY);
        make.height.equalTo(phoneTextField);
        make.right.equalTo(self).offset(-20);
    }];
    
    UITextField *verificationTextField = [[UITextField alloc] init];
    verificationTextField.placeholder = @"请输入验证码";
    verificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verificationTextField.borderStyle = UITextBorderStyleNone;
    [self addSubview:verificationTextField];
    [verificationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.mas_bottom).offset(10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.equalTo(@45);
    }];
    UIView *secondLineView = [[UIView alloc] init];
    secondLineView.backgroundColor = UIColor.lightGrayColor;
    [verificationTextField addSubview:secondLineView];
    [secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationTextField.mas_bottom).offset(-1);
        make.left.right.equalTo(verificationTextField);
        make.height.equalTo(@1);
    }];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.placeholder = @"请输入新密码（至少8位）";
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    [self addSubview:passwordTextField];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationTextField.mas_bottom).offset(10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.equalTo(@45);
    }];
    UIView *thirdLineView = [[UIView alloc] init];
    thirdLineView.backgroundColor = UIColor.lightGrayColor;
    [passwordTextField addSubview:thirdLineView];
    [thirdLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordTextField.mas_bottom).offset(-1);
        make.left.right.equalTo(passwordTextField);
        make.height.equalTo(@1);
    }];

    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn addTarget:self action:@selector(confirmRegisterBtnclick) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn setTitle:NSLocalizedString(@"agree_protocal_register", nil) forState:UIControlStateNormal];
    [confirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor colorWithRed:0.0 green:182/255.0 blue:106/255.0 alpha:0.7]];
    RAC(confirmBtn, enabled) = [RACSignal combineLatest:@[phoneTextField.rac_textSignal, verificationTextField.rac_textSignal, passwordTextField.rac_textSignal] reduce:^id _Nonnull(NSString *phoneNum, NSString *verificationCode, NSString *password){
        if (phoneNum.length > 10 && verificationCode.length > 3 && password.length > 7) {
            [confirmBtn setBackgroundColor:[UIColor colorWithRed:0.0 green:182/255.0 blue:106/255.0 alpha:1]];
        }else{
            [confirmBtn setBackgroundColor:[UIColor colorWithRed:0.0 green:182/255.0 blue:106/255.0 alpha:0.7]];
        }
        return @(phoneNum.length > 10 && verificationCode.length > 3 && password.length > 7);
    }];
    [self addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordTextField.mas_bottom).offset(30);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(45);
    }];
}

#pragma mark ------- 获取验证码按钮点击
- (void)getVerificationCodeBtnClick {
    
}

#pragma mark ------- 注册按钮点击
- (void)confirmRegisterBtnclick {
    
}
@end
