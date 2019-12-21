//
//  QYNavigationBarView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/20.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYMineNavigationBarView.h"
#import "UIView+GradientBackground.h"

@implementation QYMineNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addGradientBackground:self];
    }
    return self;
}

- (void)setupUI {
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setTitle:NSLocalizedString(@"setting", nil) forState:UIControlStateNormal];
    [settingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:settingBtn];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(settingBtn.superview.mas_right).offset(-20);
        make.height.equalTo(@19);
        make.bottom.equalTo(settingBtn.superview.mas_bottom).offset(-15);
    }];
}
@end
