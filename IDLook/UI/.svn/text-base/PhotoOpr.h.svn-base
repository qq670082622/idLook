//
//  PhotoOpr.h
//  miyue
//
//  Created by wsz on 16/5/5.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoOpr : NSObject

+ (PhotoOpr *)shareInstance;

//优先级：cache
- (void)loadImageByCacheOnlyWithUrl:(NSString *)url
                          completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

//优先级：cache->disk
- (void)loadImageByCacheAndDiskWithUrl:(NSString *)url
                             completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

//优先级：cache->disk->network
- (void)loadImageByCacheDiskAndNetWithUrl:(NSString *)url
                                  options:(SDWebImageOptions)options
                                 progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

//优先级：cache->disk
//placeHolder:自缓存中加载缩略图，不再在网络加载缩略图
- (void)loadImageByCacheDiskWithUrl:(NSString *)oriUrl
                 placeHoderImageUrl:(NSString *)plhUrl
                placeHolerCompleted:(SDWebImageCompletionWithFinishedBlock)placeHolerCompletedBlock
                            options:(SDWebImageOptions)options
                          completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

//优先级：cache->disk->network
//placeHolder:自缓存中加载缩略图，不再在网络加载缩略图
- (void)loadImageByCacheDiskAndNetWithUrl:(NSString *)oriUrl
                       placeHoderImageUrl:(NSString *)plhUrl
                      placeHolerCompleted:(SDWebImageCompletionWithFinishedBlock)placeHolerCompletedBlock
                                  options:(SDWebImageOptions)options
                                 progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

@end
