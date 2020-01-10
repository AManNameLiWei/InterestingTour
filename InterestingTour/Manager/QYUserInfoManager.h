//
//  QYUserInfoManager.h
//  InterestingTour
//
//  Created by 厉威 on 2020/1/9.
//  Copyright © 2020 厉威. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobUser;
NS_ASSUME_NONNULL_BEGIN

@interface QYUserInfoManager : NSObject

@property (nonatomic, strong) BmobUser *_Nullable user;

+ (QYUserInfoManager *)sharedManager;
///判断是否登录
- (BOOL)isLogin;
///退出
- (void)logout;
@end

NS_ASSUME_NONNULL_END
