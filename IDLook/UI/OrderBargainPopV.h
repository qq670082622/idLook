//
//  OrderBargainPopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/6/13.
//  Copyright © 2019 HYH. All rights reserved.
//   议价弹窗

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderBargainPopV : UIView

/**
 议价回掉。type： 1=接受。2:不接受，需填价格
 */
@property(nonatomic,copy)void(^bargainBlock)(NSInteger type,NSInteger price);

-(void)showPopVWithInfo:(ProjectOrderInfoM*)info;

@end

NS_ASSUME_NONNULL_END
