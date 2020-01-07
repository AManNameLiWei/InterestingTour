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

@interface QYTravelTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *likeBtn;
@end

@implementation QYTravelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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
    _titleLabel.backgroundColor = UIColor.redColor;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.top.equalTo(_iconImageView);
        make.height.equalTo(@20);
    }];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.backgroundColor = UIColor.cyanColor;
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.right.offset(-40);
        make.top.equalTo(_titleLabel.mas_bottom).offset(20);
        make.bottom.offset(-10);
    }];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn addTarget:self action:@selector(likeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [self.contentView addSubview:_likeBtn];
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-4);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.offset(32);
    }];
}

#pragma mark ------- 喜欢按钮点击
- (void)likeBtnClick {
    KPostNotificationWithParam(kNotificationLikeBtnClick, nil, @{@"title": _titleLabel.text});
    if (_likeBtn.selected) {
        //已经选中
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _likeBtn.selected = NO;
    } else {
        //未选中
        [_likeBtn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
        _likeBtn.selected = YES;
    }
}

#pragma mark ------- 设置数据
- (void)setData:(NSDictionary *)dataDic {
    [_iconImageView sd_setImageWithURL:dataDic[@"imgUrl"]];
    _titleLabel.text = dataDic[@"title"];
    _addressLabel.text = dataDic[@"address"];
}

@end
