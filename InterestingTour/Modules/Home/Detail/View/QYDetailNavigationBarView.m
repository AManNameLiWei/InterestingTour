//
//  QYDetailNavigationBarView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYDetailNavigationBarView.h"

@implementation QYDetailNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_nav_bg"]];
    }
    return self;
}

- (void)setupUI {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.6];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    ViewRadius(backBtn, 14);
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-5);
        make.width.height.equalTo(@28);
    }];
}

- (void)backBtnClick {
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
