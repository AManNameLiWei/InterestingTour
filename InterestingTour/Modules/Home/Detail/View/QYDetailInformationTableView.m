//
//  QYDetailInformationTableView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYDetailInformationTableView.h"
#import "QYDetailInformationTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface QYDetailInformationTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation QYDetailInformationTableView

- (instancetype)initWithFrame:(CGRect)frame data:(nullable NSArray *)dataArray{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.dataArray = [NSArray arrayWithArray:dataArray];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[QYDetailInformationTableViewCell class] forCellReuseIdentifier:@"QYDetailInformationTableViewCellID"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"QYDetailInformationTableViewCellID" cacheByIndexPath:indexPath configuration:^(QYDetailInformationTableViewCell *cell) {
        // 配置 cell 的数据源，和 "cellForRow" 干的事一致，比如：
        [cell setData:self.dataArray[indexPath.row]];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYDetailInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QYDetailInformationTableViewCellID" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"开放时间：";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"地址：";
        cell.arrowImgView.hidden = NO;
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"票价：";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"详情：";
    }
    [cell setData:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        //点击这个cell将进入地图
        if (self.cellClickblock) {
            self.cellClickblock();
        }
    }
}
@end
