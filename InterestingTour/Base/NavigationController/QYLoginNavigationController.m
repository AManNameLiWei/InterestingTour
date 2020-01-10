//
//  QYLoginNavigationController.m
//  InterestingTour
//
//  Created by 厉威 on 2020/1/9.
//  Copyright © 2020 厉威. All rights reserved.
//

#import "QYLoginNavigationController.h"
#import "QYLoginViewController.h"

@interface QYLoginNavigationController ()
@property (nonatomic, strong) QYLoginViewController *loginViewController;
@end

@implementation QYLoginNavigationController

- (instancetype)init {
    _loginViewController = [QYLoginViewController new];
    self = [super initWithRootViewController:_loginViewController];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}
@end
