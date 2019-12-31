//
//  QYHomeLayoutDataModel.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/27.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYBaseModel.h"

@interface landscapeModel : QYBaseModel
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgHeight;
@property (nonatomic, copy) NSString *festival;
@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *description;
@end

@interface featuredImageModel : QYBaseModel
@property (nonatomic, copy) NSString *imgUrl;
@end

@interface QYHomeLayoutDataModel : QYBaseModel
@property (nonatomic, copy) NSString *pageCode;
@property (nonatomic, strong) NSArray<featuredImageModel *> *featuredImagesArray;
@property (nonatomic, strong) NSArray<landscapeModel *> *landscapesArray;
//- (void)getLayoutDataSuccess:(void(^)(NSDictionary *dic))success failed:(void(^)(NSError *error))failed;
@end

