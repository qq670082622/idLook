//
//  OrderPickerPopV.h
//  IDLook
//
//  Created by HYH on 2018/6/22.
//  Copyright © 2018年 HYH. All rights reserved.
//  单选时弹出视图

#import <UIKit/UIKit.h>

@interface OrderPickerPopV : UIView
@property (nonatomic,copy)void(^didSelectBlock)(NSString *select,NSInteger type);
@property (nonatomic,strong)NSString *title;
-(void)showWithPickerType:(OrderCheckType)type withDesc:(NSString*)string;
@end
