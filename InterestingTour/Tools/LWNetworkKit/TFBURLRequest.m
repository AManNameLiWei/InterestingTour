//
//  TFBURLRequest.m
//  EncapsulateAFNetWorking
//
//  Created by 厉威 on 2019/10/15.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "TFBURLRequest.h"

@implementation TFBURLRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.HTTPMethod = @"POST";
        self.timeoutInterval = 30.f;
//        [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}
@end
