//
//  QYHomeNavigationBarView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/21.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeNavigationBarView.h"

@implementation QYHomeNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_nav_bg"]];
    }
    return self;
}

- (void)setupUI {
    //    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [settingBtn setTitle:NSLocalizedString(@"setting", nil) forState:UIControlStateNormal];
    //    [settingBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    //    settingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    //    [self addSubview:settingBtn];
    //    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(settingBtn.superview.mas_right).offset(-20);
    //        make.height.equalTo(@19);
    //        make.bottom.equalTo(settingBtn.superview.mas_bottom).offset(-15);
    //    }];
    UILabel *cityNameLabel = [[UILabel alloc] init];
    cityNameLabel.font = [UIFont systemFontOfSize:18];
    cityNameLabel.text = @"kkk";
    cityNameLabel.layer.borderWidth = 0;
    [self addSubview:cityNameLabel];
    [cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.height.equalTo(@19);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
}


@end
