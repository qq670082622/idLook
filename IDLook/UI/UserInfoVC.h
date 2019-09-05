//
//  UserInfoVC.h
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface UserInfoVC : UIViewController
@property (nonatomic,strong)UserDetialInfoM *info;
@property (nonatomic,strong)UserModel *userModel;
@property(nonatomic,assign)BOOL isCheckPrice;//直接进入查看报价页面
@property(nonatomic,copy)void(^hadCheckUserPrice)(void);
@end
