//
//  LWNetworkHelper.m
//  EncapsulateAFNetWorking
//
//  Created by 厉威 on 2019/10/14.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "LWNetworkHelper.h"
#import <AFNetworking.h>

@interface LWNetworkHelper ()

@end

@implementation LWNetworkHelper

+ (AFHTTPSessionManager *)sharedManager {
    static AFHTTPSessionManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg",nil];
        manager.requestSerializer.timeoutInterval = 60.f;
    });
    return manager;
}

#pragma mark ------- 二次封装  由manager类调用 --------

+ (void)sendRequest:(TFBURLRequest *)request
            success:(void (^)(TFBURLResponse * _Nonnull))responseBlock
            failure:(nonnull void (^)(NSError * _Nonnull))failureBlock {
    
    NSURLSessionDataTask *task = [[LWNetworkHelper sharedManager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        }else{
            TFBURLResponse *TFBResponse = [[TFBURLResponse alloc] init];
            TFBResponse.responseObject = responseObject;
            responseBlock(TFBResponse);
        }
    }];
    [task resume];
}

+ (void)uploadFile:(TFBURLRequest *)request
           success:(void (^)(TFBURLResponse * _Nonnull))responseBlock
           failure:(nonnull void (^)(NSError * _Nonnull))failureBlock {
    
    [LWNetworkHelper uploadFileWithUrl:request.URL.absoluteString paramas:request.params name:request.name filePath:request.filePath progress:^(float progress) {
        TFBURLResponse *TFBResponse = [[TFBURLResponse alloc]init];
        TFBResponse.progress = progress;
        responseBlock(TFBResponse);
    } success:^(id  _Nonnull responseObject) {
        TFBURLResponse *TFBResponse = [[TFBURLResponse alloc]init];
        TFBResponse.responseObject = responseObject;
        responseBlock(TFBResponse);
    } failure:^(NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (void)downloadFile:(TFBURLRequest *)request
             success:(void (^)(TFBURLResponse * _Nonnull))responseBlock
             failure:(nonnull void (^)(NSError * _Nonnull))failureBlock {
    
    [LWNetworkHelper downloadFileWithUrl:request.URL.absoluteString progress:^(float progress) {
        TFBURLResponse *TFBResponse = [[TFBURLResponse alloc]init];
        TFBResponse.progress = progress;
        responseBlock(TFBResponse);
    } success:^(NSString * _Nonnull path) {
        TFBURLResponse *TFBResponse = [[TFBURLResponse alloc]init];
        TFBResponse.filePath = path;
        responseBlock(TFBResponse);
    } failure:^(NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}

#pragma mark ------- 一次封装  外部可调用 --------

+ (void)GET:(NSString *)url
     params:(NSDictionary * __nullable)params
    success:(void (^)(id _Nonnull))successBlock
    failure:(void (^)(NSError * _Nonnull))failureBlock {
    
    [[LWNetworkHelper sharedManager] GET:url
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failureBlock(error);
        }
    }];
}

+ (void)POST:(NSString *)url
      params:(NSDictionary * __nullable)params
     success:(void (^)(id _Nonnull))successBlock
     failure:(void (^)(NSError * _Nonnull))failureBlock {
    
    [[LWNetworkHelper sharedManager] POST:url
                               parameters:params
                                 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    }
                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failureBlock(error);
        }
    }];
}

+ (void)uploadFileWithUrl:(NSString *)url
                  paramas:(NSDictionary *)paramas
                     name:(NSString *)name
                 filePath:(NSString *)filePath
                 progress:(void (^)(float))progressBlock
                  success:(void (^)(id _Nonnull))successBlock
                  failure:(void (^)(NSError * _Nonnull))failureBlock {
    
    NSURLSessionTask *task = [[LWNetworkHelper sharedManager] POST:url parameters:paramas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        NSError *error;
        [formData appendPartWithFileURL:fileUrl name:name error: &error];
        error ? failureBlock(error) : nil;
    }progress:^(NSProgress * _Nonnull uploadProgress) {
        uploadProgress ? progressBlock(uploadProgress.fractionCompleted) : nil;
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        error ? failureBlock(error) : nil;
    }];
    [task resume];
}

+ (void)downloadFileWithUrl:(NSString *)url
                   progress:(void (^)(float))progressBlock
                    success:(void (^)(NSString * _Nonnull))successBlock
                    failure:(void (^)(NSError * _Nonnull))failureBlock {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task = [[LWNetworkHelper sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        downloadProgress ? progressBlock(downloadProgress.fractionCompleted) : nil;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接文件目录
        NSString *downloaDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent: @"Download"];
        //打开文件管理器
        NSFileManager *manager = [NSFileManager defaultManager];
        //创建downlaod文件夹
        [manager createDirectoryAtPath:downloaDir withIntermediateDirectories:YES attributes:nil error: nil];
        //拼接文件路径
        NSString *filePath = [downloaDir stringByAppendingPathComponent: response.suggestedFilename];
        
        //如果文件已存在
        if ([manager fileExistsAtPath:filePath]) {
            NSError *deleteError;
            [manager removeItemAtPath:filePath error:&deleteError];
            if (deleteError) {
                failureBlock(deleteError);
            }
        }
        
        NSError *copyError;
        [manager copyItemAtURL:targetPath toURL:[NSURL fileURLWithPath:filePath] error:&copyError];
        if (copyError) {
            NSLog(@"存储错误------%@",copyError);
            failureBlock(copyError);
        }
        
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"下载失败-----%@", error);
            failureBlock(error);
            return;
        } else {
            successBlock(filePath.absoluteString);
        }
    }];
    
    [task resume];
}
@end
