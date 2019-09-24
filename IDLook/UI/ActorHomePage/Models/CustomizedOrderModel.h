//
//  CustomizedOrderModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomizedOrderModel : NSObject
@property(nonatomic,copy)NSString *companyName;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *linkmanName;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *projectName;
@property(nonatomic,copy)NSString *serviceType;
@end

NS_ASSUME_NONNULL_END
