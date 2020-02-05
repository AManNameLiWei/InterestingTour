//
//  QYTravelNavigationBarView.h
//  InterestingTour
//
//  Created by 厉威 on 2020/1/10.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYBaseView.h"
@class RACSubject;
NS_ASSUME_NONNULL_BEGIN

@interface QYTravelNavigationBarView : QYBaseView
@property (nonatomic, strong) RACSubject *textFieldIsNullSubject;
@property (nonatomic, copy) void(^searchBtnClickBlock) (NSString *searchText);
@end

NS_ASSUME_NONNULL_END
