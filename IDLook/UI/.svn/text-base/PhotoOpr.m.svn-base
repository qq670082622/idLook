//
//  PhotoOpr.m
//  miyue
//
//  Created by wsz on 16/5/5.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import "PhotoOpr.h"

@implementation PhotoOpr

+ (PhotoOpr *)shareInstance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (void)loadImageByCacheOnlyWithUrl:(NSString *)url
                          completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    NSURL *URL = [NSURL URLWithString:url];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager cachedImageExistsForURL:URL completion:^(BOOL isInCache) {
        if(isInCache)
        {
            UIImage *image = [[manager imageCache] imageFromMemoryCacheForKey:url];
            if(image)
            {
                completedBlock(image,nil,0,YES,URL);
            }
            else
            {
                completedBlock(nil,nil,0,YES,URL);
            }
        }
        else
        {
            completedBlock(nil,nil,0,YES,URL);
        }
    }];
}

//优先级：cache->disk
- (void)loadImageByCacheAndDiskWithUrl:(NSString *)url
                             completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    NSURL *URL = [NSURL URLWithString:url];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:URL completion:^(BOOL isInCache) {
        if(isInCache)
        {
            UIImage *image = [[manager imageCache] imageFromMemoryCacheForKey:url];
            if(image)
            {
                completedBlock(image,nil,0,YES,URL);
            }
            else
            {
                image = [[manager imageCache] imageFromDiskCacheForKey:url];
                completedBlock(image,nil,0,YES,URL);
            }
        }
        else
        {
             completedBlock(nil,nil,0,YES,URL);
        }
    }];
}

- (void)loadImageByCacheDiskAndNetWithUrl:(NSString *)url
                                  options:(SDWebImageOptions)options
                                 progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    NSURL *URL = [NSURL URLWithString:url];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:URL completion:^(BOOL isInCache) {
        if(isInCache)
        {
            UIImage *image = [[manager imageCache] imageFromMemoryCacheForKey:url];
            if(image)
            {
                completedBlock(image,nil,0,YES,URL);
            }
            else
            {
                image = [[manager imageCache] imageFromDiskCacheForKey:url];
                completedBlock(image,nil,0,YES,URL);
            }
        }
        else
        {
            [manager downloadImageWithURL:URL
                                  options:SDWebImageRetryFailed
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                     progressBlock(receivedSize,expectedSize);
                                 } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                     completedBlock(image,error,cacheType,finished,imageURL);
                                 }];
        }
    }];
}

- (void)loadImageByCacheDiskWithUrl:(NSString *)oriUrl
                 placeHoderImageUrl:(NSString *)plhUrl
                placeHolerCompleted:(SDWebImageCompletionWithFinishedBlock)placeHolerCompletedBlock
                            options:(SDWebImageOptions)options
                          completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    NSURL *URL = [NSURL URLWithString:oriUrl];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:URL completion:^(BOOL isInCache) {
        if(isInCache)
        {
            UIImage *image = [[manager imageCache] imageFromMemoryCacheForKey:oriUrl];
            if(image)
            {
                completedBlock(image,nil,0,YES,URL);
            }
            else
            {
                image = [[manager imageCache] imageFromDiskCacheForKey:oriUrl];
                completedBlock(image,nil,0,YES,URL);
            }
        }
        else
        {
            //at first load the thumb image cause the origin image is not in ram and disk
            //otherwise,we needn't down load the thumb image from the network
            [self loadImageByCacheAndDiskWithUrl:plhUrl
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                           placeHolerCompletedBlock(image,error,cacheType,finished,imageURL);
                                       }];
        }
    }];
}


- (void)loadImageByCacheDiskAndNetWithUrl:(NSString *)oriUrl
                       placeHoderImageUrl:(NSString *)plhUrl
                      placeHolerCompleted:(SDWebImageCompletionWithFinishedBlock)placeHolerCompletedBlock
                                  options:(SDWebImageOptions)options
                                 progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    NSURL *URL = [NSURL URLWithString:oriUrl];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:URL completion:^(BOOL isInCache) {
        if(isInCache)
        {
            UIImage *image = [[manager imageCache] imageFromMemoryCacheForKey:oriUrl];
            if(image)
            {
                completedBlock(image,nil,0,YES,URL);
            }
            else
            {
                image = [[manager imageCache] imageFromDiskCacheForKey:oriUrl];
                completedBlock(image,nil,0,YES,URL);
            }
        }
        else
        {
            //at first load the thumb image cause the origin image is not in ram and disk
            //otherwise,we needn't down load the thumb image from the network
            [self loadImageByCacheAndDiskWithUrl:plhUrl
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                           placeHolerCompletedBlock(image,error,cacheType,finished,imageURL);
                                       }];
            [manager downloadImageWithURL:URL
                                  options:SDWebImageRetryFailed
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                     progressBlock(receivedSize,expectedSize);
                                 } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                     completedBlock(image,error,cacheType,finished,imageURL);
                                 }];
        }
    }];
}

@end
