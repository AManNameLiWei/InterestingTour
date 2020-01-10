//
//  QYLoginManager.h
//  InterestingTour
//
//  Created by 厉威 on 2020/1/9.
//  Copyright © 2020 厉威. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYLoginManager : NSObject

+ (QYLoginManager *)sharedManager;

- (void)presentLoginViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
