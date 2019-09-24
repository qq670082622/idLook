//
//  UinfoSubVA.h
//  IDLook
//
//  Created by Mr Hu on 2019/3/6.
//  Copyright © 2019年 HYH. All rights reserved.
//  个人主页子视图 topV里分数到简介这一块

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UinfoSubVA : UIView

@property(nonatomic,copy)void(^lookMoreinfo)(void);  //查看更多信息
@property(nonatomic,copy)void(^chooseOffer)(void);  //选择报价
@property(nonatomic,copy)void(^vipApplyfor)(void);  //vip申请

//刷新ui
-(void)reloadUIWithInfo:(UserDetialInfoM*)info;

//刷新价格ui
-(void)reloadPriceUIWithDic:(NSDictionary*)dic withDay:(NSInteger)day;

@end

NS_ASSUME_NONNULL_END
