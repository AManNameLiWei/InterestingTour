//
//  QYRegisterView.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/20.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYBaseView.h"
@class RACSubject;
NS_ASSUME_NONNULL_BEGIN

@interface QYRegisterView : QYBaseView
@property (nonatomic, strong) RACSubject *registerBtnClickSubject;
@property (nonatomic, strong) RACSubject *getVerificationCodeSubject;
@end

NS_ASSUME_NONNULL_END
