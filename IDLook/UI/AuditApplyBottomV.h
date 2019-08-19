//
//  AuditApplyBottomV.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuditApplyBottomV : UIView
@property(nonatomic,copy)void(^placeOrderBlock)(void);   //下单

/**
 根据价格加载底部视图
 @param total 总价
 */
-(void)reloadUIWithTotalPrice:(NSInteger)total;
@end

NS_ASSUME_NONNULL_END
