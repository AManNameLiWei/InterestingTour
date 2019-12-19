//
//  TFBURLResponse.h
//  EncapsulateAFNetWorking
//
//  Created by 厉威 on 2019/10/15.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFBURLResponse : NSHTTPURLResponse

@property (nonatomic,assign)id responseObject;
@property (nonatomic,assign)float progress;
@property (nonatomic,copy)NSString * filePath;
@end

NS_ASSUME_NONNULL_END
