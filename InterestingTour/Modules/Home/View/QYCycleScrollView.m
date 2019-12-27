//
//  QYCycleScrollView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYCycleScrollView.h"

@implementation QYCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)imageUrlsArray{
    if (self = [super initWithFrame:frame]) {
        //设置滚动间隔时间
        [self setAutoScrollTimeInterval:2.0];
        self.imageURLStringsGroup = imageUrlsArray;
    }
    return self;
}
@end