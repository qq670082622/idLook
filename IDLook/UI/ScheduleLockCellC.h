//
//  ScheduleLockCellC.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//  锁档艺人信息cell

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"
NS_ASSUME_NONNULL_BEGIN

@interface ScheduleLockCellC : UITableViewCell

-(void)reloadUIWithProjectOrderInfo:(ProjectOrderInfoM*)info;

@end

NS_ASSUME_NONNULL_END
