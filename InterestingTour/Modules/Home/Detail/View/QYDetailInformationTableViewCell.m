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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

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
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@30);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(5);
        make.right.offset(-20);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@30);
    }];
    
    _arrowImgView = [[UIImageView alloc] init];
    _arrowImgView.image = [UIImage imageNamed:@"arrow"];
    _arrowImgView.hidden = YES;
    [self.contentView addSubview:_arrowImgView];
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-4);
        make.width.height.equalTo(@16);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

- (void)setData:(NSString *)contentString {
    _contentLabel.text = contentString;
}

@end
