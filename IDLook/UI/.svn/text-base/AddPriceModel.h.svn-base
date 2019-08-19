//
//  PriceMode.h
//  IDLook
//
//  Created by HYH on 2018/7/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,OfferType)
{
    OfferTypeDays,       //拍摄天数
    OfferTypeCity,      //拍摄城市
    OfferTypeYear,      //肖像年限
    OfferTypeRange     //肖像范围
};

@interface AddPriceModel : NSObject

/**
 标题
 */
@property(nonatomic,copy)NSString *desc;

/**
 利率
 */
@property(nonatomic,assign)double ratio;   //比例

/**
 参数key
 */
@property(nonatomic,copy)NSString *eng;

/**
 价格
 */
@property(nonatomic,assign)NSInteger price;

/**
 是否选中
 */
@property(nonatomic,assign)BOOL isSelect;

-(id)initWithDic:(NSDictionary*)dic;

@end
