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
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *verificationTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *getVerificationCodeBtn;
@property (nonatomic, assign) NSUInteger timeOut;
@end

@implementation QYRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.registerBtnClickSubject = [RACSubject subject];
        self.getVerificationCodeSubject = [RACSubject subject];
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
    self.phoneTextField = phoneTextField;
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.enabled = YES;
    [self addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.offset(20);
        make.right.offset(-120);
        make.height.equalTo(@45);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColor.lightGrayColor;
    [phoneTextField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTextField.mas_bottom).offset(-1);
        make.left.offset(0);
        make.right.equalTo(phoneTextField.mas_right).offset(100);
        make.height.equalTo(@1);
    }];
    
    UIButton *getVerificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getVerificationCodeBtn = getVerificationCodeBtn;
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
    self.verificationTextField = verificationTextField;
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
    self.passwordTextField = passwordTextField;
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
    [self sentPhoneCodeTimeMethod];
    if (self.getVerificationCodeSubject) {
        [self.getVerificationCodeSubject sendNext:self.phoneTextField.text];
    }
}

#pragma mark ------- 注册按钮点击
- (void)confirmRegisterBtnclick {
    if (self.registerBtnClickSubject) {
        [self.registerBtnClickSubject sendNext:@{@"msgCode": self.verificationTextField.text, @"pwd": self.passwordTextField.text}];
    }
}

/**
 倒计时方法 在点击获取验证码按钮的方法里调用此方法即可实现, 需要在倒计时里修改按钮相关的请在此方法里yourButton修改
 */
- (void)sentPhoneCodeTimeMethod {
    //倒计时时间 - 60S
    __block NSInteger timeOut = 59;
    self.timeOut = timeOut;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                // 倒计时结束
                [self.getVerificationCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.getVerificationCodeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [self.getVerificationCodeBtn setEnabled:YES];
                [self.getVerificationCodeBtn setUserInteractionEnabled:YES];
            });
        } else {
            //开始计时
            //剩余秒数 seconds
            NSInteger seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.1ld", seconds];
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                NSString *title = [NSString stringWithFormat:@"%@ 重新发送",strTime];
                [self.getVerificationCodeBtn setTitle:title forState:UIControlStateNormal];
                // 设置按钮title居中 上面注释的方法无效
                [self.getVerificationCodeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
                [self.getVerificationCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [UIView commitAnimations];
                //计时器间不允许点击
                [self.getVerificationCodeBtn setUserInteractionEnabled:NO];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}
@end
