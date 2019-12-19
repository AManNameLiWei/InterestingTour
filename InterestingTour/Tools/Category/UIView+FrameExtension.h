//
//  UIView+FrameExtension.h
//  毛玻璃效果
//
//  Created by 厉威 on 2019/3/8.
//  Copyright © 2019 彭孝东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FrameExtension)
//坐标
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
//右间距
@property(nonatomic,assign,readonly)CGFloat trailing;
//底部间距
@property(nonatomic,assign,readonly)CGFloat bottom;
@end

NS_ASSUME_NONNULL_END
