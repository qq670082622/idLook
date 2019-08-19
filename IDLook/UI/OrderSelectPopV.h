//
//  OrderSelectPopV.h
//  IDLook
//
//  Created by HYH on 2018/6/22.
//  Copyright © 2018年 HYH. All rights reserved.
//  多选弹出视图

#import <UIKit/UIKit.h>

@interface OrderSelectPopV : UIView
@property(nonatomic,copy)void(^typeSelectAction)(NSString *content);


/**
 根据type得到选择的内容
 @param type 类型
 @param select 已选中的内容
 @param title 标题
 */
-(void)showWithType:(OrderCheckType)type withSelect:(NSArray*)select withTitle:(NSString*)title;

@end
