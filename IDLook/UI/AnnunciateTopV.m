//
//  AnnunciateTopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateTopV.h"

@interface AnnunciateTopV ()
@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@end

@implementation AnnunciateTopV


-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    NSArray *array=@[@"全部",@"已选中",@"进行中",@"未入选"];
    
    CGFloat width = UI_SCREEN_WIDTH/array.count;
    
    for (int i = 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:button];
        button.frame=CGRectMake(width*i,0, width, 44);
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *btn = (UIButton*)[self viewWithTag:100];
    
    //slider
    UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(btn.center.x-24,40, 48, 4)];
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
    for (int i =0; i<4; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:100+i];
        if (i==sender.tag-100) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }
        else
        {
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame=CGRectMake(sender.center.x-24,40, 48, 4);
    }];
    
    if (self.AnnunciateTopVBlock) {
        self.AnnunciateTopVBlock(sender.tag-100);
    }
    
}


@end
