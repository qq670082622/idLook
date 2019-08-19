//
//  AssetModel.h
//  IDLook
//
//  Created by HYH on 2018/7/24.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetModel : NSObject


/**
 备注
 */
@property(nonatomic,copy)NSString *remark;


/**
 金额
 */
@property(nonatomic,copy)NSString *transactionMoney;

/**
 交易日期
 */
@property(nonatomic,copy)NSString *tradingDate;

/**
 分类类型  3试镜, 4拍摄, 100提现, 101购买方违约, 102艺人方违约, 200返现
 */
@property(nonatomic,assign)NSInteger tradingOrderType;

/**
 分类名称
 */
@property(nonatomic,copy)NSString *tradingOrderTypeName;

@end
