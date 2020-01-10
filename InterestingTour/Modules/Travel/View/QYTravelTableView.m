//
//  QYTravelTableView.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/3.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYTravelTableView.h"
#import "QYTravelTableViewCell.h"
#import "QYTravelSpaceTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface QYTravelTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation QYTravelTableView

- (instancetype)initWithFrame:(CGRect)frame data:(nullable NSArray *)dataArray{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.dataArray = [NSMutableArray arrayWithArray:dataArray];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[QYTravelTableViewCell class] forCellReuseIdentifier:@"QYTravelTableViewCellID"];
        [self registerClass:[QYTravelSpaceTableViewCell class] forCellReuseIdentifier:@"QYTravelSpaceTableViewCellID"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataArray.firstObject allKeys].count == 0) {
        return kScreenHeight-kNavigationBarHeight-kStatusBarHeight-kTabbarHeight;
    }else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataArray.firstObject allKeys].count == 0) {
        QYTravelSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QYTravelSpaceTableViewCellID" forIndexPath:indexPath];
        return cell;
    }else {
        QYTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QYTravelTableViewCellID" forIndexPath:indexPath];
        [cell setData:self.dataArray[indexPath.row]];
        cell.clickBlock = ^(BOOL isSelected) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataArray[indexPath.row]];
            [dic setValue:@(isSelected) forKey:@"isLike"];
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:dic];
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ------- 更新数据
- (void)reloadDataWithData:(NSArray *)dataArray {
    self.dataArray = [NSMutableArray arrayWithArray:dataArray];
    if (self.dataArray.count == 0) {
        //没有数据时传入一个空字典,作为判断标识
        [self.dataArray addObject:@{}];
    }
    [self reloadData];
}
@end
