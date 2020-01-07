//
//  QYTravelModel.h
//  InterestingTour
//
//  Created by 厉威 on 2020/1/7.
//  Copyright © 2020 厉威. All rights reserved.
//

#import <Realm/RLMObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYTravelModel : RLMObject

@property NSString *picUrl;
@property NSString *travelTitle;
@property NSString *travelAddress;
@property BOOL isLike;
@end
RLM_ARRAY_TYPE(QYTravelModel)
NS_ASSUME_NONNULL_END
