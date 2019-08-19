//
//  PriceTopV.m
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PriceTopV.h"

@interface PriceTopV ()
@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@end

@implementation PriceTopV

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        self.curePage = 0;
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    NSArray *array=@[@"视频广告",@"平面广告",@"活动广告"];
    
    CGFloat width = (UI_SCREEN_WIDTH - 80)/3;
    
    for (int i = 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(40+width*i);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(width);
        }];
        
        if (i==0) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
            [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIButton *btn = (UIButton*)[self viewWithTag:100];
    
    //slider
    UIView *slider = [[UIView alloc] init];
    slider.backgroundColor = Public_Red_Color;
    [self addSubview:slider];
    slider.layer.cornerRadius=2.0;
    slider.layer.masksToBounds=YES;
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(@4);
        make.centerX.mas_equalTo(btn);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    self.slider=slider;
}


-(void)btnClicked:(UIButton*)sender
{
    self.priceClickTypeBlock(sender.tag-100);
}


-(void)slideWithTag:(NSInteger)tag
{
    for (int i =0; i<3; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:100+i];
        if (i==tag) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
            [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        }
        else
        {
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        }
    }
    UIButton *sender = (UIButton*)[self viewWithTag:100+tag];
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(@4);
        make.centerX.mas_equalTo(sender);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}


@end
