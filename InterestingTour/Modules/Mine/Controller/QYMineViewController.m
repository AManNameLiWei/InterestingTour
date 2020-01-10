//
//  QYMineViewController.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/19.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYMineViewController.h"
#import "QYMineNavigationBarView.h"

@interface QYMineViewController ()

@end

@implementation QYMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.title = @"我的";
    [self setupNavigationBar];
    [self initViews];
}

- (void)setupNavigationBar {
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    QYMineNavigationBarView *navigationBarView = [[QYMineNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight+kNavigationBarHeight)];
    [self.view addSubview:navigationBarView];
    [navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@(kStatusBarHeight+kNavigationBarHeight));
    }];
}

- (void)initViews {
    
}

@end
