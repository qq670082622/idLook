//
//  LookPricePopV2Cell.h
//  IDLook
//
//  Created by 吴铭 on 2018/12/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"
#import "PlaceOrderModel.h"
NS_ASSUME_NONNULL_BEGIN
//专门的试镜
@interface LookPricePopV2Cell : UITableViewCell
@property(nonatomic,copy)void(^LookPricePopCellBlock)(void);   //试镜方式选择回掉;

-(void)reloadUIWithModel:(OrderStructM *)model;

@end

NS_ASSUME_NONNULL_END
