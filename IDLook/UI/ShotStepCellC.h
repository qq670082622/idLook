//
//  ShotStepCellC.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShotStepCellC : UITableViewCell
@property(nonatomic,copy)void(^dateSelectWithType)(NSInteger type);


-(void)reloadUIWithModel:(OrderStructM*)model;

@end

NS_ASSUME_NONNULL_END
