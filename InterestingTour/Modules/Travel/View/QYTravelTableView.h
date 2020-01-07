//
//  QYTravelTableView.h
//  InterestingTour
//
//  Created by 厉威 on 2020/1/3.
//  Copyright © 2020 厉威. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYTravelTableView : UITableView

- (instancetype)initWithFrame:(CGRect)frame data:(nullable NSArray *)dataArray;
- (void)reloadDataWithData:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
