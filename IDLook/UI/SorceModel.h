//
//  SoreModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SorceModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *datetime;
@property(nonatomic,copy)NSString *status;//增减
@property(nonatomic,assign)NSInteger point;//积分数量

@end

NS_ASSUME_NONNULL_END
