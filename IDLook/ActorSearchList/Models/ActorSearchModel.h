//
//  ActorSearchModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/9/17.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActorSearchModel : NSObject


@property(nonatomic,copy)NSString *nikeName;
@property(nonatomic,assign)BOOL expert;//是否带货达人
@property(nonatomic,copy)NSString *academy;//学校
@property(nonatomic,copy)NSString *headPorUrl;
@property(nonatomic,assign)NSInteger works;//视频数量
@property(nonatomic,copy)NSString *representativeWork;//代表作品
@property(nonatomic,copy)NSString *comment;//底部标签

@property(nonatomic,assign)NSInteger userId;
@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,assign)BOOL isCollect;
@property(nonatomic,assign)BOOL isPraise;
@end

NS_ASSUME_NONNULL_END
