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
#import <MJRefresh.h>

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
    [self tableViewReloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.dataArray = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self deleteUnlikeTravel];
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
    _travelTableView.mj_header = [self getCustomRefreshHeader];
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

#pragma mark ------- 删除取消收藏的旅程
- (void)deleteUnlikeTravel {
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *travelObjects = [QYTravelModel objectsWhere:@"isLike = 0"];
    if (travelObjects.count > 0) {
        [realm transactionWithBlock:^{
            [realm deleteObjects:travelObjects];
        }];
    }
    [self.travelTableView.mj_header endRefreshing];
}

#pragma mark ------- tableview刷新数据
- (void)tableViewReloadData {
    self.dataArray = [self getDataFromDB];
    if (_travelTableView) {
        [_travelTableView reloadDataWithData:self.dataArray];
    }
}

#pragma mark ------- 自定义MJRefreshStateHeader
- (MJRefreshStateHeader *)getCustomRefreshHeader {
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self deleteUnlikeTravel];
        [self tableViewReloadData];
    }];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    return header;
}
@end
