//
//  AuditWayPopV.h
//  IDLook
//
//  Created by Mr Hu on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

@interface AuditWayPopV : UIView
@property(nonatomic,copy)void(^auditionWayChooseWithModel)(OrderStructM *OrderM);   //试镜方式选择回掉
-(void)showWithOrderM:(OrderStructM*)model;
@end


@interface AuditPopCell : UIView
-(void)reloadUIWithOrderM:(OrderStructM*)model;
@end
