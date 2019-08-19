//
//  MyOrderTopV.m
//  IDLook
//
//  Created by HYH on 2018/5/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyOrderTopV.h"
#import "UIButton+badgeNum.h"
@interface MyOrderTopV ()
@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@property(nonatomic,strong)NSArray *dataSource;
@end

@implementation MyOrderTopV

-(id)initWithCUrePage:(NSInteger)page
{
    if (self=[super init]) {
        self.curePage=page;
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    
//    self.dataSource=@[@"全部",@"待确认",@"进行中",@"已完成",@"已失效"];

    if ([UserInfoManager getUserType]==UserTypePurchaser) {
        self.dataSource=@[@"全部",@"待确认",@"进行中",@"已完成",@"已失效"];
    }
    else
    {
        self.dataSource=@[@"全部",@"待确认",@"议价中",@"进行中",@"已完成",@"已失效"];
    }
    
    
    CGFloat width = UI_SCREEN_WIDTH/self.dataSource.count;
    
    for (int i = 0; i<self.dataSource.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitle:self.dataSource[i] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width*i);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(width);
        }];
        
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *btn = (UIButton*)[self viewWithTag:100+self.curePage];
     btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    
    //slider
    UIView *slider = [[UIView alloc] init];
    slider.backgroundColor = Public_Red_Color;
    [self addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(3);
        make.centerX.mas_equalTo(btn);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    self.slider=slider;
}


-(void)btnClicked:(UIButton*)sender
{
    for (int i =0; i<self.dataSource.count; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:100+i];
        if (i==sender.tag-100) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        }
        else
        {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        }
    }
    
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(3);
        make.centerX.mas_equalTo(sender);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    self.orderClickTypeBlock(sender.tag-100);
}



@end
