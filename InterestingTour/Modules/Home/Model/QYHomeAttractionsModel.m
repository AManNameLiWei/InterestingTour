//
//  QYHomeAttractionsModel.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/2.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYHomeAttractionsModel.h"
#import <ShowAPIRequest.h>
#import <YYModel.h>


@implementation PicModel


@end



@implementation EntityModel


@end



@implementation PriceListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"entityList" : [EntityModel class]};
}
@end



@implementation LocationModel


@end



@implementation AttractionModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"picList" : [PicModel class],
             @"location" : [LocationModel class],
             @"priceList" : [PriceListModel class]
    };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID": @"id"};
}
@end



@implementation PageBeanModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"contentlist" : [AttractionModel class]};
}
@end



@implementation ShowApiResBodyModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pagebean" : [PageBeanModel class]};
}
@end



@implementation QYHomeAttractionsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"showapi_res_body" : [ShowApiResBodyModel class]};
}

- (void)searchAttarctions:(NSString *)cityName success:(void (^)(QYHomeAttractionsModel *))success failed:(void (^)(NSString *))failed{
    //创建请求实例
    ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:YI_YUAN_APP_KEY andSign:YI_YUAN_APP_SECRET ];
    //调用景点查询api
    [request post:@"http://route.showapi.com/268-1"
          timeout:20000//超时设置为20秒
           params:[[NSDictionary alloc] initWithObjectsAndKeys: cityName,@"keyword",@"",@"proId",@"",@"cityId",@"",@"areaId",@"",@"page", nil]
   withCompletion:^(NSDictionary<NSString *,id> *result) {
        QYHomeAttractionsModel *model = [QYHomeAttractionsModel yy_modelWithJSON:result];
        NSUInteger m = model.showapi_res_body.pagebean.allPages;
        if (m > 0) {
            success(model);
        } else {
            failed(@"请输入正确城市");
        }
    }];
}
@end
