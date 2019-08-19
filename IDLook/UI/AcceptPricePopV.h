//
//  AcceptPricePopV.h
//  IDLook
//
//  Created by Mr Hu on 2019/5/30.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AcceptPricePopV : UIView
@property(nonatomic,copy)void(^AcceptPricePopVBlock)(NSInteger type);  //接受，拒绝报价

/**
 显示弹窗
 @param buyprice 买家报价
 @param actorprice 演员还价
 */
- (void)showWithBuyPrice:(NSInteger)buyprice withActorPrice:(NSInteger)actorprice;
@end

NS_ASSUME_NONNULL_END
