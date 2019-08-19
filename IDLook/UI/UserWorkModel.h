//
//  UserWorkModel.h
//  IDLook
//
//  Created by Mr Hu on 2019/3/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserWorkModel : NSObject

/**
 标题
 */
@property(nonatomic,copy)NSString *title;

/**
 视频url
 */
@property(nonatomic,copy)NSString *url;

/**
 第一帧图片
 */
@property(nonatomic,copy)NSString *coverUrl;

/**
 下载次数
 */
@property(nonatomic,assign)NSInteger downloads;

/**
 标签类型
 */
@property(nonatomic,copy)NSString *tag;

/**
 作品id
 */
@property(nonatomic,assign)NSInteger id;

/**
 观看次数
 */
@property(nonatomic,assign)NSInteger plays;

/**
 视频时长
 */
@property(nonatomic,assign)int videoTime;

/**
 类型 1试戏 2过往 3模特卡  4自我介绍
 */
@property(nonatomic,assign)NSInteger vtype;

@end

NS_ASSUME_NONNULL_END
