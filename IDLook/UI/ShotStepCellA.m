//
//  ShotStepCellA.m
//  IDLook
//
//  Created by HYH on 2018/7/20.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ShotStepCellA.h"

@interface ShotStepCellA ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *askBtn;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)MLLabel *placeholderLabel;
@property(nonatomic,strong)UILabel *priceLab;

@end

@implementation ShotStepCellA

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(13);
        }];
    }
    return _titleLab;
}

-(UIButton*)askBtn
{
    if (!_askBtn) {
        _askBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_askBtn];
        [_askBtn setBackgroundImage:[UIImage imageNamed:@"order_ask_gray"] forState:UIControlStateNormal];
        [_askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset(4);
            make.centerY.mas_equalTo(self.titleLab);
        }];
        [_askBtn addTarget:self action:@selector(askAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askBtn;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont boldSystemFontOfSize:16];
        _priceLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-40);
            make.top.mas_equalTo(self.contentView).offset(13);
        }];
    }
    return _priceLab;
}

-(MLLabel*)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel=[[MLLabel alloc]init];
        _placeholderLabel.numberOfLines=0;
        _placeholderLabel.font=[UIFont systemFontOfSize:11];
        _placeholderLabel.textColor=Public_DetailTextLabelColor;
        _placeholderLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _placeholderLabel.lineSpacing = 5;
        [self.contentView addSubview:_placeholderLabel];
        [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-40);
            make.top.mas_equalTo(self.contentView).offset(40);
        }];
    }
    return _placeholderLabel;
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
    self.titleLab.text=model.title;
    [self askBtn];
    self.placeholderLabel.text=model.placeholder;
    [self arrow];
    if (model.type==1) {  //预付档期预约金
        self.priceLab.text=[NSString stringWithFormat:@"¥%@",model.price];
    }
    else if(model.type==2)
    {
        self.priceLab.text=@"不预付档期预约金";
    }
    else
    {
        self.priceLab.text=@"";
    }
}

-(void)askAction
{
    if (self.ShotStepCellABlock) {
        self.ShotStepCellABlock();
    }
}

@end
