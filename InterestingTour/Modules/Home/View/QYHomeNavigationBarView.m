//
//  QYHomeNavigationBarView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/21.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeNavigationBarView.h"

@interface QYHomeNavigationBarView ()
@property (nonatomic, strong) UILabel *cityNameLabel;
@end

@implementation QYHomeNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.backgroundColor = C_BUTTON_COLOR;
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
    self.cityNameLabel = cityNameLabel;
    cityNameLabel.font = [UIFont systemFontOfSize:18];
    cityNameLabel.text = @"正在定位";
    cityNameLabel.textColor = UIColor.whiteColor;
    cityNameLabel.layer.borderWidth = 0;
    [self addSubview:cityNameLabel];
    [cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.equalTo(@19);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
}

#pragma mark ------- 设置当前城市
- (void)setCurrentCity:(NSString *)city {
    self.cityNameLabel.text = city;
}


@end
