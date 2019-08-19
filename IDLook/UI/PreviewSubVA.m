//
//  PreviewSubVA.m
//  IDLook
//
//  Created by HYH on 2018/7/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PreviewSubVA.h"
#import "AddPriceSubV.h"
#import "AddPriceModel.h"

@interface PreviewSubVA()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)NSArray *dataSource;
@end

@implementation PreviewSubVA

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
        
    }
    return _titleLab;
}

-(void)reloadUIWithArray:(NSArray *)array withTitle:(NSString *)title withIndex:(NSInteger)index
{
    self.titleLab.text=title;
    self.dataSource=array;
    NSInteger count = array.count;
    CGFloat width = 0.0;    //item宽度
    NSInteger lineCount=0;   //一行的个数
    if (index==1||index==3) {
        width = (UI_SCREEN_WIDTH-30-10)/2;
        lineCount=2;
    }
    else
    {
        width = (UI_SCREEN_WIDTH-30-20)/3;
        lineCount=3;
    }
    
    for (int i =0; i<count; i++) {
        AddPriceModel *model =array[i];
        AddPriceSubV *subV= [[AddPriceSubV alloc]init];
        subV.tag=100+i;
        [self addSubview:subV];
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(50+60*(i/lineCount));
            make.left.mas_equalTo(self).offset(15+(width+10)*(i%lineCount));
            make.size.mas_equalTo(CGSizeMake(width, 50));
        }];
        subV.title=model.desc;
        subV.price=@"+2000元";
        
        if (lineCount==2)
        {
            subV.imageN=@"price_bg3";
        }
        else
        {
            subV.imageN=@"price_bg4";
        }
        
        subV.titleColor=[UIColor colorWithHexString:@"#999999"];
        subV.priceColor=Public_Text_Color;
        
        WeakSelf(self);
        subV.clickWithTag = ^(NSInteger tag) {
            if (model.isSelect==YES) {
                return;
            }
            [weakself clickActionWithTag:tag];
        };
        
        if (index==0) {
            subV.price=[NSString stringWithFormat:@"%ld元",model.price];
        }
        else
        {
            subV.price=[NSString stringWithFormat:@"+%ld元",model.price];
        }
        
        if (model.price<0) {
            subV.price=@"商议价";
        }
        
        if (i==0) {
            if (lineCount==2)
            {
                subV.imageN=@"price_bg1_click";
            }
            else
            {
                subV.imageN=@"price_bg2_click";
            }
            subV.titleColor=[UIColor whiteColor];
            subV.priceColor=Public_Red_Color;
            model.isSelect=YES;
        }
    }
}

-(void)clickActionWithTag:(NSInteger)tag
{
    NSString *imageN;
    NSString *imageH;
    if (self.dataSource.count==4) {
        imageN=@"price_bg3";
        imageH=@"price_bg1_click";
    }
    else
    {
        imageN=@"price_bg4";
        imageH=@"price_bg2_click";
    }
    
    for (int i =0; i<self.dataSource.count; i++)
    {
        AddPriceSubV *subV = [self viewWithTag:100+i];
        if (i==tag-100)
        {
            if (subV.isSelect==YES) {
                subV.imageN=imageN;
                subV.titleColor=[UIColor colorWithHexString:@"#999999"];
                subV.priceColor=Public_Text_Color;
                subV.isSelect=NO;
            }
            else
            {
                subV.imageN=imageH;
                subV.titleColor=[UIColor whiteColor];
                subV.priceColor=Public_Red_Color;
                subV.isSelect=YES;
            }
        }
        else
        {
            subV.imageN=imageN;
            subV.titleColor=[UIColor colorWithHexString:@"#999999"];
            subV.priceColor=Public_Text_Color;
            subV.isSelect=NO;
        }
    }
    self.clickTypeWithTag(tag-100);
}

@end
