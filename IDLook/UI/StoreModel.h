//
//  StoreModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreModel : NSObject
@property(nonatomic,assign)NSInteger point;
@property(nonatomic,copy)NSString *itemName;
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,assign)NSInteger itemId;//1jd 2oil
@property(nonatomic,copy)NSString *picture;

@end

NS_ASSUME_NONNULL_END
