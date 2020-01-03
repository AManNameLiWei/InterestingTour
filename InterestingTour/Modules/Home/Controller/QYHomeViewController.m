//
//  QYHomeViewController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYHomeCycleScrollView.h"
#import "QYHomeLocationModel.h"
#import "QYHomeNavigationBarView.h"
#import "LWNetworkManager.h"
#import "QYHomeSearchView.h"
#import <Toast.h>
#import "QYHomeLandscapeCollectionView.h"
#import "QYLandscapeViewController.h"
#import "QYHomeAttractionsModel.h"
#import <MBProgressHUD.h>
#import <CoreLocation/CoreLocation.h>

@interface QYHomeViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) QYHomeLocationModel *locationModel;
@property (nonatomic, strong) QYHomeNavigationBarView *navigationBarView;
@property (nonatomic, strong) QYHomeAttractionsModel *attractionsModel;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) NSArray *attractionModelsArray;
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
    
//    [[LWNetworkManager sharedManager] sendRequest:^(TFBURLRequest * _Nonnull request) {
//        request.URL = [NSURL URLWithString:@"http://127.0.0.1/download/layoutData.json"];
//    } success:^(TFBURLResponse * _Nonnull response) {
//        DLog(@"-----------%@",response.responseObject);
//        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:response.responseObject options:NSJSONReadingMutableContainers  error:nil];
//    } failure:^(NSError * _Nonnull error) {
//        [self.view makeToast:error.localizedDescription];
//    }];
}

- (void)setupNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    _navigationBarView = [[QYHomeNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight+kNavigationBarHeight)];
    [self.view addSubview:_navigationBarView];
}

- (void)initViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.scrollEnabled = YES;
    _scrollView.backgroundColor = UIColor.whiteColor;
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

    NSArray *t = @[@"http://img2.imgtn.bdimg.com/it/u=3081418124,510170928&fm=26&gp=0.jpg",
                   @"http://img4.imgtn.bdimg.com/it/u=229901377,2258429337&fm=26&gp=0.jpg", @"http://img0.imgtn.bdimg.com/it/u=2960559358,3401001486&fm=26&gp=0.jpg"];
    QYHomeCycleScrollView *qyCycleView = [[QYHomeCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) dataSource:t];
    [_contentView addSubview:qyCycleView];
    [qyCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.width.equalTo(_contentView);
        make.height.equalTo(@200);
    }];
    
    QYHomeSearchView *searchView = [[QYHomeSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    //搜索景点
    [searchView setSearchAttractions:^(NSString *cityName) {
        self.attractionsModel = [QYHomeAttractionsModel new];
        [self.attractionsModel searchAttarctions:cityName success:^(QYHomeAttractionsModel *model) {
            
        } failed:^(NSString *errorStr) {
            [self.view makeToast:errorStr];
        }];
    }];
    [_contentView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qyCycleView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.equalTo(@50);
    }];
    
    //景点瀑布流视图  默认显示重庆
    __weak typeof(self) weakSelf = self;
    QYHomeAttractionsModel *attractionModel = [QYHomeAttractionsModel new];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
    [attractionModel searchAttarctions:@"合肥" success:^(QYHomeAttractionsModel *model) {
        weakSelf.attractionModelsArray = [NSArray arrayWithArray:model.showapi_res_body.pagebean.contentlist];
        [model.showapi_res_body.pagebean.contentlist enumerateObjectsUsingBlock:^(AttractionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj.name hasSuffix:@"站"] && ![obj.name hasSuffix:@"学"]) {
                //只取第一个用作展示
                PicModel *picModel = [PicModel new];;
                picModel = obj.picList.firstObject;
                if (picModel && obj.name) {
                    NSDictionary *dic = @{@"imgUrl": picModel.picUrl, @"description": obj.name};
                    [dataArray addObject:dic];
                }
            }
        }];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        QYHomeLandscapeCollectionView *collectionView = [[QYHomeLandscapeCollectionView alloc] initWithFrame:CGRectZero dataArray:dataArray];
        collectionView.cellClickBlock = ^(NSInteger row) {
            QYLandscapeViewController *landscapeVc = [[QYLandscapeViewController alloc] init:weakSelf.attractionModelsArray[row] currentLocation:weakSelf.currentLocation];
            [self.navigationController pushViewController:landscapeVc animated:YES];
        };
        [self->_contentView addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(searchView.mas_bottom).offset(0);
            make.left.right.offset(0);
            make.height.offset(2000);
            make.bottom.offset(0);
        }];
    } failed:^(NSString *errorStr) {
        [self.view makeToast:@"网络不稳定，请稍后再试"];
    }];
}

#pragma mark ------- 执行定位
- (void)location {
    self.locationModel = [QYHomeLocationModel new];
    [_locationModel startLocation];
    __weak typeof(self) weakSelf = self;
    //定位成功
    self.locationModel.locationSuccess = ^(NSString * _Nullable city, CLLocation *location) {
        if (city && location) {
            [weakSelf.navigationBarView setCurrentCity:city];
            weakSelf.currentLocation = location;
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
        [weakSelf presentViewController:alertVc animated:YES completion:nil];
    };
}

@end
