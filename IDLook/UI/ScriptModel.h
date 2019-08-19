//
//  ScriptModel.h
//  IDLook
//
//  Created by Mr Hu on 2019/1/22.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScriptModel : NSObject

/**
 id
 */
@property(nonatomic,assign)NSInteger id;

/**
 视频url
 */
@property(nonatomic,copy)NSString *videourl ;

/**
 视频第一帧图片
 */
@property(nonatomic,copy)NSString *cuturl;

/**
 视频时长
 */
@property(nonatomic,assign)CGFloat duration;

/**
 图片url
 */
@property(nonatomic,copy)NSString *imageurl;

/**
 类型  1:视频。2:图片
 */
@property(nonatomic,assign)NSInteger type;

@end

