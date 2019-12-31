//
//  QYDetailInformationView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYDetailInformationView.h"

@interface QYDetailInformationView ()
@property (nonatomic, strong) UILabel *openTimeLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation QYDetailInformationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _openTimeLabel = [[UILabel alloc] init];
    [self addSubview:_openTimeLabel];
    [_openTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.offset(0);
        make.height.equalTo(@40);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_openTimeLabel.mas_bottom).offset(5);
        make.left.right.equalTo(@0);
        make.height.equalTo(_openTimeLabel);
    }];
    
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
}
@end
