//
//  UserService.h
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoVCM.h"

@protocol UserServiceDelegate <NSObject>

//滑动
-(void)scrolloffY:(CGFloat)offY;

//查看作品详情
-(void)lookWorkDetialWithIndex:(NSInteger)index;

@end

@interface UserService : NSObject <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)id<UserServiceDelegate>delegate;
@property(nonatomic,strong)UserInfoVCM *dataM;
@property(nonatomic,assign)NSInteger selectIndex;

@end
