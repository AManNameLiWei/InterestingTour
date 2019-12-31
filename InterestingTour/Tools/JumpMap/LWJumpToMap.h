//
//  LWJumpToMap.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWJumpToMap : NSObject
+(UIAlertController *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)coord currentLocation:(CLLocationCoordinate2D)currentCoord;
@end

NS_ASSUME_NONNULL_END
