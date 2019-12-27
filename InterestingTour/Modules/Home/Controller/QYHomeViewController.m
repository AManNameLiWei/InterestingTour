//
//  QYHomeViewController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYCycleScrollView.h"
#import "QYHomeLocationModel.h"
#import "QYHomeNavigationBarView.h"
#import "LWNetworkManager.h"

@interface QYHomeViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) QYHomeLocationModel *locationModel;
@property (nonatomic, strong) QYHomeNavigationBarView *navigationBarView;
@end

@implementation QYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self initViews];
    [self setupNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //每次进入执行定位
    [self location];
    
    [[LWNetworkManager sharedManager] sendRequest:^(TFBURLRequest * _Nonnull request) {
        request.URL = [NSURL URLWithString:@"http://127.0.0.1/download/TextServer.json"];
    } success:^(TFBURLResponse * _Nonnull response) {
        NSLog(@"************%@",response.responseObject);
        NSData *data = response.responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers  error:nil];
        DLog(@"-----------%@",response);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setupNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    _navigationBarView = [[QYHomeNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight+kNavigationBarHeight)];
    [self.view addSubview:_navigationBarView];
}

- (void)initViews {
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
//    [_contentView addSubview:qycycle];
}

#pragma mark ------- 执行定位
- (void)location {
    self.locationModel = [QYHomeLocationModel new];
    [_locationModel startLocation];
    __weak typeof(self) weakSelf = self;
    //定位成功
    self.locationModel.locationSuccess = ^(NSString * _Nullable city) {
        if (city) {
            [weakSelf.navigationBarView setCurrentCity:city];
        }
    };
    //定位失败
    self.locationModel.locationFailed = ^(NSError * _Nullable error) {
        DLog(@"%@",error);
        [weakSelf.navigationBarView setCurrentCity:@"定位失败"];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *openSettingAction = [UIAlertAction actionWithTitle:@"打开设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:settingUrl]) {
                [[UIApplication sharedApplication] openURL:settingUrl];
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:openSettingAction];
        [alertVc addAction:cancelAction];
//        [weakSelf presentViewController:alertVc animated:YES completion:nil];
    };
}

@end
