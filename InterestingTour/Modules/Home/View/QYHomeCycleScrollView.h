//
//  QYCycleScrollView.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <SDCycleScrollView/SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYHomeCycleScrollView : SDCycleScrollView

/// 滚动视图初始化方法
/// @param frame 视图尺寸
/// @param imageUrlsArray 滚动视图的图片URL数组
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)imageUrlsArray;
@end

NS_ASSUME_NONNULL_END
