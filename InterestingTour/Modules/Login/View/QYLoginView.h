//
//  QYLoginView.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/20.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYBaseView.h"
@class RACSubject;
NS_ASSUME_NONNULL_BEGIN

@interface QYLoginView : QYBaseView
@property (nonatomic, strong) RACSubject *loginBtnClickSubject;
@property (nonatomic, strong) RACSubject *forgetPwdBtnClickSubject;
@end

NS_ASSUME_NONNULL_END
