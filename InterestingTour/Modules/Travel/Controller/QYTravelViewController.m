//
//  QYTravelViewController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYTravelViewController.h"
#import "QYTravelTableView.h"
#import <Realm/Realm.h>
#import <RLMResults.h>
#import "QYTravelModel.h"

@interface QYTravelViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) QYTravelTableView *travelTableView;
@end

@implementation QYTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"行程";
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reciveNotifications];
    self.view.backgroundColor = UIColor.greenColor;
    self.dataArray = [self getDataFromDB];
    if (_travelTableView) {
        [_travelTableView reloadDataWithData:self.dataArray];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.dataArray = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    RLMRealm *realm = [RLMRealm defaultRealm];
    //界面消失时移除所有不喜欢的行程
    RLMResults *travelObjects = [QYTravelModel objectsWhere:@"isLike = 0"];
    [realm transactionWithBlock:^{
        [realm deleteObjects:travelObjects];
    }];
}

- (void)initViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.scrollEnabled = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.equalTo(self.view).offset(0);
        make.width.equalTo(self.view);
        make.height.offset(kScreenHeight - kTabbarHeight - kStatusBarHeight - kNavigationBarHeight);
    }];
    //解决安全区域问题
    adjustsScrollViewInsets_NO(_scrollView, self);
    
    _contentView = [[UIView alloc] init];
    _contentView.userInteractionEnabled = YES;
    [_scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.greaterThanOrEqualTo(@0.f);
    }];
    
    _travelTableView = [[QYTravelTableView alloc] initWithFrame:CGRectZero data:[self getDataFromDB]];
    [_contentView addSubview:_travelTableView];
    [_travelTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.equalTo(_scrollView);
        make.bottom.offset(0);
    }];
}

#pragma mark ------- 从数据库查询数据
- (NSArray *)getDataFromDB {
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    RLMResults<QYTravelModel *> *travels = [QYTravelModel allObjects];
    for (QYTravelModel *model in travels) {
        NSDictionary *dataDic = @{@"imgUrl": model.picUrl, @"title": model.travelTitle, @"address": model.travelAddress, @"isLike": @(model.isLike)};
        [dataArray addObject:dataDic];
    }
    return dataArray;
}

#pragma mark ------- 接收通知
- (void)reciveNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeBtnClick:) name:kNotificationLikeBtnClick object:nil];
}

#pragma mark ------- 喜欢按钮点击
- (void)likeBtnClick:(NSNotification *)notifi {
    NSString *key = notifi.userInfo[@"title"];
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *travelObject = [QYTravelModel objectsWhere:@"travelTitle = %@",key];
    if (travelObject.count > 0) {
        for (QYTravelModel *model in travelObject) {
            [realm transactionWithBlock:^{
                model.isLike = [notifi.userInfo[@"isLike"] boolValue];
            }];
        }
    }
}

@end
