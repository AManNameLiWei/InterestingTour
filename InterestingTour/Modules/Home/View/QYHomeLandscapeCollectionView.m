//
//  QYHomeLandscapeCollectionView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/30.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeLandscapeCollectionView.h"
#import "QYHomeLandscapeCollectionViewCell.h"
#import <WSLWaterFlowLayout.h>

@interface QYHomeLandscapeCollectionView ()<WSLWaterFlowLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation QYHomeLandscapeCollectionView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)data{
    WSLWaterFlowLayout * flowLayout = [[WSLWaterFlowLayout alloc] init];
       flowLayout.delegate = self;
       flowLayout.flowLayoutStyle = WSLWaterFlowVerticalEqualWidth;
    self = [super initWithFrame:frame collectionViewLayout: flowLayout];
    if (self) {
        self.dataArray = data;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.whiteColor;
        [self registerClass:[QYHomeLandscapeCollectionViewCell class] forCellWithReuseIdentifier:@"QYHomeLandscapeCollectionViewCellID"];
    }
    return self;
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return CGSizeMake(0, 222);
    }
    if (indexPath.row == 4) {
        return CGSizeMake(0, 256);
    }
    return CGSizeMake(0, 200);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QYHomeLandscapeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QYHomeLandscapeCollectionViewCellID" forIndexPath:indexPath];
    [cell setData: self.dataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellClickBlock) {
        self.cellClickBlock(indexPath.row);
    }
}



@end
