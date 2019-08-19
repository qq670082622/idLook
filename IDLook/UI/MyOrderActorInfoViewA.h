//
//  MyOrderActorInfoViewA.h
//  IDLook
//
//  Created by Mr Hu on 2019/6/5.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectOrderInfoM.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderActorInfoViewA : UIView
@property(nonatomic,copy)void(^btnActionBlock)(NSInteger type);
@property(nonatomic,copy)void(^lookOrderDetialBlock)(void);

-(void)reloadUIWithInfo:(ProjectOrderInfoM*)info;

@end

NS_ASSUME_NONNULL_END
