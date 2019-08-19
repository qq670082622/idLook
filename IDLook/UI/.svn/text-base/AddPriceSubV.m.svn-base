//
//  AddPriceSubV.m
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddPriceSubV.h"

@interface AddPriceSubV ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *priceLab;
@end

@implementation AddPriceSubV

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.userInteractionEnabled=YES;
        [self addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_icon addGestureRecognizer:tap];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.icon addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:12.0];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.icon);
            make.top.mas_equalTo(self.icon).offset(5);
        }];
        
    }
    return _titleLab;
}


-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        [self.icon addSubview:_priceLab];
        _priceLab.font=[UIFont systemFontOfSize:12.0];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.icon);
            make.bottom.mas_equalTo(self.icon).offset(-7);
        }];
    }
    return _priceLab;
}


-(void)tapAction
{
    self.clickWithTag(self.tag);
}

-(void)setTitle:(NSString *)title
{
    _title=title;
    self.titleLab.text=title;
}

-(void)setImageN:(NSString *)imageN
{
    _imageN=imageN;
    self.icon.image=[UIImage imageNamed:imageN];
}

-(void)setPrice:(NSString *)price
{
    _price=price;
    self.priceLab.text=price;
}

-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor=titleColor;
    self.titleLab.textColor=titleColor;
}

-(void)setPriceColor:(UIColor *)priceColor
{
    _priceColor=priceColor;
    self.priceLab.textColor=priceColor;
}

@end
