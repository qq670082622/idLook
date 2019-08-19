//
//  AddPriceSubC.h
//  IDLook
//
//  Created by HYH on 2018/7/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPriceModel.h"

@interface AddPriceSubC : UIView

@property(nonatomic,copy)void(^clickPriceWithTag)(NSInteger tag);

/**
 加载UI
 @param array 数值
 @param type 类型
 @param title 标题
 */
-(void)reloadUIWithArray:(NSArray*)array withType:(OfferType)type withTitle:(NSString*)title;

/**
 刷新数据
 @param array 数值
 @param type 类型
 */
-(void)refreshDataWithArray:(NSArray*)array withType:(OfferType)type;
@property(nonatomic,strong)NSArray *Prices;
@end