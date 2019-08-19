//
//  ThridLRView.m
//  IDLook
//
//  Created by HYH on 2018/4/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ThridLRView.h"

@implementation ThridLRView


-(void)layoutIfNeeded
{
    [super layoutIfNeeded];
    
    for(int i=0;i<2;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        
        if(i ==0)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_wechat"] forState:UIControlStateNormal];
        }
        else if(i ==1)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_sina"] forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            if(i ==0)
            {
                make.right.equalTo(self.mas_centerX).offset(-30);
            }
            else if(i==1)
            {
                make.left.equalTo(self.mas_centerX).offset(30);
            }
                
        }];
    }
    
    UILabel *lab = [[UILabel alloc] init];
    lab.textColor = [UIColor lightGrayColor];
    lab.font = [UIFont systemFontOfSize:13.0];
    lab.text = @"其他方式登录";
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    
    UIView *line1V=[[UIView alloc]init];
    line1V.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:line1V];
    [line1V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lab);
        make.right.mas_equalTo(lab.mas_left).offset(-10);
        make.height.mas_equalTo(@(0.5));
        make.left.mas_equalTo(self).offset(30);
    }];
    
    UIView *line2V=[[UIView alloc]init];
    line2V.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:line2V];
    [line2V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lab);
        make.left.mas_equalTo(lab.mas_right).offset(10);
        make.height.mas_equalTo(@(0.5));
        make.right.mas_equalTo(self).offset(-30);
    }];
}

- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.btnClickedType(btn.tag+1);
}

@end
