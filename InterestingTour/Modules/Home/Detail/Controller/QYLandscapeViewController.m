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
#import "QYHomeAttractionsModel.h"

@interface QYLandscapeViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) AttractionModel *attractionModel;
@property (nonatomic, copy) CLLocation *currentLocation;
@property (nonatomic, strong) NSArray *informationTableViewDataArray;
@end

@implementation QYLandscapeViewController

- (instancetype)init:(AttractionModel *)model currentLocation:(nonnull CLLocation *)location {
    self = [super init];
    if (self) {
        self.attractionModel = model;
        self.currentLocation = location;
        self.informationTableViewDataArray = @[self.attractionModel.opentime ? self.attractionModel.opentime : @"全天开放", self.attractionModel.address, self.attractionModel.price ? self.attractionModel.price : @"暂无票价信息", self.attractionModel.summary];
    }
    return self;
}

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
        make.height.equalTo(@300);
    }];
    
    __weak typeof(self) weakSelf = self;
    QYDetailInformationTableView *informationTableView = [[QYDetailInformationTableView alloc] initWithFrame:CGRectZero data:self.informationTableViewDataArray];    
    [informationTableView setCellClickblock:^{
        CLLocationCoordinate2D currentLocation = weakSelf.currentLocation.coordinate;
        CLLocationCoordinate2D endLocation;
        endLocation.latitude = [self.attractionModel.location.lat floatValue];
        endLocation.longitude = [self.attractionModel.location.lon floatValue];
        [self presentViewController:[LWJumpToMap getInstalledMapAppWithEndLocation:endLocation currentLocation:currentLocation] animated:YES completion:nil];
    }];
    [_contentView addSubview:informationTableView];
    [informationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qyCycleView.mas_bottom).offset(5);
        make.left.right.offset(0);
        make.height.equalTo(@240);
    }];
    //监听tableview的contentSize，由contentSize重新计算tableView高度
    [[RACObserve(informationTableView, contentSize) ignore:nil] subscribeNext:^(id  _Nullable x) {
        CGSize size = [x CGSizeValue];;
        [informationTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(size.height));
        }];
    }];
    
    UIButton *addTravelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addTravelBtn setBackgroundColor:C_BUTTON_COLOR];
    [addTravelBtn setTitle:NSLocalizedString(@"add_to_travel", nil) forState:UIControlStateNormal];
    [addTravelBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    addTravelBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:30];
    ViewRadius(addTravelBtn, 20);
    [_contentView addSubview:addTravelBtn];
    [addTravelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(informationTableView.mas_bottom).offset(5);
        make.centerX.equalTo(_contentView);
        make.height.equalTo(@46);
        make.width.equalTo(@180);
        make.bottom.offset(0);
    }];
}



@end