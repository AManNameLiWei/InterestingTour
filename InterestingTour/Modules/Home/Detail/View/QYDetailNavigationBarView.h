//
//  QYDetailNavigationBarView.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYBaseView.h"

typedef void(^backBlock)(void);

@interface QYDetailNavigationBarView : QYBaseView

@property (nonatomic, copy) backBlock backBlock;
@end


