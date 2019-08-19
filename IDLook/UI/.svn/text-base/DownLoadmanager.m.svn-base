//
//  DownLoadmanager.m
//  IDLook
//
//  Created by HYH on 2018/8/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "DownLoadmanager.h"

@interface DownLoadmanager ()

@end

@implementation DownLoadmanager


-(void)downloadWithUrl:(NSString *)url withType:(DownloadType)type
{
    if (type==DownloadTypePhoto)
    {
        [self downPhotoWithUrl:url];
    }
    else if (type==DownloadTypeVideo)
    {
        [self downloadVideoWithUrl:url];
    }
}


//下载图片
-(void)downPhotoWithUrl:(NSString*)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    UIImage *image = [UIImage imageWithData:data];
    
    UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        [SVProgressHUD showErrorWithStatus:msg];
        
    }else{
        
        msg = @"保存图片成功" ;
        [SVProgressHUD showSuccessWithStatus:msg];
    }
}


//下载视频
- (void)downloadVideoWithUrl:(NSString *)url{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@.mp4", documentsDirectory,[self string2FromDate:[NSDate date]]];
    NSURL *urlNew = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlNew];
    
    NSProgress *kProgress = nil;
    NSURLSessionDownloadTask *task =[manager downloadTaskWithRequest:request
                                                            progress:&kProgress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                                                return [NSURL fileURLWithPath:fullPath];
                                                            }
                                                   completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                                       [self saveVideo:fullPath];
                                                   }];
    [task resume];
    
    [kProgress addObserver:self
                forKeyPath:@"fractionCompleted"
                   options:NSKeyValueObservingOptionNew
                   context:NULL];
    
}

//videoPath为视频下载到本地之后的本地路径
- (void)saveVideo:(NSString *)videoPath{
    
    if (videoPath) {
        NSURL *url = [NSURL URLWithString:videoPath];
        BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([url path]);
        if (compatible)
        {
            //保存相册核心代码
            UISaveVideoAtPathToSavedPhotosAlbum([url path], self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}

#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}

#pragma mark - 拿到进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //拿到进度
    //    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
        NSLog(@"Progress is %f", progress.fractionCompleted);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showProgress:progress.fractionCompleted status:@"下载中"];
            if (progress.fractionCompleted==1.0) {
                [SVProgressHUD showSuccessWithStatus:@"下载成功"];
            }
        });
    }
}

- (NSString *)string2FromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//获取头像
+(UIImage*)getImageWithUrl:(NSString*)url
{
    __block UIImage *resultImage=[[UIImage alloc]init];
    NSURL *URL = [NSURL URLWithString:url];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:URL completion:^(BOOL isInCache) {
        if(isInCache)
        {
            UIImage *image = nil;
            image =[[manager imageCache] imageFromMemoryCacheForKey:URL.absoluteString];
            if(image)
            {
                resultImage=image;
            }
            else
            {
                image = [[manager imageCache] imageFromDiskCacheForKey:URL.absoluteString];
                if(image)
                {
                    resultImage=image;
                }
            }
        }
        else
        {
            [manager downloadImageWithURL: URL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if(image)
                {
                    resultImage=image;
                }
                else
                {
                }
            }];
        }
    }];
    return resultImage;
}


@end
