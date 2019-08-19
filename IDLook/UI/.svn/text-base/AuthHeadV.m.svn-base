//
//  AuthHeadV.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthHeadV.h"

@interface AuthHeadV ()
@property(nonatomic,strong)NSArray *dataS;
@end

@implementation AuthHeadV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
        
        [self initUI];
    }
    return self;
}

-(void)initUI
{

    CGFloat width = 0.0;
    CGFloat totlaWidth = 0.0 ;
    //资源方
    if ([UserInfoManager getUserType]==UserTypeResourcer) {
        width=UI_SCREEN_WIDTH/3;
        self.dataS= @[@{@"title":@"1.基本资料",@"width":@(width)},
                      @{@"title":@"2.银行卡信息",@"width":@(width)},
                      @{@"title":@"3.上传证件",@"width":@(width)}];
    }
    else  //购买方
    {
        //购买方个人
        if ([UserInfoManager getUserSubType]==UserSubTypePurPersonal) {
            width=UI_SCREEN_WIDTH/3;
            self.dataS= @[@{@"title":@"1.基本资料",@"width":@(width)},
                          @{@"title":@"2.上传管理员身份证/护照照片",@"width":@(width*2)}];
        }
        else   //购买方企业
        {
            width=UI_SCREEN_WIDTH/3;
            self.dataS= @[@{@"title":@"1.基本资料",@"width":@(width)},
                          @{@"title":@"2.上传营业执照/身份证照片",@"width":@(width*2)}];

        }
    }

    for (int i = 0; i<self.dataS.count; i++) {
        NSDictionary *dic = self.dataS[i];
        UILabel *lab = [[UILabel alloc]init];
        [self addSubview:lab];
        lab.font=[UIFont systemFontOfSize:14.0];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.tag=100+i;
        lab.text=dic[@"title"];
        lab.textColor=[UIColor colorWithHexString:@"#CCCCCC"];
        CGFloat labWidth = [dic[@"width"] floatValue];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(totlaWidth);
            make.width.mas_equalTo(labWidth);
        }];
        
        if (i==0) {
            lab.textColor=Public_Red_Color;
        }
        
        totlaWidth+=labWidth;
        
        if (i<self.dataS.count-1) {
            UIImageView *imageV=[[UIImageView alloc]init];
            [self addSubview:imageV];
            imageV.tag=1000+i;
            imageV.image=[UIImage imageNamed:@"auth_arrow_n"];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(lab.mas_right);
            }];
            
            if (i==0) {
                imageV.image=[UIImage imageNamed:@"auth_arrow_h"];
            }
        }
    }
}

-(void)reloadWithStep:(NSInteger)step
{
    for (int i = 0 ; i<self.dataS.count; i++) {
        UILabel *lab =(UILabel*)[self viewWithTag:100+i];
        if (i<=step) {
            lab.textColor=Public_Red_Color;
        }
        else
        {
            lab.textColor=[UIColor colorWithHexString:@"#CCCCCC"];
        }
    }
    
    for (int i = 0 ; i<self.dataS.count-1; i++) {
        UIImageView *imageV =(UIImageView*)[self viewWithTag:1000+i];
        if (i<=step) {
            imageV.image=[UIImage imageNamed:@"auth_arrow_h"];
        }
        else
        {
            imageV.image=[UIImage imageNamed:@"auth_arrow_n"];
        }
    }
}

@end
