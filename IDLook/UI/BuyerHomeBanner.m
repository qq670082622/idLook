//
//  BuyerHomeBanner.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "BuyerHomeBanner.h"
#import "UIImage+GIF.h"
#import "FLAnimatedImage.h"
#import "HQFlowView.h"
#import "BuyerTipsView.h"

@interface BuyerHomeBanner()<HQFlowViewDelegate,HQFlowViewDataSource>
@property (nonatomic, strong) HQFlowView *pageFlowView;
@property(nonatomic,strong)BuyerTipsView *tipView;
@property(nonatomic,strong)NSMutableArray *images;//[@"url...",gif,@"url..",gif,..]
@end
@implementation BuyerHomeBanner

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ){
        
    }
    return self;
}
-(void)createBanner
{
    [self addSubview:self.pageFlowView];
    [self sendSubviewToBack:_pageFlowView];
    _images = [NSMutableArray new];
    [self.pageFlowView reloadData];//刷新轮播
   
}
-(void)createTipView
{
    for (UIView *suview in self.subviews) {
        if ([suview isKindOfClass:[BuyerTipsView class]]) {
            [suview removeFromSuperview];
        }
    }
    BuyerTipsView *tipView = [[BuyerTipsView alloc] initWithFrame:CGRectMake(15, 150, UI_SCREEN_WIDTH-30, 142)];
    tipView.frame = CGRectMake(15, 150, UI_SCREEN_WIDTH-30,142);
    //    searchView.model = _conditionModel;
    tipView.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
    tipView.layer.borderWidth= 1 ;
    tipView.layer.cornerRadius = 10;
    //    searchView.layer.masksToBounds = YES;
    tipView.layer.shadowOffset = CGSizeMake(5,5);
    tipView.layer.shadowOpacity = 0.3;
    tipView.layer.shadowColor = [[UIColor colorWithHexString:@"#090E13"] colorWithAlphaComponent:0.2].CGColor;
    tipView.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
    tipView.layer.borderWidth= 1 ;
    [self addSubview:tipView];
    [self bringSubviewToFront:tipView];
    tipView.data = _tipsData;
    self.tipView = tipView;
    WeakSelf(self);
    tipView.topAction = ^{
        weakself.topAction();
    };
}
#pragma mark JQFlowViewDelegate
- (CGSize)sizeForPageInFlowView:(HQFlowView *)flowView//中间图的大小
{
    //  return CGSizeMake(UI_SCREEN_WIDTH-2*15, self.pageFlowView.height);
    return CGSizeMake(UI_SCREEN_WIDTH, self.pageFlowView.height);
}


- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex
{
    // NSLog(@"点击第%ld%d个广告(long)",subIndex);
    NSDictionary *dic = _bannerData[subIndex];
    self.clickBannerWithDictionary(dic);
}
#pragma mark JQFlowViewDatasource
- (NSInteger)numberOfPagesInFlowView:(HQFlowView *)flowView
{
    return _bannerData.count;
}
- (HQIndexBannerSubview *)flowView:(HQFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    // NSLog(@"index is %ld",index);
    
    __block  HQIndexBannerSubview *bannerView = (HQIndexBannerSubview *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[HQIndexBannerSubview alloc] initWithFrame:CGRectMake(0, 0, self.pageFlowView.frame.size.width, self.pageFlowView.frame.size.height)];
        //  bannerView.layer.cornerRadius = 8;//中间图的圆角
        //   bannerView.layer.masksToBounds = YES;
        bannerView.coverView.backgroundColor = [UIColor darkGrayColor];
    }
    
    NSString *imageUrl;
    NSDictionary *dic = _bannerData[index];
    if ([UserInfoManager getIsJavaService]) {
        imageUrl=dic[@"bannerUrl"];
    }
    else
    {
        imageUrl=dic[@"bannerurl"];
    }
    NSURL *url = [NSURL URLWithString:imageUrl];
    BOOL isGif = [imageUrl containsString:@"gif"];
    if (isGif) {
        [bannerView.mainImageView setImage:[UIImage imageNamed:@"default_home"]];
        [self loadAnimatedImageWithURLStr:imageUrl completion:^(FLAnimatedImage *animatedImage) {
            bannerView.mainImageView.animatedImage = animatedImage;
        }];
    }else{
        [bannerView.mainImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_home"]];
    }
    bannerView.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    return bannerView;
}
- (void)loadAnimatedImageWithURLStr:(NSString *const)urlStr completion:(void (^)(FLAnimatedImage *animatedImage))completion
{
    NSURL * __block url = [NSURL URLWithString:urlStr];
    NSData * __block animatedImageData;
    FLAnimatedImage * __block gifImg;
    for (int i=0;i<_images.count;i++) {
        id obj = _images[i];
        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:urlStr]) {
            gifImg = [_images objectAtIndex:i+1];
        }
    }
    
    
    if (gifImg) {
        if (completion) {
            completion(gifImg);
        }
    } else {
        WeakSelf(self);
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImageData = data;
            gifImg = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
            if (gifImg) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(gifImg);
                    });
                }
                [weakself.images addObject:url.absoluteString];//这里的逻辑是用数组装图片，图片的上一个下标刚好是这个图片的key，方便查找当前数组有没有这个图片而已
                [weakself.images addObject:gifImg];
            }
        }] resume];
    }
}
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(HQFlowView *)flowView
{
    //    [self.pageFlowView.pageControl setCurrentPage:pageNumber];
    
}

-(void)setTipsData:(NSArray *)tipsData
{
    _tipsData = tipsData;
    [self createTipView];
    
}
-(void)setBannerData:(NSArray *)bannerData
{
    _bannerData = bannerData;
    [self createBanner];
}
- (HQFlowView *)pageFlowView
{
    if (!_pageFlowView) {
        CGFloat flowHeight = UI_SCREEN_WIDTH*0.6;
        _pageFlowView = [[HQFlowView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, flowHeight)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0.3;
        _pageFlowView.leftRightMargin = 16;//大图至屏幕边的宽
        _pageFlowView.topBottomMargin = 0;//左右长条距离顶底的距离
        _pageFlowView.orginPageCount = _bannerData.count;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.autoTime = 5.0;
        _pageFlowView.orientation = HQFlowViewOrientationHorizontal;
        
    }
    return _pageFlowView;
}

- (void)dealloc
{
    self.pageFlowView.delegate = nil;
    self.pageFlowView.dataSource = nil;
    [self.pageFlowView stopTimer];
}

@end
