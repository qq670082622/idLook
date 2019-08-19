//
//  AddPriceVC.h
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"

typedef NS_ENUM(NSInteger,AddPriceType)
{
    AddPriceTypeAdd,    //新增
    AddPriceTypeModify  //修改
};

@interface AddPriceVC : UIViewController
@property(nonatomic,copy)void(^addPriceBlock)(void);
@property(nonatomic,strong)PriceModel *model;
@property(nonatomic,assign)AddPriceType type;

@property(nonatomic,strong)NSArray *existArray;
@property(nonatomic,strong)NSArray *priceArray;//修改报价传过来的原来的报价
@end
