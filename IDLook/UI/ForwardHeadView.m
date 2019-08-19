//
//  ForwardHeadView.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ForwardHeadView.h"

@interface ForwardHeadView ()
@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@end

@implementation ForwardHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        
        self.curePage = 0;
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    NSArray *array=@[@"提现到银行卡",@"提现到支付宝"];
    CGFloat width = UI_SCREEN_WIDTH/array.count;
    for (int i = 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:button];
        button.frame=CGRectMake(width*i,0, width, 44);
        
        if (i==0) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *btn = (UIButton*)[self viewWithTag:100];
    
    //slider
    UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(btn.center.x-47,40, 94, 4)];
    slider.backgroundColor = Public_Red_Color;
    [self addSubview:slider];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:slider.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(50, 50)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = slider.bounds;
    maskLayer.path = maskPath.CGPath;
    slider.layer.mask = maskLayer;
    self.slider=slider;
}


-(void)btnClicked:(UIButton*)sender
{
    for (int i =0; i<2; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:100+i];
        if (i==sender.tag-100) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }
        else
        {
            button.titleLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame=CGRectMake(sender.center.x-47,40, 94, 4);
    }];
    
    self.forwardTypeClickBlock(sender.tag-100);
}

@end
