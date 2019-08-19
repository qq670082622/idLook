//
//  ShotStepCellF.m
//  IDLook
//
//  Created by Mr Hu on 2018/12/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ShotStepCellF.h"
#import "PriceModel.h"

@interface ShotStepCellF ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)OrderStructM *model;
@property(nonatomic,strong)MLLabel *contentLab;
@property(nonatomic,strong)UILabel *placeholderLabel;

@end

@implementation ShotStepCellF

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.userInteractionEnabled=YES;
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView).offset(0);
            make.width.mas_equalTo(110);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [_titleLab addGestureRecognizer:tap];
    }
    return _titleLab;
}

-(UILabel*)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel=[[UILabel alloc]init];
        _placeholderLabel.font=[UIFont systemFontOfSize:16];
        _placeholderLabel.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
        [self.contentView addSubview:_placeholderLabel];
        [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(124);
            make.right.mas_equalTo(self.contentView).offset(-40);
            make.top.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _placeholderLabel;
}

-(MLLabel*)contentLab
{
    if (!_contentLab) {
        _contentLab=[[MLLabel alloc]init];
        _contentLab.numberOfLines=0;
        _contentLab.font=[UIFont systemFontOfSize:16];
        _contentLab.textColor=Public_Text_Color;
        _contentLab.lineBreakMode = NSLineBreakByCharWrapping;
        _contentLab.lineSpacing = 5;
        [self.contentView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(124);
            make.right.mas_equalTo(self.contentView).offset(-40);
            make.top.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _contentLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}


-(void)reloadUIWithModel:(OrderStructM *)model
{
    self.model=model;
    self.titleLab.text=model.title;
    [self arrow];
    
    if (model.videoTypeDic!=nil) {
        self.placeholderLabel.hidden=YES;
        
        NSDictionary *dic = model.videoTypeDic[@"dic"];
        NSInteger day = [model.videoTypeDic[@"day"]integerValue];
        NSInteger advertType = [dic[@"advertType"]integerValue];
        NSString *advName = @"";
        
        if (advertType==1) {
            advName=@"视频";
        }
        else if (advertType==2)
        {
            advName=@"平面";
        }
        else if (advertType==4)
        {
            advName=@"套拍";
        }
        self.contentLab.text=[NSString stringWithFormat:@"%@/%ld天",advName,day];
    }
    else
    {
        self.placeholderLabel.text=model.placeholder;
        self.placeholderLabel.hidden=NO;
    }

    
}


-(void)hide
{
    
}

@end
