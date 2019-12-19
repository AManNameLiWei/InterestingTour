
//
//  LWNetworkManager.m
//  EncapsulateAFNetWorking
//
//  Created by 厉威 on 2019/10/15.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "LWNetworkManager.h"
#import "LWNetworkHelper.h"

static LWNetworkManager *instance;

@implementation LWNetworkManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LWNetworkManager alloc]init];
    });
    
    return instance;
}

- (void)sendRequest:(void (CF_NOESCAPE^)(TFBURLRequest * _Nonnull))requestBlock success:(void (^)(TFBURLResponse * _Nonnull))responseBlock failure:(nonnull void (^)(NSError * _Nonnull))failureBlock{
    
    TFBURLRequest *request = [TFBURLRequest new];
    requestBlock(request);
    
    [LWNetworkHelper sendRequest:request success:^(TFBURLResponse * _Nonnull TFBResponse) {
        responseBlock(TFBResponse);
    } failure:^(NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

- (void)uploadFile:(void (^)(TFBURLRequest * _Nonnull))requestBlock success:(void (^)(TFBURLResponse * _Nonnull))responseBlock failure:(nonnull void (^)(NSError * _Nonnull))failureBlock{
    TFBURLRequest *request = [TFBURLRequest new];
    requestBlock(request);
    
    [LWNetworkHelper uploadFile:request success:^(TFBURLResponse * _Nonnull TFBResponse) {
        responseBlock(TFBResponse);
    } failure:^(NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (void)downloadFile:(void (^)(TFBURLRequest * _Nonnull))requestBlock success:(void (^)(TFBURLResponse * _Nonnull))responseBlock failure:(nonnull void (^)(NSError * _Nonnull))failureBlock{
    TFBURLRequest *request = [TFBURLRequest new];
    requestBlock(request);
    
    [LWNetworkHelper downloadFile:request success:^(TFBURLResponse * _Nonnull TFBResponse) {
        responseBlock(TFBResponse);
    } failure:^(NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

@end
