//
//  ChatModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/10/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatModel : NSObject
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger state;//发送类型 1=用户 2=客服
@property(nonatomic,assign)NSInteger supportId;//客服id
@property(nonatomic,assign)NSInteger type;//消息类型 1=文字 2=图片
@property(nonatomic,assign)NSInteger userId;
@property(nonatomic,assign)BOOL read;
@end

NS_ASSUME_NONNULL_END
