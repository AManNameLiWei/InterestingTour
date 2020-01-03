//
//  QYDetailInformationTableViewCell.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYDetailInformationTableViewCell.h"
#import <Masonry.h>

@interface QYDetailInformationTableViewCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation QYDetailInformationTableViewCell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    else {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = UIColor.grayColor;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];

    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [_contentLabel sizeToFit];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.right.offset(-30);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    _arrowImgView = [[UIImageView alloc] init];
    _arrowImgView.image = [UIImage imageNamed:@"arrow"];
    _arrowImgView.hidden = YES;
    [self.contentView addSubview:_arrowImgView];
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.width.height.equalTo(@20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

- (void)setData:(NSString *)contentString {
    _contentLabel.text = contentString;
}

@end
