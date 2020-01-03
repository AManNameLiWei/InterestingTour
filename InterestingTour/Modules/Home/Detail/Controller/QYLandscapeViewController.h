//
//  QYLandscapeViewController.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYRootViewController.h"
@class AttractionModel;
@class CLLocation;
NS_ASSUME_NONNULL_BEGIN

@interface QYLandscapeViewController : QYRootViewController
- (instancetype)init:(AttractionModel *)model currentLocation:(CLLocation *)location;
@end

NS_ASSUME_NONNULL_END
