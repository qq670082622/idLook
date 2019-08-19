/*
 @header  SharePopV.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/25
 @description
 
 */

#import "SharePopV.h"

@interface SharePopV ()
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong) UIView *externalView;
@end

@implementation SharePopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 185);
    }
    return self;
}

-(void)showBottomShare
{
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    self.maskV=maskV;
    
    [showWindow addSubview:self];
    
    [self creatClickLayout];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-185, UI_SCREEN_WIDTH, 185);
    
    [UIView commitAnimations];
    
}
-(void)showBottomShareWithReturnView:(UIView *)returnView andQRCodeImg:(UIImage *)img
{
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    self.maskV=maskV;
    
    returnView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    [showWindow addSubview:returnView];
    UIButton *cancelBtn = [returnView viewWithTag:111];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *qrImg = [returnView viewWithTag:222];
    qrImg.image = img;
    self.externalView = returnView;
    [showWindow addSubview:self];
  
    [self creatClickLayout];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-185, UI_SCREEN_WIDTH, 185);
    
    [UIView commitAnimations];
}

-(void)creatClickLayout
{

    UIView *line1=[[UIView alloc]init];
    line1.backgroundColor=Public_LineGray_Color;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(40);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH, 1));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:16.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(10);
    }];
    titleLab.text=@"分享到";
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setImage:[UIImage imageNamed:@"price_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.right.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    NSArray *dataS=@[@{@"icon":@"share_wx",@"title":@"微信"},
                     @{@"icon":@"share_wx_timeline",@"title":@"朋友圈"}];
    CGFloat width=(UI_SCREEN_WIDTH-60*3)/2;
    for (int i=0; i<dataS.count; i++) {
        ShareCell *cell=[[ShareCell alloc]init];
        cell.tag=i;
        [self addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(65+(i/2)*120);
            make.left.mas_equalTo(self).offset(60+(i%2)*(width+60));
            make.size.mas_equalTo(CGSizeMake(width, 80));
        }];
        WeakSelf(self);
        cell.ShareCellBlock=^(NSInteger type)
        {
            [weakself hide];
            weakself.shareBlock(type);
        };
        
        [cell loadCellWithImage:[[dataS objectAtIndex:i] objectForKey:@"icon"] withTitle:[[dataS objectAtIndex:i] objectForKey:@"title"]];
    }
}

- (void)hide
{
    if (_hideBlock) {
        self.hideBlock();
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    if (_externalView) {
        self.externalView.alpha = 0.f;
    }
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 220);
    [UIView commitAnimations];
   
}

- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    if (_externalView) {
         [self.externalView removeFromSuperview];
    }
   [self removeFromSuperview];
}

@end

@interface ShareCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *title;
@end

@implementation ShareCell

-(id)init
{
    if (self=[super init])
    {
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClicked)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        [self addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.centerX.mas_equalTo(self.mas_centerX);
            //make.size.mas_equalTo(CGSizeMake(19, 16));
        }];
    }
    return _icon;
}

-(UILabel*)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:13.0];
        _title.textColor = Public_DetailTextLabelColor;
        _title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.icon.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
    return _title;
}


-(void)loadCellWithImage:(NSString *)icon withTitle:(NSString *)title
{
    self.title.text=title;
    self.icon.image=[UIImage imageNamed:icon];
}

- (void)btnClicked
{
    self.ShareCellBlock(self.tag);
}

@end
