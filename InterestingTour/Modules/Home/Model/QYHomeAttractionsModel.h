//
//  QYHomeAttractionsModel.h
//  InterestingTour
//
//  Created by 厉威 on 2020/1/2.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYBaseModel.h"

@interface PicModel : QYBaseModel
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *picUrlSmall;
@end

@interface EntityModel : QYBaseModel
@property(nonatomic, copy) NSString *Amount;
@property(nonatomic, copy) NSString *PriceName;
@property(nonatomic, assign) NSUInteger PriceId;
@property(nonatomic, copy) NSString *TicketName;
@property(nonatomic, copy) NSString *EndDate;
@property(nonatomic, assign) NSUInteger TicketTypeId;
@property(nonatomic, copy) NSString *AmountAdvice;
@property(nonatomic, assign) NSUInteger PriceInSceneryId;
@property(nonatomic, copy) NSString *BeginDate;
@end

@interface PriceListModel : QYBaseModel
@property (nonatomic, strong) NSArray<EntityModel *> *entityList;
///门票类型
@property (nonatomic, copy) NSString *type;
@end

@interface LocationModel : QYBaseModel
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;
@end

@interface AttractionModel : QYBaseModel
@property(nonatomic, strong) NSArray<PriceListModel *> *priceList;
@property(nonatomic, strong) LocationModel *location;
@property(nonatomic, copy) NSString *areaName;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, copy) NSString *proId;
@property(nonatomic, strong) NSArray<PicModel *> *picList;
@property(nonatomic, copy) NSString *proName;
@property(nonatomic, copy) NSString *areaId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *ct;
@property(nonatomic, copy) NSString *ID;//数据为id，需要进行不同名称指定
@property(nonatomic, copy) NSString *cityId;
@property(nonatomic, copy) NSString *attention;
@property(nonatomic, copy) NSString *star;
@property(nonatomic, copy) NSString *coupon;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *cityName;
@property(nonatomic, copy) NSString *opentime;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *address;
@end

@interface PageBeanModel : QYBaseModel
@property (nonatomic, assign) NSUInteger allNum;
@property (nonatomic, assign) NSUInteger allPages;
@property (nonatomic, strong) NSArray<AttractionModel *> *contentlist;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger maxResult;
@end

@interface ShowApiResBodyModel : QYBaseModel
@property (nonatomic, strong) PageBeanModel *pagebean;
@property (nonatomic, assign) NSUInteger ret_code;
@end

@interface QYHomeAttractionsModel : QYBaseModel

@property(nonatomic, assign) NSUInteger showapi_res_code;
@property(nonatomic, strong) ShowApiResBodyModel *showapi_res_body;
@property(nonatomic, copy) NSString *showapi_res_error;
@property(nonatomic, copy) NSString *showapi_res_id;

- (void)searchAttarctions:(NSString *)cityName success:(void(^)(QYHomeAttractionsModel *model))success failed:(void(^)(NSString *errorStr))failed;
@end

