/*
 @header  AdvBannerView.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/26
 @description
 
 */

#import "AdvBannerView.h"
#import "UIImage+GIF.h"
#import "FLAnimatedImage.h"

@interface AdvBannerView ()<UIScrollViewDelegate>

@property (weak, nonatomic) UIView *backgroundView;
@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) NSTimer* timer;
@property (nonatomic,strong) NSArray* imageViews;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSArray* datas;
@property (nonatomic,strong) NSTimer *imageTimer;
@end

@implementation AdvBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ){
        [self createViews];
    }
    return self;
}

- (void)initScrollView{
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
}

- (void)createViews{
    UIView *backgroundView = [[UIView alloc] init];
    UIPageControl* pageControl = [[UIPageControl alloc] init];
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    
    [self addSubview:(_backgroundView=backgroundView)];
    [backgroundView addSubview:(_scrollView=scrollView)];
    [backgroundView addSubview:(_pageControl=pageControl)];
    
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = Public_Red_Color;
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(backgroundView);
    }];
    _scrollView.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backgroundView.mas_bottom);
        make.centerX.equalTo(backgroundView);
    }];
    
}

-(void)setImagesWithBannerDatas:(NSArray*)dataS
{

    if (dataS.count==0) {
        return;
    }
    
    self.datas = dataS;
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    if (dataS.count==1) {
        [self initOneImage];
        return;
    }
    
    [self layoutIfNeeded];
    //在数组的首部插入尾部的数据，在尾部插入首部的数据，实现首尾相接
    NSMutableArray* temp = [[NSMutableArray alloc] initWithArray:dataS];
    id firstObject = temp.firstObject;
    id lastObject = temp.lastObject;
    [temp addObject:firstObject];
    [temp insertObject:lastObject atIndex:0];
    self.datas=temp;
    NSMutableArray* imageViews = [NSMutableArray array];
    //获取网络图片，并设置按钮回调block
    for ( NSInteger count = 0 ; count < temp.count ; count++ ){
        NSDictionary *dic = temp[count];
        FLAnimatedImageView* imageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(count*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imageView.tag=1000+count;
        imageView.userInteractionEnabled=YES;
        
        NSString *bannerUrl ;
        if ([UserInfoManager getIsJavaService]) {
            bannerUrl=dic[@"bannerUrl"];
        }
        else
        {
            bannerUrl=dic[@"bannerurl"];
        }

        
        NSURL *url = [NSURL URLWithString:bannerUrl];
        BOOL isGif = [bannerUrl containsString:@"gif"];
        if (isGif) {
            [imageView setImage:[UIImage imageNamed:@"default_home"]];
            [self loadAnimatedImageWithURL:url completion:^(FLAnimatedImage *animatedImage) {
                imageView.animatedImage = animatedImage;
            }];
        }else{
           [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_home"]];
        }
 
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
        [imageView addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _scrollView.contentSize = CGSizeMake((count + 1) * self.frame.size.width, 0);
        
        [imageViews addObject:imageView];
    }
    
    _imageViews = imageViews;
    [self initPageController:dataS.count];
    [self initScrollView];
    [self createTimer];
}

//初始化pagecontroller的个数
- (void)initPageController:(NSInteger)numberOfPages{
    _pageControl.numberOfPages = numberOfPages;
    _pageControl.currentPage = numberOfPages;
    _currentPage = 0;
}

- (void)createTimer{
    if ( !_timer ){
        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:_rollInterval?_rollInterval:MAXFLOAT target:self selector:@selector(rolling) userInfo:nil repeats:YES ];
//        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(rolling) userInfo:nil repeats:YES ];
        [[NSRunLoop currentRunLoop]addTimer:(_timer = timer) forMode:NSRunLoopCommonModes];
    }
}

- (void)rolling{
    //装载
   
    //获取当前的点
    CGPoint point = _scrollView.contentOffset;
    
    //求得将要变换的点
    CGPoint endPoint = CGPointMake(point.x + self.frame.size.width, 0);
    
    //判断
    if ( endPoint.x == (self.imageViews.count-1) * self.frame.size.width ){
        [UIView animateWithDuration:_animateInterval?_animateInterval:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(endPoint.x, 0);
        } completion:^(BOOL finished) {
            //动画完成的block
            self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
            CGPoint realEnd = self.scrollView.contentOffset;
            //取一遍页码数
            self.currentPage = realEnd.x / self.frame.size.width;
            self.pageControl.currentPage = self.currentPage - 1;
        }];
    }else{
        [UIView animateWithDuration:_animateInterval?_animateInterval:0.5 animations:^{
            self.scrollView.contentOffset = endPoint;
        } completion:^(BOOL finished) {
            CGPoint realEnd = self.scrollView.contentOffset;
            //取一遍页码数
            self.currentPage = realEnd.x / self.frame.size.width;
            self.pageControl.currentPage = self.currentPage - 1;
        }];
    }
    
    
    [AFWebAPI_JAVA getIsUserJavaServiceWithCallBack:^(BOOL success, id  _Nonnull object) {//定时检查是否用java后端
        if (success) {
            NSNumber *useJava = object[@"body"][@"EnableJava"];
            BOOL us = [useJava boolValue];
            if (us) {
                [UserInfoManager setIsJavaService:YES];
            }else{
                [UserInfoManager setIsJavaService:NO];
            }
        }
    }];

    UserLoginType type = [UserInfoManager checkWhetherHasLogined];
    
    if (type>=0 && [UserInfoManager getIsJavaService]) {//定时检查该账号有没有被改手机号或者密码
        NSDictionary *dicArg = @{@"userType":@([UserInfoManager getUserType])};
        [AFWebAPI_JAVA checkTokenIsValid:dicArg callBack:^(BOOL success, id object) {
            if (!success) {
                [SVProgressHUD showErrorWithStatus:@"账户手机或密码已被修改"];
                                    [UserInfoManager clearUserLoginfo];
                                   self.loginOut();
            }
           }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ( _timer ){
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_rollInterval?_rollInterval:MAXFLOAT]];
    }
    //图片的个数  1 2 3 4 5 6 7 8
    //真实的页码  0 1 2 3 4 5 6 7
    //显示的页码    0 1 2 3 4 5
    CGPoint point = _scrollView.contentOffset;
    if ( point.x == (self.imageViews.count-1)*self.frame.size.width ){
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    if ( point.x == 0 ){
        scrollView.contentOffset = CGPointMake((self.imageViews.count-2)*self.frame.size.width, 0);
    }
    //取一遍页码数
    CGPoint endPoint = scrollView.contentOffset;
    _currentPage = endPoint.x / self.frame.size.width;
    _pageControl.currentPage = _currentPage - 1;
    
}

//手指开始触摸停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ( _timer ){
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

//1张图片时加载
-(void)initOneImage
{
    //获取网络图片，并设置按钮回调block
    for ( NSInteger count = 0 ; count < self.datas.count ; count++ ){
        NSDictionary *dic = self.datas[count];
        FLAnimatedImageView* imageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(count*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imageView.tag=1000;
        imageView.userInteractionEnabled=YES;
        
        NSString *bannerUrl ;
        if ([UserInfoManager getIsJavaService]) {
            bannerUrl=dic[@"bannerUrl"];
        }
        else
        {
            bannerUrl=dic[@"bannerurl"];
        }
        
        NSURL *url = [NSURL URLWithString:bannerUrl];
        BOOL isGif = [bannerUrl containsString:@"gif"];
        if (isGif) {
            [self loadAnimatedImageWithURL:url completion:^(FLAnimatedImage *animatedImage) {
                imageView.animatedImage = animatedImage;
            }];
        }else{
            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_home"]];
        }
        
        [_scrollView addSubview:imageView];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
        [imageView addGestureRecognizer:tap];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    _scrollView.contentSize = CGSizeMake((_datas.count) * self.frame.size.width, 0);

}

-(void)clickAction:(UITapGestureRecognizer*)tap
{
    NSDictionary *dic = self.datas[tap.view.tag-1000];
    if (self.clickBannerWithDictionary) {
        self.clickBannerWithDictionary(dic);
    }
}

- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(FLAnimatedImage *animatedImage))completion
{
    NSString *const filename = url.lastPathComponent;
    NSString *const diskPath = [NSHomeDirectory() stringByAppendingPathComponent:filename];
    
    NSData * __block animatedImageData = [[NSFileManager defaultManager] contentsAtPath:diskPath];
    FLAnimatedImage * __block animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
    
    if (animatedImage) {
        if (completion) {
            completion(animatedImage);
        }
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImageData = data;
            animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
            if (animatedImage) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(animatedImage);
                    });
                }
                [data writeToFile:diskPath atomically:YES];
            }
        }] resume];
    }
}

@end
