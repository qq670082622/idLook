//
//  PriceModel_java.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/12.
//  Copyright © 2019年 HYH. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PriceModel_java : NSObject
@property(nonatomic,assign)NSInteger advertType;
@property(nonatomic,assign)NSInteger days;//选择了几天
@property(nonatomic,assign)NSInteger salePrice;//选择了几天的总价
@property(nonatomic,assign)NSInteger salePrice_vip;//选择了几天的vip总价
@property(nonatomic,assign)NSInteger singlePrice;//单天的价格
@property(nonatomic,assign)NSInteger singlePrice_vip;//单天的vip价格
@end

NS_ASSUME_NONNULL_END
