//
//  PlaceAuditionOrderVC.h
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "PlaceOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceAuditionOrderVC : UIViewController
@property(nonatomic,strong)UserInfoM *info;
@property(nonatomic,strong)OrderModel *model;

@property(nonatomic,strong)OrderStructM *sModel;  //试镜方式选择时传入

@end

NS_ASSUME_NONNULL_END
