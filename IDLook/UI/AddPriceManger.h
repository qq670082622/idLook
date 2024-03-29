//
//  AddPriceManger.h
//  IDLook
//
//  Created by HYH on 2018/7/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddPriceModel.h"

@interface AddPriceManger : NSObject

@property (nonatomic,copy)void(^newDataNeedRefreshed)(void);

@property (nonatomic,strong)NSMutableArray *ds;

@property (nonatomic,strong)NSMutableArray *titleArray;

/**
 输入报价得到数据
 @param price 价格
 */
- (void)refreshPriceInfoWithSinglePrice:(NSInteger)price andAdverType:(NSInteger)tyep;//1视频2平面4套拍

/**
 修改天数的报价
 @param tag 天数tag
  @param price 价格
 */
-(void)changePriceWithTag:(NSInteger)tag withPrice:(CGFloat)price;


/**
 修改报价时拍摄天数不同报价
 @param array 报价组
 */
-(void)changeShotDayPriceWithArray:(NSArray*)array;
-(void)changeShotDayPriceWithPriceList:(NSArray *)array;
@end
