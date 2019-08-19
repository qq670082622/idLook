//
//  CityModel.h
//  IDLook
//
//  Created by HYH on 2018/7/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

/**
 城市名称
 */
@property(nonatomic,copy)NSString *city;

/**
 是否有下一级
 */
@property(nonatomic,assign)BOOL isShowArrow;

/**
 是否选中
 */
@property(nonatomic,assign)BOOL isSelect;

/**
 每条数据的所有内容
 */
@property(nonatomic,strong)NSDictionary *object;

@end
