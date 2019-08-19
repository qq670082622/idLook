//
//  LookImageCell.m
//  IDLook
//
//  Created by HYH on 2018/6/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "LookImageCell.h"
#import "PhotoProgressV.h"
#import "PhotoOpr.h"


@interface LookImageCell ()<UIScrollViewDelegate,SDWebImageManagerDelegate>
{
    BOOL hasLoaded;
    BOOL isLoading;
}

@property (nonatomic,copy)NSString *originUrlStr;
@property (nonatomic,copy)NSString *thumbUrlStr;
@property (nonatomic,copy)NSString *fid;
@property (nonatomic,assign)CGRect originRect;

@property (nonatomic,strong)PhotoProgressV *progV;

//默认是屏幕的宽和高
@property (assign, nonatomic) CGFloat imageNormalWidth; // 图片未缩放时宽度
@property (assign, nonatomic) CGFloat imageNormalHeight; // 图片未缩放时高度

@end

@implementation LookImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.minimumZoomScale = 1.f;
        self.maximumZoomScale = 5.0f;
        self.delegate = self;
        self.bounces = YES;
        
        
        UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchOnce)];
        tapOnce.numberOfTapsRequired = 1;
        tapOnce.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapOnce];
        
        UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTwice)];
        tapTwice.numberOfTapsRequired = 2;
        tapTwice.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapTwice];
        
        [tapOnce requireGestureRecognizerToFail:tapTwice];
    }
    return self;
}

- (UIImageView *)imageV
{
    if(!_imageV)
    {
        _imageV = [[UIImageView alloc] init];
        _imageV.userInteractionEnabled=YES;
        _imageV.contentMode =  UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
        [self addSubview:_imageV];
    }
    return _imageV;
}


- (PhotoProgressV *)progV
{
    if(!_progV)
    {
        _progV = [[PhotoProgressV alloc] init];
        _progV.backgroundColor = [UIColor blackColor];
        _progV.layer.cornerRadius = 6.f;
        _progV.layer.masksToBounds = YES;
        [self insertSubview:_progV aboveSubview:self.imageV];
        [_progV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return _progV;
}


- (void)loadUIWithPhotoUrl:(NSString *)imageUrl withRect:(CGRect)rect
{
    
//    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//
//    //原图
//    UIImage *OriginalImage = [UIImage imageWithData:imgData];

    
    self.originUrlStr = imageUrl;
    self.thumbUrlStr = imageUrl;
    
    self.originRect = rect;
    
    
    __block UIImage *OriginalImage = [[UIImage alloc] init];
    //图片下载链接
    NSURL *imageDownloadURL = [NSURL URLWithString:imageUrl];

    //将图片下载在异步线程进行
    //创建异步线程执行队列
    dispatch_queue_t asynchronousQueue = dispatch_queue_create("imageDownloadQueue", NULL);
    //创建异步线程
    dispatch_async(asynchronousQueue, ^{
        //网络下载图片  NSData格式
        NSError *error;
        NSData *imageData = [NSData dataWithContentsOfURL:imageDownloadURL options:NSDataReadingMappedIfSafe error:&error];  //加载原图
        if (imageData) {
            OriginalImage = [UIImage imageWithData:imageData];
        }
        //回到主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            PhotoOpr *operation = [PhotoOpr shareInstance];
            
            //不可见view
            if(CGRectIsEmpty(rect))
            {
                //有小图 加载小图，无小图则不加载
                [operation loadImageByCacheAndDiskWithUrl:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if(image)
                    {
                        self.imageV.image = OriginalImage;
                        self.imageV.frame = [self autoResizeWithImage:OriginalImage];
                    }
                }];
            }
            //当前可见view
            else
            {
                self.imageV.frame = rect;
                [operation loadImageByCacheDiskAndNetWithUrl:imageUrl
                                          placeHoderImageUrl:imageUrl
                                         placeHolerCompleted:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                             if(image)
                                             {
                                                 self.imageV.image = OriginalImage;
                                                 [self doExpandWithImage:OriginalImage];
                                             }
                                         } options:SDWebImageRetryFailed
                                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                        [self.progV setReceive:receivedSize total:expectedSize];
                                                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                        
                                                        if(image)
                                                        {
                                                            hasLoaded = YES;
                                                            self.imageV.image = OriginalImage;
                                                            [self doExpandWithImage:OriginalImage];
                                                        }
                                                    }];
            }
            
        });
    });

    return;
}

-(void)updataImage:(UIImage *)image{
    
    self.imageV.image = image;
    [self doExpandWithImage:image];
}

- (void)checkHasLoadedOriginPhoto
{
    if(isLoading)return;
    if(hasLoaded)return;
    isLoading = YES;
    
    PhotoOpr *operation = [PhotoOpr shareInstance];
    [operation loadImageByCacheDiskAndNetWithUrl:self.originUrlStr
                              placeHoderImageUrl:self.thumbUrlStr
                             placeHolerCompleted:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                 
                                 isLoading = NO;
                                 if(image)
                                 {
                                     self.imageV.image = image;
                                     self.imageV.frame = [self autoResizeWithImage:image];
                                 }
                             } options:SDWebImageRetryFailed
                                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                            [self.progV setReceive:receivedSize total:expectedSize];
                                        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                            
                                            isLoading = NO;
                                            if(image)
                                            {
                                                hasLoaded = YES;
                                                self.imageV.image = image;
                                                self.imageV.frame = [self autoResizeWithImage:image];
                                            }
                                        }];
}

- (void)doExpandWithImage:(UIImage *)image
{
    [UIView animateWithDuration:.5f
                          delay:0.f
         usingSpringWithDamping:.7f
          initialSpringVelocity:.8f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.imageV.frame = [self autoResizeWithImage:image];
                     } completion:^(BOOL finished) {}];
}

- (CGRect)autoResizeWithImage:(UIImage *)image
{
    CGFloat imageWH  = image.size.width/image.size.height;
    CGFloat screenWH = UI_SCREEN_WIDTH/UI_SCREEN_HEIGHT;
    
    if(screenWH>=imageWH)
    {
        CGFloat ht = UI_SCREEN_HEIGHT;
        CGFloat wt = imageWH*ht;
        
        _imageNormalHeight =ht;
        _imageNormalWidth = wt;
        return CGRectMake((UI_SCREEN_WIDTH-wt)/2.0, 0, wt, ht);
    }
    else
    {
        CGFloat wt = UI_SCREEN_WIDTH;
        CGFloat ht = wt/imageWH;
        
        _imageNormalHeight = ht;
        _imageNormalWidth = wt;
        
        return CGRectMake(0, (UI_SCREEN_HEIGHT-ht)/2.0, wt, ht);
    }
}

- (void)revoverToOriginRect
{
    [self setContentOffset:CGPointZero];
    [self setZoomScale:1.f];
    self.imageV.layer.cornerRadius = 6.f;
    self.imageV.layer.masksToBounds = YES;
    [UIView animateWithDuration:.3 animations:^{
        self.imageV.frame = self.originRect;
    }];
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)touchOnce
{
    self.tapOnece();
}

- (void)touchTwice
{
    if(!hasLoaded)return;
    
    self.tapTwice();
    [self setZoomScale:self.zoomScale==1.f?2.0:1.f animated:YES];

}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageV;
}

//缩放中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 延中心点缩放
    CGFloat imageScaleWidth = scrollView.zoomScale * self.imageNormalWidth;
    CGFloat imageScaleHeight = scrollView.zoomScale * self.imageNormalHeight;
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    
    if (imageScaleWidth < self.frame.size.width) {
        imageX = floorf((self.frame.size.width - imageScaleWidth) / 2.0);
    }
    if (imageScaleHeight < self.frame.size.height) {
        imageY = floorf((self.frame.size.height - imageScaleHeight) / 2.0);
    }
    
    self.imageV.frame = CGRectMake(imageX, imageY, imageScaleWidth, imageScaleHeight);


}

@end
