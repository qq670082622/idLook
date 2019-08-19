//
//  PlaceShotOrderVC.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "PriceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceShotOrderVC : UIViewController
@property(nonatomic,strong)UserInfoM *info;
@property(nonatomic,strong)OrderModel *model;

@property(nonatomic,strong)PriceModel *pModel;  //报价模型,查看报价时下单需传入值
@property(nonatomic,strong)NSDictionary *videoTypeDic;  //报价选中的传人

@end

NS_ASSUME_NONNULL_END
