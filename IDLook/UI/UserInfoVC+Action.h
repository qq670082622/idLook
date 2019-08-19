//
//  UserInfoVC+Action.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/15.
//  Copyright © 2019 HYH. All rights reserved.
//   个人主页一些事件的处理分类

#import "UserInfoVC.h"
#import "UserWorkModel.h"

@interface UserInfoVC (Action)

//更多
-(void)moreAction;

//视频浏览量埋点统计
-(void)VideostatisticsWithWorkModel:(UserWorkModel*)model withType:(NSInteger)type;

//---未登录，先去登录
-(void)goLogin;

// --未认证，先去认证
-(void)goAuth;



@end

