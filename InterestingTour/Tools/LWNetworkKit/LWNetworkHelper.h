//
//  LWNetworkHelper.h
//  EncapsulateAFNetWorking
//
//  Created by 厉威 on 2019/10/14.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFBURLRequest.h"
#import "TFBURLResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWNetworkHelper : NSObject

#pragma mark ------- 一次封装 --------

///参数描述
/// @param url 请求地址
/// @param params 请求参数
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
+ (void)GET:(NSString *)url
     params:(NSDictionary * __nullable)params
    success:(void(^)(id responseObject))successBlock
    failure:(void(^)(NSError *error))failureBlock;

+ (void)POST:(NSString *)url
      params:(NSDictionary * __nullable)params
     success:(void(^)(id responseObject))successBlock
     failure:(void(^)(NSError *error))failureBlock;

+ (void)uploadFileWithUrl:(NSString *)url
                  paramas:(NSDictionary * __nullable)paramas
                     name:(NSString *)name
                 filePath:(NSString *)filePath
                 progress:(void(^)(float progress))progressBlock
                  success:(void(^)(id responseObject))successBlock
                  failure:(void(^)(NSError *error))failureBlock;

+ (void)downloadFileWithUrl:(NSString *)url
                   progress:(void(^)(float progress))progressBlock
                    success:(void(^)(NSString * path))successBlock
                    failure:(void(^)(NSError *error))failureBlock;


#pragma mark ------- 二次封装 --------

+ (void)sendRequest:(TFBURLRequest *)request
            success:(void(^)(TFBURLResponse * TFBResponse))responseBlock
            failure:(void(^)(NSError * error))failureBlock;

+ (void)uploadFile:(TFBURLRequest *)request
           success:(void(^)(TFBURLResponse * TFBResponse))responseBlock
           failure:(void(^)(NSError * error))failureBlock;

+ (void)downloadFile:(TFBURLRequest *)request
             success:(void(^)(TFBURLResponse * TFBResponse))responseBlock
             failure:(void(^)(NSError * error))failureBlock;

@end

NS_ASSUME_NONNULL_END
