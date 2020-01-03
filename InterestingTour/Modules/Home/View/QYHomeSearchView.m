//
//  QYHomeSearchView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/30.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeSearchView.h"

@interface QYHomeSearchView ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation QYHomeSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UITextField *textField = [[UITextField alloc] init];
    _textField = textField;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"请输入您想去的地点，如：重庆";
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.bottom.offset(-5);
        make.left.equalTo(@10);
        make.right.offset(-kRealValue(50));
    }];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.bottom.right.offset(-5);
        make.left.equalTo(textField.mas_right).offset(5);
    }];
}

- (void)searchBtnClicked {
    if (self.searchAttractions) {
        if (_textField.text.length <= 0) {
            self.searchAttractions(@"重庆");
        }else {
            self.searchAttractions(_textField.text);
        }
    }
}

@end
