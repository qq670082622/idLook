//
//  MakeupWayPopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/2.
//  Copyright © 2019年 HYH. All rights reserved.
//  定妆场地popV

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

@interface MakeupWayPopV : UIView

@property(nonatomic,copy)void(^auditionWayChooseWithModel)(OrderStructM *OrderM);   //试镜方式选择回掉
-(void)showWithOrderM:(OrderStructM*)model;

@end

@interface MakeupPopCell : UIView
-(void)reloadUIWithOrderM:(OrderStructM*)model;
@end
