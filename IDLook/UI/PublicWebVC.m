//
//  PublicWebVC.m
//  IDLook
//
//  Created by HYH on 2018/7/31.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PublicWebVC.h"
#import "CouponVC.h"
#import "SharePopV.h"
#import "ShareManager.h"
@interface PublicWebVC ()<UIWebViewDelegate>
{
    int _LinkCount;
    UIWebView * _webView;
}
@property (nonatomic,retain) NSString * navTitle;
@property (nonatomic,retain) NSString * url;
@end

@implementation PublicWebVC

- (id)initWithTitle:(NSString *)title
                url:(NSString *)url
{
    self = [super init];
    if(self)
    {
        self.navTitle=title;
        self.url=url;
        self.hideNavBar=NO;
        _LinkCount=0;
        
        [self processLinkUrl];
    }
    return self;
}

- (void)processLinkUrl
{
    if([self.url rangeOfString:@"user_protocol"].length)
    {
        return;
    }
    
    NSString *lowUrl = [self.url lowercaseString];
    
    NSRange range = [lowUrl rangeOfString:@"http://"];
    if(range.length<7)
    {
        self.url = [NSString stringWithFormat:@"http://%@",self.url];
    }
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSString *str=[url absoluteString];
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        
        NSString *tag=[str substringToIndex:7];
        
        if ([tag isEqualToString:@"userid:"])
        {
            
            return NO;
        }
        _LinkCount++;
    }
    
    if ([str isEqualToString:@"sdk://double?value=10"]) {  //跳转到优惠券
        [self toCouponVC];
    }
    
    return TRUE;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:self.navTitle]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoBack)]]];
 //   if ([self.url containsString:@"return"]) {
        UIButton *shareBtn = [self getRightBarButtonItem2WithTarget:self action:@selector(shareReturnCash) normalImg:@"notice_nav_share_icon" hilightImg:@"notice_nav_share_icon"];
        shareBtn.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
        UIButton *closeBtn = [self getRightBarButtonItem2WithTarget:self action:@selector(onFinish) normalImg:@"icon_close" hilightImg:@"icon_close"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 81, 44)];
        shareBtn.frame = CGRectMake(0, 6, 33, 33);
        closeBtn.frame = CGRectMake(48, 6, 33, 33);
        [view addSubview:shareBtn];
        [view addSubview:closeBtn];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:view]];
//    }else{
//    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightBarButtonItem2WithTarget:self action:@selector(onFinish) normalImg:@"icon_close" hilightImg:@"icon_close"]]];
//    }
    [self.view setBackgroundColor:Public_Background_Color];
    
    UIWebView* webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate=self;
    webView.scalesPageToFit = YES;
    webView.autoresizesSubviews = NO;
    webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.view addSubview:webView];
    
    NSURL* url = [NSURL URLWithString:_url];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    _webView=webView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    if(self.hideNavBar)
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) onGoBack
{
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    if(_LinkCount<=0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        _LinkCount--;
        if( [_webView canGoBack] )
            [_webView goBack];
        else
            [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onFinish
{
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareReturnCash
{
//    SharePopV *pop=[[SharePopV alloc]init];
//    WeakSelf(self);
//    pop.shareBlock=^(NSInteger tag)
//    {
//       // [ShareManager sharePic:@"" shareType:tag isVideo:NO videoUrl:@"" videoTitle:@"" andController:weakself];
//        //[ShareManager sharePic:@"http://file.idlook.com/cut_2018102218321556797_img.0.jpg" shareType:tag isVideo:YES videoUrl:@"http://file.idlook.com/water.works_2018102218321361221_orgin.mov" videoTitle:@"" andController:weakself];
//        NSString *shareUrl = [NSString stringWithFormat:@"%@?returnCash=returnCash",self.url];
//        [ShareManager shareReturnCashWithType:tag Title:@"找演员上脸探，凭码下单立返20%" andDesc:@"返现码也可多次转赠他人使用，则转赠人返5%，下单人返15%" andUrl:shareUrl andController:weakself];
//    };
//
//    [pop showBottomShare];
    SharePopV *pop=[[SharePopV alloc]init];
    WeakSelf(self);
    pop.shareBlock=^(NSInteger tag)
    {
        // [ShareManager sharePic:@"" shareType:tag isVideo:NO videoUrl:@"" videoTitle:@"" andController:weakself];
        //[ShareManager sharePic:@"http://file.idlook.com/cut_2018102218321556797_img.0.jpg" shareType:tag isVideo:YES videoUrl:@"http://file.idlook.com/water.works_2018102218321361221_orgin.mov" videoTitle:@"" andController:weakself];
        NSString *shareUrl = self.url;
        [ShareManager shareReturnCashWithType:tag Title:@"脸探肖像" andDesc:@"来自脸探肖像app的分享。找演员，上脸探！" andUrl:shareUrl andController:weakself];
    };
    
    [pop showBottomShare];
}
-(void)toCouponVC
{
    CouponVC *couponVC = [[CouponVC alloc]init];
    [self.navigationController pushViewController:couponVC animated:YES];
}
-(UIButton *)getRightBarButtonItem2WithTarget:(id)target
                                       action:(SEL)sel
                                    normalImg:(NSString *)imageN
                                   hilightImg:(NSString *)imageH
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageH] forState:UIControlStateSelected];
   [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
@end
