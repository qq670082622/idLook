//
//  ConditionModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/8/21.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConditionModel : NSObject
@property(nonatomic,assign) NSInteger hei_min;
@property(nonatomic,assign) NSInteger hei_max;
@property(nonatomic,assign) NSInteger wei_min;
@property(nonatomic,assign) NSInteger wei_max;
@property(nonatomic,assign) NSInteger age_min;
@property(nonatomic,assign) NSInteger age_max;
@property(nonatomic,assign) NSInteger price_min;
@property(nonatomic,assign) NSInteger price_max;
@property(nonatomic,assign) NSInteger sex;
@property(nonatomic,copy)NSString *region;
@property(nonatomic,copy)NSString *keyWord;
@property(nonatomic,copy)NSString *shotType;
@end

NS_ASSUME_NONNULL_END
