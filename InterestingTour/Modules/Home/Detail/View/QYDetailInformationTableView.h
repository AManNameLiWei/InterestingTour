//
//  QYDetailInformationTableView.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cellClickBlock)(void);

@interface QYDetailInformationTableView : UITableView
@property (nonatomic, copy) cellClickBlock _Nullable cellClickblock;
- (instancetype _Nullable )initWithFrame:(CGRect)frame data:(nullable NSArray *)dataArray;
@end

