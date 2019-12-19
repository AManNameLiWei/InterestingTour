//
//  LWNetworkManager.h
//  EncapsulateAFNetWorking
//
//  Created by 厉威 on 2019/10/15.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFBURLRequest.h"
#import "TFBURLResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWNetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)sendRequest:(void(CF_NOESCAPE^)(TFBURLRequest * request))requestBlock success:(void(^)(TFBURLResponse * response))reseponseBlock failure:(void(^)(NSError * error))failureBlock;

- (void)uploadFile:(void(^)(TFBURLRequest * request))requestBlock success:(void(^)(TFBURLResponse * response))reseponseBlock failure:(void(^)(NSError * error))failureBlock;

- (void)downloadFile:(void(^)(TFBURLRequest * request))requestBlock success:(void(^)(TFBURLResponse * response))reseponseBlock failure:(void(^)(NSError * error))failureBlock;
@end

NS_ASSUME_NONNULL_END
