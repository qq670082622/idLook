//
//  BuyerConditionModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyerConditionModel : NSObject

@property(nonatomic,assign) NSInteger age_min;
@property(nonatomic,assign) NSInteger age_max;
@property(nonatomic,assign) NSInteger wei_min;
@property(nonatomic,assign) NSInteger wei_max;
@property(nonatomic,assign) NSInteger hei_min;
@property(nonatomic,assign) NSInteger hei_max;
@property(nonatomic,assign) NSInteger sex;
@property(nonatomic,assign) BOOL tagOpen;
@property(nonatomic,assign) BOOL platOpen;
@property(nonatomic,assign) BOOL regionOpen;
@property(nonatomic,strong)NSMutableArray *regions;
@property(nonatomic,strong)NSMutableArray *tags;
@property(nonatomic,strong)NSMutableArray *platTypes;
@end

NS_ASSUME_NONNULL_END
