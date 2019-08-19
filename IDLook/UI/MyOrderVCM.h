//
//  MyOrderVCM.h
//  IDLook
//
//  Created by HYH on 2018/5/22.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

extern NSString * const kMyOrderVCMCellClass;    //cell类名_键
extern NSString * const kMyOrderVCMCellHeight;   //cell高度_键
extern NSString * const kMyOrderVCMCellType;     //cell类型_键
extern NSString * const kMyOrderVCMCellData;     //cell数据_键



@interface MyOrderVCM : NSObject

@property (nonatomic,strong)NSMutableArray *ds;


/**
   获取订单列表
 @param state 订单状态 0:全部 1：待确认, 2：进行中, 3：已完成, 4：已失效
 @param callBack 获取数据成功的回掉
 */
- (void)refreshOrderListWithState:(NSInteger)state CallBack:(void(^)(BOOL success))callBack;

@end
