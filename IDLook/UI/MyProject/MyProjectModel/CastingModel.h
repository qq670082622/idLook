//
//  CastingModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/3.
//  Copyright © 2019年 HYH. All rights reserved.
//单个角色的model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CastingModel : NSObject
@property(nonatomic,copy)NSString *roleName;
@property(nonatomic,assign)NSInteger sex;
@property(nonatomic,assign)NSInteger heightMin;
@property(nonatomic,assign)NSInteger heightMax;
@property(nonatomic,assign)NSInteger ageMin;
@property(nonatomic,assign)NSInteger ageMax;
@property(nonatomic,copy)NSString *typeName;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,assign)NSInteger roleId;
@end

NS_ASSUME_NONNULL_END
