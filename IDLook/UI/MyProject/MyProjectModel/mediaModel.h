//
//  mediaModel.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/17.
//  Copyright © 2019年 HYH. All rights reserved.
//专门用来处理projectDetail页面的图片视频问题

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSInteger , mediaType)
{
    mediaTypeVideoOld,//编辑带来的老视频
    mediaTypeVideoNew,//现添视频
     mediaTypePhotoOld,//编辑带过来的老图片
    mediaTypePhotoNew,//现添图片
};
NS_ASSUME_NONNULL_BEGIN

@interface mediaModel : NSObject
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSData *data;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)NSString *url;//编辑和查看页面进来的图片或者视频的cutUrl
@property(nonatomic,copy)NSString *videourl;//播放链接
@property(nonatomic,copy)NSString *id;//试镜项目带id
@property(nonatomic,copy)NSString *duration;//视频持续时间
@property(nonatomic,strong)NSDate *PHAssetDate;

@end

NS_ASSUME_NONNULL_END
