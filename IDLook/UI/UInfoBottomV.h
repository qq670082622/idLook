//
//  UInfoBottomV.h
//  IDLook
//
//  Created by HYH on 2018/5/10.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UInfoBottomV : UIView
@property(nonatomic,copy)void(^phoneActionBlock)(void);  //客服
@property(nonatomic,copy)void(^evaluateActionBlock)(void);  //评价
@property(nonatomic,copy)void(^auditionActionBlock)(void);  //试镜下单
@property(nonatomic,copy)void(^shotActionBlock)(void);  //拍摄下单
@property(nonatomic,copy)void(^askScheduleBlock)(void);  //询问档期

@property(nonatomic,copy)void(^praiseBlock)(void);  //点赞
@property(nonatomic,copy)void(^collectBlock)(void);  //收藏

-(void)reloadUIWithInfo:(UserDetialInfoM*)info;

@end
