//
//  MyOrderBottomV.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderBottomV : UIView
@property(nonatomic,copy)void(^OrderBottomPayBlock)(void);  //合并付款

-(void)reloadUIWithPrice:(NSInteger)price;
@end

NS_ASSUME_NONNULL_END
