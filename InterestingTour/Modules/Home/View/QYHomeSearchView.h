//
//  QYHomeSearchView.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/30.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYBaseView.h"

typedef void(^searchBtnClickBlock)(NSString *cityName);

@interface QYHomeSearchView : QYBaseView
@property (nonatomic, copy) searchBtnClickBlock searchAttractions;
@end

