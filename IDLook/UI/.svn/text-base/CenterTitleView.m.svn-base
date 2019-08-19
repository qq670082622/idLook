//
//  CenterTitleView.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CenterTitleView.h"

@interface CenterTitleView ()
@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@end

@implementation CenterTitleView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI
{

    CGFloat width = (UI_SCREEN_WIDTH - 60)/3;

    NSArray *array=@[@"个人资料",@"形象展示",@"可合作内容"];
    for (int i = 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(30+width*i);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(width);
        }];
        
        if (i==0) {
            button.selected=YES;
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
    for (int i =0; i<3; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:100+i];
        if (i==sender.tag-100) {
            button.selected=YES;
        }
        else
        {
            button.selected=NO;
        }
    }
    
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(@4);
        make.centerX.mas_equalTo(sender);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    self.clickWithIndexBlock(sender.tag-100);
}

@end
