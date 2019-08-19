//
//  MakeupTypePopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/5/29.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakeupTypePopV : UIView
@property(nonatomic,copy)void(^auditionWayChooseWithModel)(OrderStructM *OrderM);   //试镜方式选择回掉
-(void)showWithOrderM:(OrderStructM*)model;
@end

@interface MakeupTypePopCell : UIView
-(void)reloadUIWithOrderM:(OrderStructM*)model;
@end
NS_ASSUME_NONNULL_END
