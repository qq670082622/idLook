//
//  CollectionModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/1.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionModel : NSObject
@property(nonatomic,copy)NSString *headMini;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,assign)NSInteger userId;
@end

NS_ASSUME_NONNULL_END
