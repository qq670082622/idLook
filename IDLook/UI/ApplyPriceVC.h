//
//  ApplyPriceVC.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/10.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetialInfoM.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplyPriceVC : UIViewController
@property(nonatomic,strong)UserDetialInfoM *info;
@property(nonatomic,assign)NSInteger actorPrice;
@property(nonatomic,copy)NSString *castingNameStr;
@property(nonatomic,copy)void(^applyPrice)(NSInteger price,NSString *reason);
@property(nonatomic,assign)NSInteger applyedPrice;
@property(nonatomic,copy)NSString *applyReason;
@end

NS_ASSUME_NONNULL_END
