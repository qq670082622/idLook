
//
//  PreviewSubVB.m
//  IDLook
//
//  Created by HYH on 2018/7/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PreviewSubVB.h"

@interface PreviewSubVB ()
@property(nonatomic,strong)UIView *bg;
@end

@implementation PreviewSubVB

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
        
        UILabel *desc = [[UILabel alloc] init];
        desc.numberOfLines=0;
        desc.textAlignment=NSTextAlignmentCenter;
        desc.textColor =  [UIColor colorWithHexString:@"#999999"];
        desc.font=[UIFont systemFontOfSize:12.0];
        [self addSubview:desc];
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self).offset(-15);
//            make.height.mas_equalTo(self).offset(75);
            make.bottom.mas_equalTo(self).offset(-18);
        }];
        desc.text = @"*平台基于基础价格，根据拍摄天数、城市、肖像年限、适用范围计算出到手价格";
    }
    return self;
}

-(UIView*)bg
{
    if (!_bg) {
        _bg = [[UIView alloc]init];
        _bg.backgroundColor=[UIColor whiteColor];
        [self addSubview:_bg];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(140);
        }];
    }
    return _bg;
}

-(void)reloadUIWithArray:(NSArray *)array
{
    for (int i =0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        UILabel *titleLab=[[UILabel alloc]init];
        [self.bg addSubview:titleLab];
        titleLab.font=[UIFont systemFontOfSize:14.0];
        titleLab.textColor=Public_Text_Color;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self).offset(20+25*i);
        }];
        titleLab.text=dic[@"title"];
        
        UILabel *contentLab=[[UILabel alloc]init];
        [self.bg addSubview:contentLab];
        contentLab.tag=1000+i;
        contentLab.font=[UIFont systemFontOfSize:14.0];
        contentLab.textColor=Public_Text_Color;
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.top.mas_equalTo(self).offset(20+25*i);
        }];
    }
}

-(void)refreshUIWithArray:(NSArray *)array withShowBG:(BOOL)show
{
    for (int i=0; i<array.count; i++) {
        UILabel *lab =(UILabel*)[self.bg viewWithTag:1000+i];
        lab.text=[NSString stringWithFormat:@"%@",array[i]];
    }
    
    if (show) {
        self.bg.hidden=NO;
    }
    else
    {
        self.bg.hidden=YES;
    }
}

@end
