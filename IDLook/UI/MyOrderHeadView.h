//
//  MyOrderHeadView.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderProjectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderHeadView : UIView
/**
 选中订单
 */
@property(nonatomic,copy)void(^HeadclickOrderBlock)(BOOL select);

-(void)reloadUIWithModel:(OrderProjectModel*)model;
@end

NS_ASSUME_NONNULL_END
