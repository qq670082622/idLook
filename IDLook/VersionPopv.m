//
//  VersionPopv.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "VersionPopv.h"
@interface VersionPopv()
@property (nonatomic,strong)UIView *maskV;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
- (IBAction)updateAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *contentView;//158d高的图片+content(文字+按钮)

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;//y=46

@property(nonatomic,strong) UIButton *closeBtn;
@end

@implementation VersionPopv
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"VersionPopv" owner:nil options:nil] lastObject];
    }
   return self;
}
-(void)showWithUpdate:(BOOL)update andVersion:(NSString *)version andTips:(NSArray *)tips
{
    UIWindow *showWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            for (id any in window.subviews) {
                if ([any isKindOfClass:[VersionPopv class]]) {
                    return ; //已经有了
                }
            }
            showWindow = window;
            break;
        }
    }
    if(!showWindow)return;
  
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    if (!update) {
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        tap.numberOfTapsRequired = 1;
        [maskV addGestureRecognizer:tap];
    }
   
    [showWindow addSubview:maskV];
    [showWindow addSubview:self];
    self.maskV=maskV;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.versionLabel.text = [NSString stringWithFormat:@"%@",version];
    CGFloat tipsBottom = 46;
    for (int i =0; i<tips.count; i++) {
        
        UIView *tipView = [UIView new];
        tipView.backgroundColor = [UIColor whiteColor];
        UIView *dian = [UIView new];
        dian.backgroundColor = Public_Red_Color;
        dian.frame = CGRectMake(21, 6, 6, 6);
        dian.layer.cornerRadius = 3;
        dian.layer.masksToBounds = YES;
        [tipView addSubview:dian];
        
        UILabel *tip = [UILabel new];
        tip.text = tips[i];
        tip.font = [UIFont systemFontOfSize:15];
        tip.textColor = Public_Text_Color;
        tip.numberOfLines = 0;
        tip.frame = CGRectMake(37, 0, 280-74, 0);
        [tip sizeToFit];
        [tipView addSubview:tip];
        
        tipView.frame = CGRectMake(0, tipsBottom+14, 280, tip.bottom);
       [self.contentView addSubview:tipView];
        tipsBottom = tipView.bottom;
    }
   
    self.contentView.height = update?tipsBottom+109:tipsBottom+20;
    self.layer.cornerRadius = 9;
    self.layer.masksToBounds = YES;
    self.updateBtn.hidden = update?NO:YES;
    self.updateBtn.y = tipsBottom;
    self.frame = CGRectMake((UI_SCREEN_WIDTH-280)/2, self.height*0.35, 280,158+_contentView.height);
    if (!update) {
    
                UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
                [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
                closeBtm.frame = CGRectMake((UI_SCREEN_WIDTH-34)/2, self.bottom+25, 34, 34);
               [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
                closeBtm.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
                [showWindow addSubview:closeBtm];
        self.closeBtn = closeBtm;
    }
      [UIView commitAnimations];
  
}
-(UIView *)createTipWithString:(NSString *)title andY:(CGFloat)Y
{
    UIView *tipView = [UIView new];
    tipView.backgroundColor = [UIColor whiteColor];
    UIView *dian = [UIView new];
    dian.backgroundColor = Public_Red_Color;
    dian.frame = CGRectMake(21, 7.5, 6, 6);
    [tipView addSubview:dian];
    
    UILabel *tip = [UILabel new];
    tip.text = title;
    tip.font = [UIFont systemFontOfSize:15];
    tip.textColor = Public_Text_Color;
    tip.numberOfLines = 0;
    tip.frame = CGRectMake(37, 0, 280-74, 0);
    [tip sizeToFit];
    [tipView addSubview:tip];
    
    tipView.frame = CGRectMake(0, Y, 280, tip.bottom);
    NSInteger lines = tip.numberOfLines;
    CGFloat dianY = ((tip.bottom/lines)/2)-3;
    dian.y = dianY;
    
    return tipView;
    
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    //   [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    [self.maskV removeFromSuperview];
    [self.closeBtn removeFromSuperview];
    [self removeFromSuperview];
    [UIView commitAnimations];
}
-(void)imageClick
{
    self.update();
}
- (IBAction)updateAction:(id)sender {
    [self hide];
      self.update();
}
@end
