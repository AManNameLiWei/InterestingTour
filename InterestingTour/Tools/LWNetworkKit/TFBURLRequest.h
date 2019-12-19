//
//  TFBURLRequest.h
//  EncapsulateAFNetWorking
//
//  Created by 厉威 on 2019/10/15.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFBURLRequest : NSMutableURLRequest

@property (nonatomic,strong )NSDictionary * _Nullable params;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * filePath;

@end

NS_ASSUME_NONNULL_END
