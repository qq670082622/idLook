//
//  ProjectOrderDetialCellA.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//   订单状态

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectOrderDetialCellA : UITableViewCell
-(void)reloadUIWithInfo:(ProjectOrderInfoM*)info;

@end

NS_ASSUME_NONNULL_END
