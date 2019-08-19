//
//  ShotStepCellA.h
//  IDLook
//
//  Created by HYH on 2018/7/20.
//  Copyright © 2018年 HYH. All rights reserved.
//   档期预约金cell

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

@interface ShotStepCellA : UITableViewCell
@property(nonatomic,copy)void(^ShotStepCellABlock)(void);

-(void)reloadUIWithModel:(OrderStructM*)model;

@end
