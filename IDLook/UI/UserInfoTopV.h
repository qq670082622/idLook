//
//  UserInfoHeadV.h
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//topV就是table的header，这里包含了头部演员信息（一直到点赞收藏等），它的图片是-y，这样子刚好插在透明的navigationbar后面

#import <UIKit/UIKit.h>

@interface UserInfoTopV : UIView
@property(nonatomic,copy)void(^UserInfoTopVDetialInfo)(void);   //用户详情
@property(nonatomic,copy)void(^UserInfoTopVLookPrice)(void);  //查看报价
@property(nonatomic,copy)void(^UserInfoTopVvipApplyfor)(void);  //vip申请
@property(nonatomic,copy)void(^lookAllEvaluateBlock)(void);  //查看全部评价

-(void)reloadUIWithInfo:(UserDetialInfoM*)info;
- (void)changeImageFrameWithOffY:(CGFloat)offY;

//刷新价格的ui
-(void)reloadTopPriceUIWithDic:(NSDictionary*)dic withDay:(NSInteger)day;

@end

