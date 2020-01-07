//
//  QYTravelTableView.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/3.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYTravelTableView.h"
#import "QYTravelTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface QYTravelTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation QYTravelTableView

- (instancetype)initWithFrame:(CGRect)frame data:(nullable NSArray *)dataArray{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.dataArray = dataArray;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[QYTravelTableViewCell class] forCellReuseIdentifier:@"QYTravelTableViewCellID"];
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
    return [tableView fd_heightForCellWithIdentifier:@"QYTravelTableViewCellID" cacheByIndexPath:indexPath configuration:^(QYTravelTableViewCell *cell) {
        // 配置 cell 的数据源，和 "cellForRow" 干的事一致，比如：
        [cell setData:self.dataArray[indexPath.row]];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QYTravelTableViewCellID" forIndexPath:indexPath];
    [cell setData:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark ------- 更新数据
- (void)reloadDataWithData:(NSArray *)dataArray {
    self.dataArray = dataArray;
    [self reloadData];
}
@end
