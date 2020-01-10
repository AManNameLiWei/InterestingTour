//
//  QYTravelNavigationBarView.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/10.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYTravelNavigationBarView.h"
#import "UIView+GradientBackground.h"

@interface QYTravelNavigationBarView ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation QYTravelNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addGradientBackground:self];
    }
    return self;
}

- (void)setupUI {
    UITextField *textField = [[UITextField alloc] init];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField = textField;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"搜索已收藏行程";
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kStatusBarHeight + 5);
        make.bottom.offset(-5);
        make.left.equalTo(@10);
        make.right.offset(-kRealValue(10));
    }];
    ViewRadius(textField, (kNavigationBarHeight - 10) / 2.0);
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"searchTravel"] forState:UIControlStateNormal];
    [textField addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.offset(-10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [textField addSubview:lineView];
    lineView.backgroundColor = UIColor.grayColor;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(1);
        make.right.equalTo(searchBtn.mas_left).offset(-10);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

- (void)searchBtnClick {
    
}
@end
