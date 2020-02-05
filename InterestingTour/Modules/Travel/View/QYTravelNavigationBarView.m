//
//  QYTravelNavigationBarView.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/10.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYTravelNavigationBarView.h"
#import "UIView+GradientBackground.h"
#import <ReactiveObjC.h>

@interface QYTravelNavigationBarView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation QYTravelNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addGradientBackground:self];
        self.textFieldIsNullSubject = [RACSubject subject];
    }
    return self;
}

- (void)setupUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = UIColor.whiteColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.offset(kStatusBarHeight + 5);
        make.bottom.offset(-5);
        make.left.equalTo(@10);
        make.right.offset(-kRealValue(10));
    }];
    ViewRadius(bgView, (kNavigationBarHeight - 10) / 2.0);

    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.delegate = self;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField = textField;
    textField.placeholder = @"搜索已收藏行程";
    [bgView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(5);
        make.right.offset(-kRealValue(50));
    }];
        
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"searchTravel"] forState:UIControlStateNormal];
    [bgView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.offset(-kRealValue(10));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [bgView addSubview:lineView];
    lineView.backgroundColor = UIColor.grayColor;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(1);
        make.left.equalTo(textField.mas_right).offset(0);
        make.top.offset(4);
        make.bottom.offset(-4);
    }];
}

- (void)searchBtnClick {
    if (self.searchBtnClickBlock) {
        if (_textField.text) {
            self.searchBtnClickBlock(_textField.text);
        }
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.textFieldIsNullSubject) {
        [self.textFieldIsNullSubject sendNext:nil];
    }
    return YES;
}
@end
