//
//  QYDetailInformationTableViewCell.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYDetailInformationTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImgView;
- (void)setData:(NSString *)contentString;
@end

NS_ASSUME_NONNULL_END
