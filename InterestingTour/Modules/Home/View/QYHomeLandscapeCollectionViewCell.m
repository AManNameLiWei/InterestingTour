//
//  QYHomeLandscapeCollectionViewCell.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/30.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeLandscapeCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface QYHomeLandscapeCollectionViewCell ()
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UIImageView *landscapeImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation QYHomeLandscapeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _landscapeImageView = [[UIImageView alloc] init];
    ViewRadius(_landscapeImageView, 5);
    [self.contentView addSubview:_landscapeImageView];
    [_landscapeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-45);
    }];
    
    _titleLabel = [[UILabel alloc] init];
//    _titleLabel.backgroundColor = UIColor.cyanColor;
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_landscapeImageView.mas_bottom).offset(5);
        make.left.right.bottom.equalTo(@0);
    }];
}

- (void)setData:(NSDictionary *)dataDic {
    self.dataDic = dataDic;
    [_landscapeImageView sd_setImageWithURL:self.dataDic[@"imgUrl"]];
    _titleLabel.text = self.dataDic[@"description"];
}
@end
