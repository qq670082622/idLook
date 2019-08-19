//
//  CouponCell.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"

@interface CouponCell : UITableViewCell
@property(nonatomic,copy)void(^getFirstBlock)(void);
-(void)reloadUIWithModel:(CouponModel*)model;
@end


