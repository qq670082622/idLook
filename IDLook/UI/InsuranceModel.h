//
//  InsuranceModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/4/17.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InsuranceModel : NSObject
@property(nonatomic,copy)NSString *effectiveTime; //生效时间
@property(nonatomic,copy)NSString *expireTime; //失效时间
@property(nonatomic,copy)NSString *policyNum; //保单号
@property(nonatomic,assign)NSInteger status; //保单状态 11:已出单；13:保障中；10:承保失败
@property(nonatomic,assign)NSInteger planType;//0  , 1
@property(nonatomic,assign)NSInteger amount;//价格
@property(nonatomic,strong)NSArray *userList;
@end

NS_ASSUME_NONNULL_END
