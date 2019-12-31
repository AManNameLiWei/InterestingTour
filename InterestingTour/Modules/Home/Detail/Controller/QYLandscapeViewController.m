//
//  QYLandscapeViewController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYLandscapeViewController.h"
#import "QYDetailCycleScrollView.h"
#import "QYDetailNavigationBarView.h"
#import "QYDetailInformationTableView.h"
#import "LWJumpToMap.h"

@interface QYLandscapeViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation QYLandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = UIColor.whiteColor;
    [self initViews];
}

- (void)initViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.width.equalTo(self.view);
        make.height.offset(kScreenHeight - kTabbarHeight);
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
    
    QYDetailNavigationBarView *navigationBarView = [[QYDetailNavigationBarView alloc] init];
    [self.view addSubview:navigationBarView];
    [navigationBarView setBackBlock:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.offset(0);
        make.height.equalTo(@(kNavigationBarHeight + kStatusBarHeight));
    }];
    
    NSArray *t = @[@"http://img2.imgtn.bdimg.com/it/u=3081418124,510170928&fm=26&gp=0.jpg",
                   @"http://img4.imgtn.bdimg.com/it/u=229901377,2258429337&fm=26&gp=0.jpg", @"http://img0.imgtn.bdimg.com/it/u=2960559358,3401001486&fm=26&gp=0.jpg"];
    QYDetailCycleScrollView *qyCycleView = [[QYDetailCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) dataSource:t];
    [_contentView addSubview:qyCycleView];
    [qyCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.width.equalTo(_contentView);
        make.height.equalTo(@400);
    }];
    
    QYDetailInformationTableView *informationTableView = [[QYDetailInformationTableView alloc] initWithFrame:CGRectZero data:nil];
    [informationTableView setCellClickblock:^{
        CLLocationCoordinate2D currentLocation;
        currentLocation.latitude = 31.00;
        currentLocation.longitude = 103.05;
        
        CLLocationCoordinate2D endLocation;
        endLocation.latitude = 40.00;
        endLocation.longitude = 116.05;
        [self presentViewController:[LWJumpToMap getInstalledMapAppWithEndLocation:endLocation currentLocation:currentLocation] animated:YES completion:nil];
    }];
    [_contentView addSubview:informationTableView];
    [informationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qyCycleView.mas_bottom).offset(5);
        make.height.equalTo(@320);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    
}

@end
