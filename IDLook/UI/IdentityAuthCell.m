//
//  IdentityAuthCell.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/9.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "IdentityAuthCell.h"

@implementation IdentityAuthCell

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UILabel *titleLab=[[UILabel alloc]init];
    [self addSubview:titleLab];
    titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
    titleLab.text=@"拍摄证件要求：";
    titleLab.font=[UIFont systemFontOfSize:13.0];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(15);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    UIView *bg = [[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(40);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    UILabel *descLab1=[[UILabel alloc]init];
    [self addSubview:descLab1];
    descLab1.textColor=[UIColor colorWithHexString:@"#666666"];
    descLab1.text=@"1.身份证为大陆公民持有的本人二代身份证； ";
    descLab1.font=[UIFont systemFontOfSize:13.0];
    [descLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(60);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    UILabel *descLab2=[[UILabel alloc]init];
    [self addSubview:descLab2];
    descLab2.textColor=[UIColor colorWithHexString:@"#666666"];
    descLab2.text=@"2.请确保身份证边框完整，字体清晰，证件号码清晰可见。";
    descLab2.font=[UIFont systemFontOfSize:13.0];
    [descLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(descLab1.mas_bottom).offset(8);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    NSArray *array = @[@"正确示例",@"边角缺失",@"信息模糊",@"闪光强烈"];
    CGFloat width = (UI_SCREEN_WIDTH-15*2-3*7)/4;
    for (int i =0; i<4; i++) {
        UIImageView *imageV=[[UIImageView alloc]init];
        [self addSubview:imageV];
        imageV.contentMode=UIViewContentModeScaleAspectFill;
        imageV.image=[UIImage imageNamed:[NSString stringWithFormat:@"idcard_model_%d",i+1]];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(114);
            make.left.mas_equalTo(self).offset(15+(width+7)*i);
            make.width.mas_equalTo(width);
        }];
        
        UILabel *lab=[[UILabel alloc]init];
        [self addSubview:lab];
        lab.textColor=Public_Text_Color;
        lab.text=array[i];
        lab.font=[UIFont systemFontOfSize:13.0];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageV.mas_bottom).offset(8);
            make.centerX.mas_equalTo(imageV);
        }];
    }
    
    
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:submitBtn];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"auth_next"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交认证" forState:UIControlStateNormal];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-30);
        make.centerX.mas_equalTo(self);
    }];
    [submitBtn addTarget:self action:@selector(submitAuth) forControlEvents:UIControlEventTouchUpInside];
}

-(void)submitAuth
{
    if (self.submitBlock) {
        self.submitBlock();
    }
}

@end
