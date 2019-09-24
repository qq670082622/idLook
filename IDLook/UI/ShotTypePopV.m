//
//  ShotTypePopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/28.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ShotTypePopV.h"
@interface ShotTypePopV()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,copy)NSString *type;
@end
@implementation ShotTypePopV
- (id)init
{
    if(self=[super init])
    {
        Vheight = 239;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}
-(void)showTypeWithSelect:(NSString *)type
{
    UIWindow *showWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    if(!showWindow)return;
    if (type.length==0 || !type.length) {
        _type = @"";
    }else{
    _type = type;
    }
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    [showWindow addSubview:self];
    self.maskV=maskV;
     [self initUI];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
   
    [UIView commitAnimations];
}

- (void)initUI
{
    UILabel *piceLabel = [UILabel new];
    piceLabel.frame = CGRectMake(15, 20, 100, 23);
    piceLabel.textColor = [UIColor colorWithHexString:@"464646"];
    piceLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    piceLabel.text = @"拍摄类型";
    [self addSubview:piceLabel];

    NSArray *titleArr= @[@"视频",@"平面",@"不限"];
    CGFloat wid = (UI_SCREEN_WIDTH-24);
    for(int i =0;i<3;i++){
        CGFloat y = 54 + i*58;
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(12, y, wid, 48);;
        NSString *title = titleArr[i];
        [btn setTitle:title forState:0];
        if ([title isEqualToString:_type]) {
            [btn setTitleColor:Public_Red_Color forState:0];
            btn.layer.borderColor = Public_Red_Color.CGColor;
        }else{
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        }
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+50];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
       
        [self addSubview:btn];
    }
}
-(void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag-50;
   NSArray *titleArr= @[@"视频",@"平面",@"不限"];
    NSString *selectTitle = titleArr[tag];
  
    
    UIButton *video = [self viewWithTag:50];
    video.layer.borderColor = Public_Text_Color.CGColor;
    [video setTitleColor:Public_Text_Color forState:0];
    UIButton *plain = [self viewWithTag:51];
    plain.layer.borderColor = Public_Text_Color.CGColor;
    [plain setTitleColor:Public_Text_Color forState:0];
    UIButton *any = [self viewWithTag:52];
    any.layer.borderColor = Public_Text_Color.CGColor;
    [any setTitleColor:Public_Text_Color forState:0];
    
  
    [btn setTitleColor:Public_Red_Color forState:0];
    btn.layer.borderColor = Public_Red_Color.CGColor;
    self.selectType(selectTitle);
    [self hide];
}

- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    //   [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    [UIView commitAnimations];
}
@end
