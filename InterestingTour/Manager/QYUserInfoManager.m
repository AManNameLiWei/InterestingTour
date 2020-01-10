//
//  QYUserInfoManager.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/9.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYUserInfoManager.h"
#import <BmobSDK/BmobUser.h>

static QYUserInfoManager *manager = nil;

@implementation QYUserInfoManager
+ (QYUserInfoManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [QYUserInfoManager new];
        }
    });
    return manager;
}

#pragma mark ------- 是否登录
- (BOOL)isLogin {
    if (self.user) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark ------- 退出登录
- (void)logout {
    self.user = nil;
}
@end
