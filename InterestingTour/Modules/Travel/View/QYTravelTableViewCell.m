//
//  QYTravelTableViewCell.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/7.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYTravelTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import <ReactiveObjC.h>

@interface QYTravelTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *likeBtn;
@end

@implementation QYTravelTableViewCell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    self.contentView.backgroundColor = highlighted ? [UIColor groupTableViewBackgroundColor] : UIColor.whiteColor;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.bottom.offset(-10);
        make.width.height.equalTo(@kRealValue(80));
    }];
    
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.top.equalTo(_iconImageView);
        make.height.equalTo(@20);
    }];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.right.offset(-40);
        make.top.equalTo(_titleLabel.mas_bottom).offset(20);
        make.bottom.offset(-10);
    }];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeBtn.selected = YES;
    [_likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [self.contentView addSubview:_likeBtn];
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-4);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.offset(32);
    }];
}

#pragma mark ------- 喜欢按钮点击
- (void)likeBtnClick:(UIButton *)sender {
    if (_likeBtn.selected) {
        //已经选中
        [_likeBtn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
        _likeBtn.selected = NO;
    } else {
        //未选中
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _likeBtn.selected = YES;
    }
    if (self.clickBlock) {
        self.clickBlock(_likeBtn.selected);
    }
    KPostNotificationWithParam(kNotificationLikeBtnClick, nil, (@{@"title": _titleLabel.text, @"isLike": @(_likeBtn.isSelected)}));
}

#pragma mark ------- 设置数据
- (void)setData:(NSDictionary *)dataDic {
    [_iconImageView sd_setImageWithURL:dataDic[@"imgUrl"]];
    _titleLabel.text = dataDic[@"title"];
    _addressLabel.text = dataDic[@"address"];
    _likeBtn.selected = [dataDic[@"isLike"] boolValue];
    if (_likeBtn.selected) {
        //已经选中
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    } else {
        //未选中
        [_likeBtn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    }
}

@end
