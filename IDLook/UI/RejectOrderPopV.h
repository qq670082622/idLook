//
//  RejectOrderPopV.h
//  IDLook
//
//  Created by HYH on 2018/7/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface RejectOrderPopV : UIView
@property(nonatomic,copy)void(^rejectWithReason)(NSString *reason);
-(void)showWithOrderType:(OrderType)type;
@end

@interface RejectSelectV : UIView

@property(nonatomic,assign)BOOL isSelect;
-(void)reloadUIWithTitle:(NSString*)title;

@end
