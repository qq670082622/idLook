//
//  ShotStepCellF.h
//  IDLook
//
//  Created by Mr Hu on 2018/12/18.
//  Copyright © 2018年 HYH. All rights reserved.
//  拍摄订单，下单类别cell

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShotStepCellF : UITableViewCell
-(void)reloadUIWithModel:(OrderStructM*)model;

@end

NS_ASSUME_NONNULL_END
