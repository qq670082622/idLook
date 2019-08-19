//
//  AddPriceSubC.m
//  IDLook
//
//  Created by HYH on 2018/7/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddPriceSubC.h"
#import "AddPriceSubV.h"

@interface AddPriceSubC ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;

@property(nonatomic,strong)UIView *bgV;

@property(nonatomic,assign)BOOL isEdit;  //是否可修改
@end

@implementation AddPriceSubC


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self).offset(13);
        }];
        
        UIView *lineV=[[UIView alloc]init];
        lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        [self addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(40);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _titleLab;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        [self addSubview:_descLab];
        _descLab.font=[UIFont systemFontOfSize:12.0];
        _descLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-10);
            make.centerY.mas_equalTo(self.titleLab);
        }];
        _descLab.text=@"默认加价(可修改）";
    }
    return _descLab;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        [self addSubview:_bgV];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(40);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
        }];
    }
    return _bgV;
}


-(void)reloadUIWithArray:(NSArray *)array withType:(OfferType)type withTitle:(NSString *)title
{
    self.Prices = [NSArray arrayWithArray:array];
    self.titleLab.text=title;
    
    if (type==OfferTypeDays) {
        self.descLab.hidden=NO;
    }
    else
    {
        self.descLab.hidden=YES;
    }
    
    NSInteger count = array.count;
    CGFloat width = 0.0;    //item宽度
    NSInteger lineCount=0;   //一行的个数
    if (type==OfferTypeCity || type==OfferTypeRange) {
        width = (UI_SCREEN_WIDTH-30-10)/2;
        lineCount=2;
    }
    else
    {
        width = (UI_SCREEN_WIDTH-30-20)/3;
        lineCount=3;
    }
    
    for (int i =0;i<count; i++)
    {
        AddPriceModel *model =array[i];
        AddPriceSubV *subV= [[AddPriceSubV alloc]init];
        subV.tag=(self.tag-1000+1)*10000+i;
        [self addSubview:subV];
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(50+60*(i/lineCount));
            make.left.mas_equalTo(self).offset(15+(width+10)*(i%lineCount));
            make.size.mas_equalTo(CGSizeMake(width, 50));
        }];
        subV.title=model.desc;
        
        if (lineCount==2)
        {
            subV.imageN=@"price_bg3";
        }
        else
        {
            subV.imageN=@"price_bg4";
        }
        
        subV.titleColor=[UIColor colorWithHexString:@"#999999"];
        
        if (type==OfferTypeDays) {
            subV.price=[NSString stringWithFormat:@"%ld元",model.price];
        }
        else
        {
            subV.price=[NSString stringWithFormat:@"+%ld元",model.price];
        }
        
        if (model.price<0) {
            subV.price=@"商议价";
        }
        
        if (type==OfferTypeDays&&i>0) {  //可编辑部分
            subV.priceColor=Public_Red_Color;
            WeakSelf(self);
            subV.clickWithTag = ^(NSInteger tag) {
                [weakself clickActionWithTag:tag];
            };
        }
        else  //不可编辑
        {
            subV.priceColor=[UIColor colorWithHexString:@"#999999"];
            subV.clickWithTag = ^(NSInteger tag) {
            };
        }
    }
}

-(void)clickActionWithTag:(NSInteger)tag
{
    self.clickPriceWithTag(tag-10000);
}

-(void)refreshDataWithArray:(NSArray *)array withType:(OfferType)type
{
    for (int i =0; i<array.count; i++) {
        AddPriceSubV *subV=[self viewWithTag:(self.tag-1000+1)*10000+i];
        AddPriceModel *model =array[i];

        if (type==OfferTypeDays) {
            subV.price=[NSString stringWithFormat:@"%ld元",model.price];
        }
        else
        {
            subV.price=[NSString stringWithFormat:@"+%ld元",model.price];
        }
        if (model.price<0) {
            subV.price=@"商议价";
        }
    }
}

@end
