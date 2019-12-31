//
//  QYDetailInformationTableView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYDetailInformationTableView.h"
#import "QYDetailInformationTableViewCell.h"

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
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
//    cell setData:<#(nonnull NSString *)#>
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        if (self.cellClickblock) {
            self.cellClickblock();
        }
    }
}
@end
