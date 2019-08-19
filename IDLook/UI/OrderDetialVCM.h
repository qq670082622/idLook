//
//  OrderDetialVCM.h
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
#import "OrderProjectModel.h"

extern NSString * const kOrderDetialVCMCellClass;    //cell类名_键
extern NSString * const kOrderDetialVCMCellHeight;   //cell高度_键
extern NSString * const kOrderDetialVCMCellType;     //cell类型_键
extern NSString * const kOrderDetialVCMCellData;     //cell数据_键


@interface OrderDetialVCM : NSObject

@property(nonatomic,strong)OrderModel *model;

@property (nonatomic,strong)NSMutableArray *ds;
@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);

- (void)refreshOrderInfoWithOrderModel:(OrderModel*)model withProjM:(OrderProjectModel*)models;

@end
