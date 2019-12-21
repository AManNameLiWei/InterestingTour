//
//  ColorMacros.h
//  Mine
//
//  Created by 厉威 on 2019/9/9.
//  Copyright © 2019 厉威. All rights reserved.
//

#ifndef ColorMacros_h
#define ColorMacros_h

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

//文本颜色
#define CTEXT_BLACK_COLOR UIColorFromHex(0xFF293040)
#define CTEXT_RED_COLOR  UIColorFromHex(0xFF5712)
#define CTEXT_GREEN_COLOR UIColorFromHex(0xFF0CAE5D)
#define CTEXT_WHITE_COLOR UIColorFromHex(0xFFFFFFFF)
#define CTEXT_LIGHT_GRAY_COLOR UIColorFromHex(0xFF555F77)
//分割线颜色
#define CLINE_GRAY_COLOR UIColorFromHex(0xD8D8D8)
//背景颜色
#define CBACKGROUND_LIGHT_GRAY_COLOR UIColorFromHex(0xFF5C667B)
#define CBACKGROUND_ORANGE_COLOR UIColorFromHex(0xFFFFD630)

#define CGradientStartColor [UIColor colorWithRed:0.0 green:150/255.0 blue:106/255.0 alpha:0.7]
#define CGradientEndColor [UIColor colorWithRed:0.0 green:150/255.0 blue:106/255.0 alpha:1]

#endif /* ColorMacros_h */
