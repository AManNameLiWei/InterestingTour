//
//  QYHomeViewController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYCycleScrollView.h"

@interface QYHomeViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation QYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self setupUI];
}

- (void)setupUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, kScreenWidth, kScreenHeight - kTabbarHeight - kStatusBarHeight - kNavigationBarHeight)];
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.width.equalTo(self.view);
        make.height.offset(kScreenHeight - kTabbarHeight - kStatusBarHeight - kNavigationBarHeight);
    }];
    //解决安全区域问题
    adjustsScrollViewInsets_NO(_scrollView, self);
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = UIColor.whiteColor;
    [_scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.greaterThanOrEqualTo(@0);
    }];
    
    NSArray *t = @[@"http://img2.imgtn.bdimg.com/it/u=3081418124,510170928&fm=26&gp=0.jpg",
                   @"http://img4.imgtn.bdimg.com/it/u=229901377,2258429337&fm=26&gp=0.jpg", @"http://img0.imgtn.bdimg.com/it/u=2960559358,3401001486&fm=26&gp=0.jpg"];
    QYCycleScrollView *qycycle = [[QYCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) dataSource:t];
    [_contentView addSubview:qycycle];
}

@end
