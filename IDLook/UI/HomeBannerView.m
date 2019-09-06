//
//  HomeBannerView.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/5.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "HomeBannerView.h"
#import "UIImage+GIF.h"
#import "FLAnimatedImage.h"
#import "HQFlowView.h"


@interface HomeBannerView()<HQFlowViewDelegate,HQFlowViewDataSource>
@property (nonatomic, strong) HQFlowView *pageFlowView;
@property(nonatomic,strong)HomeSearchView *searchView;
@property(nonatomic,strong)NSMutableArray *images;//[@"url...",gif,@"url..",gif,..]
@end
@implementation HomeBannerView
- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ){
        [self createViews];
    }
    return self;
}

-(void)createViews
{
   [self addSubview:self.pageFlowView];
    _images = [NSMutableArray new];
    [self.pageFlowView reloadData];//刷新轮播
    for (UIView *suview in self.subviews) {
        if ([suview isKindOfClass:[HomeSearchView class]]) {
            [suview removeFromSuperview];
        }
    }
  
//添加搜索大框
    HomeSearchView *searchView = [[HomeSearchView alloc] initWithFrame:CGRectMake(15, _pageFlowView.bottom-_pageFlowView.height*0.3, UI_SCREEN_WIDTH-30, 280)];
    searchView.frame = CGRectMake(15, _pageFlowView.bottom-_pageFlowView.height*0.3, UI_SCREEN_WIDTH-30, 280);
//    searchView.model = _conditionModel;
    searchView.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
    searchView.layer.borderWidth= 1 ;
    searchView.layer.cornerRadius = 10;
//    searchView.layer.masksToBounds = YES;
        searchView.layer.shadowOffset = CGSizeMake(5,5);
        searchView.layer.shadowOpacity = 0.3;
        searchView.layer.shadowColor = [[UIColor colorWithHexString:@"#090E13"] colorWithAlphaComponent:0.2].CGColor;
        searchView.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
        searchView.layer.borderWidth= 1 ;
    [self addSubview:searchView];
    self.searchView = searchView;
    WeakSelf(self);
    searchView.conditionSelectType = ^(conditionType type) {
        [weakself.delegate searchViewInBannerViewWithActionType:type];
    };
}
-(void)reloadSearchViewWithModel:(ConditionModel *)cdModel
{
    [self.searchView loadUIWithModel:cdModel];
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
    NSDictionary *dic = self.dataSource[subIndex];
    self.clickBannerWithDictionary(dic);
}
#pragma mark JQFlowViewDatasource
- (NSInteger)numberOfPagesInFlowView:(HQFlowView *)flowView
{
    return self.dataSource.count;
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
    NSDictionary *dic = self.dataSource[index];
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

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(HQFlowView *)flowView
{
//    [self.pageFlowView.pageControl setCurrentPage:pageNumber];

}

-(void)loginOut
{
    self.blockLoginOut();
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
-(void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
     [self createViews];
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
        _pageFlowView.orginPageCount = _dataSource.count;
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
