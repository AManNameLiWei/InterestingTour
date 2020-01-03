//
//  QYHomeLandscapeCollectionView.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/30.
//  Copyright © 2019 厉威. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cellClickBlock)(NSInteger row);

@interface QYHomeLandscapeCollectionView : UICollectionView
@property (nonatomic, copy) cellClickBlock cellClickBlock;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)data;
@end


