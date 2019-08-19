//
//  MyOrderActorInfoViewB.h
//  IDLook
//
//  Created by Mr Hu on 2019/6/5.
//  Copyright © 2019 HYH. All rights reserved.
//资源方订单cell的subview

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderActorInfoViewB : UIView
@property(nonatomic,copy)void(^btnActionBlock)(NSInteger type);
@property(nonatomic,copy)void(^lookOrderDetialBlock)(void);

-(void)reloadUIWithInfo:(ProjectOrderInfoM*)info;
@end

NS_ASSUME_NONNULL_END
