//
//  QYHomeLocationModel.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/21.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYBaseModel.h"
@class CLLocation;
typedef void(^successBlock) (NSString * _Nullable city, CLLocation *location);
typedef void(^failedBlock) (NSError * _Nullable error);
NS_ASSUME_NONNULL_BEGIN

@interface QYHomeLocationModel : QYBaseModel

- (void)startLocation;
@property (nonatomic, copy) successBlock locationSuccess;
@property (nonatomic, copy) failedBlock locationFailed;
@end

NS_ASSUME_NONNULL_END
