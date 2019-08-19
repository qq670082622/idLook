//
//  CitySelectView.m
//  IDLook
//
//  Created by 吴铭 on 2019/7/26.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CitySelectView.h"
#import "CitiesView.h"
@interface CitySelectView()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)NSMutableArray *selectArr;
@end
@implementation CitySelectView
- (id)init
{
    if(self=[super init])
    {
        Vheight = UI_SCREEN_HEIGHT-200;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }
    return self;
}
-(void)showTypeWithSelectCities:(NSArray *)city
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
    _selectArr = [NSMutableArray new];
    [self.selectArr addObjectsFromArray:city];
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    [showWindow addSubview:self];
    self.maskV=maskV;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
    [self initUI];
    [UIView commitAnimations];
}
- (void)initUI
{
    WeakSelf(self);
    CitiesView *cv = [[CitiesView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, Vheight)];
    [cv reloadUIWithSelectCities:[_selectArr copy]];
    cv.selectCities = ^(NSArray * _Nonnull cities) {
        weakself.citySelectAction(cities);
    };
    cv.close = ^{
        [weakself hide];
    };
    [self addSubview:cv];
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
