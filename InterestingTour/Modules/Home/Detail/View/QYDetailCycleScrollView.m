//
//  QYDetailCycleScrollView.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/31.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYDetailCycleScrollView.h"
#import <Masonry.h>

@interface QYDetailCycleScrollView ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, strong) NSArray *imageUrlsArray;
@end

@implementation QYDetailCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)imageUrlsArray{
    if (self = [super initWithFrame:frame]) {
        self.imageUrlsArray = imageUrlsArray;
        self.autoScroll = NO;
        self.showPageControl = NO;
        self.delegate = self;
        self.imageURLStringsGroup = imageUrlsArray;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.pageLabel = [[UILabel alloc] init];
    ViewRadius(_pageLabel, 10);
    _pageLabel.textColor = UIColor.whiteColor;
    _pageLabel.font = [UIFont systemFontOfSize:12];
    _pageLabel.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)self.imageUrlsArray.count];
    _pageLabel.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_pageLabel];
    [_pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.offset(-13);
        make.height.offset(20);
        make.width.offset(45);
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    _pageLabel.text =[NSString stringWithFormat:@"%ld/%lu",(long)(index+1) ,(unsigned long)self.imageUrlsArray.count];
}

@end
