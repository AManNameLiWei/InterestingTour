//
//  QYTravelTableViewCell.h
//  InterestingTour
//
//  Created by 厉威 on 2020/1/7.
//  Copyright © 2020 厉威. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYTravelTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, copy) void(^clickBlock)(BOOL isSelected);
- (void)setData:(NSDictionary *)dataDic;
@end

NS_ASSUME_NONNULL_END
