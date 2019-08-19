//
//  LookBigImageVC.m
//  IDLook
//
//  Created by HYH on 2018/6/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "LookBigImageVC.h"
#import "LookImageCell.h"
#import "DownLoadmanager.h"


@interface LookBigImageVC ()<UIScrollViewDelegate>
{
    BOOL extraVStatus;
}

@property (nonatomic,strong)NSArray   *dataSource;        //图片组
@property (nonatomic,assign)NSInteger    curIndex;        //当前选中index
@property (nonatomic,assign)CGRect        absRect;

@property (nonatomic,strong)UIView        *bgView;        //黑色背景
@property (nonatomic,strong)UIScrollView *scrollV;

@property (nonatomic,strong)UIButton     *leftBtn;
@property (nonatomic,strong)UILabel      *titileV;
@property (nonatomic,strong)UIButton *downBtn;  //下载按钮
@end

@implementation LookBigImageVC

- (void)showWithImageArray:(NSArray *)array
               curImgIndex:(NSInteger)index
                   AbsRect:(CGRect)rect
{
    
    self.titileV = [CustomNavVC setWhiteNavgationItemTitle:[NSString stringWithFormat:@"%d/%d",(int)index+1,(int)array.count]];
    
    self.dataSource = array;
    self.curIndex = index;
    self.absRect = rect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitleView:self.titileV];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.leftBtn]];
    
    [self.scrollV setContentOffset:CGPointMake(self.curIndex*UI_SCREEN_WIDTH, 0)];
    
    [self downBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:.3 animations:^{
        UIImage *image = [UIImage imageNamed:@"nav_black_bg"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"tabbar_empty"]];
        self.bgView.alpha = 1.0;
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:.3 animations:^{
        UIImage *image = [UIImage imageNamed:@"top_pressed"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"tabbar_empty"]];
    }];
}

- (UIButton *)leftBtn
{
    if(!_leftBtn)
    {
        _leftBtn = [CustomNavVC getLeftDefaultWhiteButtonWithTarget:self
                                                         action:@selector(onGoback)];
    }
    return _leftBtn;
}

-(UIButton*)downBtn
{
    if (!_downBtn) {
        _downBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_downBtn];
        [_downBtn setBackgroundImage:[UIImage imageNamed:@"down_normal"] forState:UIControlStateNormal];
        [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).offset(-20);
            make.right.mas_equalTo(self.view).offset(-20);
        }];
        [_downBtn addTarget:self action:@selector(downAction) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.isShowDown==YES) {
            _downBtn.hidden=NO;
        }
        else
        {
            _downBtn.hidden=YES;
        }
    }
    return  _downBtn;
}


- (UIView *)bgView
{
    if(!_bgView)
    {
        _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.0;
        [self.view insertSubview:_bgView atIndex:0];
    }
    return _bgView;
}

- (UIScrollView *)scrollV
{
    if(!_scrollV)
    {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        _scrollV.pagingEnabled = YES;
        _scrollV.delegate = self;
        _scrollV.bounces=NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.contentSize = CGSizeMake(UI_SCREEN_WIDTH*self.dataSource.count, 0);
        [self.view addSubview:_scrollV];
        _scrollV.backgroundColor=[UIColor clearColor];
        
        [self loadPhotoCell];
    }
    return _scrollV;
}

//下载图片
-(void)downAction
{
    DownLoadmanager *manager = [[DownLoadmanager alloc]init];
    [manager downloadWithUrl:self.dataSource[self.curIndex] withType:DownloadTypePhoto];
    if (self.downPhotoBlock) {
        self.downPhotoBlock(self.curIndex);
    }
}


#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float curPage = (scrollView.contentOffset.x)/UI_SCREEN_WIDTH;
    self.curIndex=(int)round(curPage);
    self.titileV.text = [NSString stringWithFormat:@"%d/%d",(int)round(curPage)+1,(int)self.dataSource.count];
    
    id objNext = [_scrollV viewWithTag:0x86+curPage+1];
    if([objNext isKindOfClass:[LookImageCell class]])
    {
        [(LookImageCell *)objNext checkHasLoadedOriginPhoto];
    }
    
    id objPre = [_scrollV viewWithTag:0x86+curPage-1];
    if([objPre isKindOfClass:[LookImageCell class]])
    {
        [(LookImageCell *)objPre checkHasLoadedOriginPhoto];
    }
}

#pragma mark -
#pragma mark - others

- (void)extraViewAnimate
{
    //    [[UIApplication sharedApplication] setStatusBarHidden:!extraVStatus withAnimation:UIStatusBarAnimationFade];
    float alpha = !extraVStatus?0.0:1.0;
    [UIView animateWithDuration:.2 animations:^{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        self.leftBtn.alpha = alpha;
        self.titileV.alpha = alpha;
    }];
    
    extraVStatus = !extraVStatus;
}

- (void)extraViewAnimateHide
{
#if 0
    //    [[UIApplication sharedApplication] setStatusBarHidden:!extraVStatus withAnimation:UIStatusBarAnimationFade];
    [UIView animateWithDuration:.2 animations:^{
        self.leftBtn.alpha = 0.f;
        self.titileV.alpha = 0.f;
    }];
    extraVStatus = YES;
#endif
}

- (void)onGoback
{

    if([_scrollV isDecelerating])
    {
        return;
    }
    [_scrollV setContentOffset:CGPointMake(self.curIndex*UI_SCREEN_WIDTH,
                                           -UI_STATUS_BAR_HEIGHT-UI_NAVIGATION_BAR_HEIGHT)];

    [UIView animateWithDuration:.3 animations:^{
        
        self.bgView.alpha = 0.0;
        self.leftBtn.alpha = 0.0;
        self.titileV.alpha = 0.0;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.0];
        
    } completion:^(BOOL finished) {
        //        [self dismissViewControllerAnimated:NO completion:NULL];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)loadPhotoCell
{
    for(int i=0;i<_dataSource.count;i++)
    {
        
        LookImageCell *cell = [[LookImageCell alloc] initWithFrame:(CGRect){i*UI_SCREEN_WIDTH,
            0,
            UI_SCREEN_WIDTH,
            UI_SCREEN_HEIGHT}];
        cell.backgroundColor = [UIColor blackColor];
        cell.tag = 0x86+i;
        [_scrollV addSubview:cell];
        
        if(i==self.curIndex)
        {
            CGRect rect = [self.scrollV convertRect:self.absRect toView:self.scrollV];
            [cell loadUIWithPhotoUrl:_dataSource[i] withRect:rect];
        }
        else
        {
            [cell loadUIWithPhotoUrl:_dataSource[i] withRect:CGRectNull];
        }
        
        __weak __typeof(self)ws = self;
        cell.tapOnece = ^(){
            [ws extraViewAnimate];
        };
        
        cell.tapTwice = ^(){
            [ws extraViewAnimateHide];
        };
    }
}


@end
