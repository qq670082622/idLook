//
//  DownLoadmanager.h
//  IDLook
//
//  Created by HYH on 2018/8/2.
//  Copyright © 2018年 HYH. All rights reserved.
//   下载类

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,DownloadType)
{
    DownloadTypePhoto,   //下载图片
    DownloadTypeVideo   //下载视频
};

@interface DownLoadmanager : NSObject


/**
 下载图片/视频
 @param url 图片/视频url
 @param type 下载的类型   图片/视频
 */
-(void)downloadWithUrl:(NSString*)url withType:(DownloadType)type;


/**
 根据url获取image
 @param url url地址
 @return image
 */
+(UIImage*)getImageWithUrl:(NSString*)url;

@end
