//
//  MyworksTopV.m
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyworksTopV.h"

@interface MyworksTopV ()
@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@end

@implementation MyworksTopV

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
    NSString *string;
    if ([UserInfoManager getUserMastery]==2) {
        string = @"剧照";
    }
    else
    {
        string = @"模特卡";
    }
    
    NSArray *array=@[@"试戏作品",@"过往作品",@"自我介绍",string];
    
    CGFloat width = (UI_SCREEN_WIDTH - 40)/4;
    
    for (int i = 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(20+width*i);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(width);
        }];
        
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIButton *btn = (UIButton*)[self viewWithTag:100];
    
    //slider
    UIView *slider = [[UIView alloc] init];
    slider.backgroundColor = [UIColor colorWithHexString:@"#FB4855"];
    [self addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(3);
        make.centerX.mas_equalTo(btn);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    self.slider=slider;
}


-(void)btnClicked:(UIButton*)sender
{
    self.worksClickTypeBlock(sender.tag-100);
}


-(void)slideWithTag:(NSInteger)tag
{
    CGFloat width = (UI_SCREEN_WIDTH - 40)/4;
    UIButton *sender = (UIButton*)[self viewWithTag:100+tag];
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(3);
        make.centerX.mas_equalTo(sender);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}


@end
