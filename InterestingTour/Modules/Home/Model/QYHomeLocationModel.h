//
//  QYHomeLocationModel.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/21.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYBaseModel.h"
typedef void(^successBlock) (NSString * _Nullable city);
NS_ASSUME_NONNULL_BEGIN

@interface QYHomeLocationModel : QYBaseModel

- (void)startLocation;
@property (nonatomic, copy) successBlock locationSuccess;
@end

NS_ASSUME_NONNULL_END
