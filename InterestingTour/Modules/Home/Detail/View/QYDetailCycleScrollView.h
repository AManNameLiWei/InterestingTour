//
//  QYDetailCycleScrollView.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <SDCycleScrollView/SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYDetailCycleScrollView : SDCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)imageUrlsArray;
@end

NS_ASSUME_NONNULL_END
