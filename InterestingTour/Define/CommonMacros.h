//
//  CommonMacros.h
//  InterestingTour
//
//  Created by 厉威 on 2019/12/20.
//  Copyright © 2019 厉威. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

#define kNotificationNameLoginSuccess @"login_success_notification" //登录成功
#define kNotificationLikeBtnClick @"like_btn_click" // 行程界面喜欢按钮点击

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
#define KPostNotificationWithParam(name,obj,userinfo) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:userinfo];
#endif /* CommonMacros_h */
