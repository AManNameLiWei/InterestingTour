//
//  QYHomeLandscapeTableView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/30.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeLandscapeTableView.h"
#import "QYHomeLandscapeTableViewCell.h"

@interface QYHomeLandscapeTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation QYHomeLandscapeTableView

- (instancetype)initWithFrame:(CGRect)frame data:(nonnull NSArray *)dataArray{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.dataArray = [NSArray arrayWithArray:dataArray];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[QYHomeLandscapeTableViewCell class] forCellReuseIdentifier:@"QYHomeLandscapeTableViewCellID"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYHomeLandscapeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QYHomeLandscapeTableViewCellID" forIndexPath:indexPath];
    return cell;
}
@end
