//
//  StoreApplyView.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "StoreApplyView.h"
#import "StorePopView.h"
@implementation StoreApplyView
- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
       UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)showWithProductName:(NSString *)productName num:(NSInteger)num andTotalSorce:(NSInteger)totalSorce
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
    
    if(!showWindow)return;
    //当window上有视图时移除
    for (UIView *view in showWindow.subviews) {
        if ([view isKindOfClass:[StoreApplyView class]]) {
            return;
        }
    }
    
    [showWindow addSubview:self];
    
    self.frame = showWindow.frame;
    
    self.hidden = NO;
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    CGFloat y = (UI_SCREEN_HEIGHT-228)/2;
    StorePopView *pop = [[StorePopView alloc] init];
    pop.frame = CGRectMake(48, y-80, UI_SCREEN_WIDTH-96, 228);
    pop.layer.cornerRadius = 10;
    pop.layer.masksToBounds = YES;
    [self addSubview:pop];
    [pop initSubViewsWithProductName:productName num:num andTotalSorce:totalSorce];
    WeakSelf(self);
    pop.apply = ^{
        weakself.apply();
    };
    CGFloat btnX = (UI_SCREEN_WIDTH-34)/2;
    CGFloat btnY = pop.bottom+20;
    closeBtm.frame = CGRectMake(btnX, btnY, 34, 34);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}
- (void)hide
{
    //    [self clearSubV];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
    
    [UIView commitAnimations];
}

@end
