//
//  ScheduleLockBottomV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleLockBottomV : UIView
@property(nonatomic,copy)void(^placeOrderBlock)(void);   //下单
@property(nonatomic,copy)void(^praceDetailBlock)(void);     //价格明细

-(void)reloadWithFirstPrice:(NSInteger)firstPrice withTotal:(NSInteger)total;
@end

NS_ASSUME_NONNULL_END
