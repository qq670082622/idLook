//
//  LookPricePopV2Cell.m
//  IDLook
//
//  Created by 吴铭 on 2018/12/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "LookPricePopV2Cell.h"
@interface LookPricePopV2Cell ()
@property(nonatomic,strong)UIView *bg;

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *priceLab;
//@property(nonatomic,strong)UIButton *placeOrderBtn;
@property(nonatomic,strong)UIButton *orderBtn;
@end
@implementation LookPricePopV2Cell

-(UIView*)bg
{
    if (!_bg) {
        _bg=[[UIView alloc]init];
        [self.contentView addSubview:_bg];
        _bg.layer.cornerRadius=5.0;
        _bg.layer.masksToBounds=YES;
        _bg.layer.borderColor = [UIColor colorWithHexString:@"#F7F7F7"].CGColor;
        _bg.layer.borderWidth = 1.5;
        _bg.backgroundColor=[UIColor whiteColor];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(4);
            make.bottom.mas_equalTo(self.contentView).offset(-4);
        }];
    }
  
    return _bg;
}
-(UIButton *)orderBtn
{
    if (!_orderBtn) {
        UIButton *oBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.orderBtn = oBtn;
        [_bg addSubview:_orderBtn];
        [_orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg);
            make.right.mas_equalTo(self.bg);
            make.top.mas_equalTo(self.bg);
            make.bottom.mas_equalTo(self.bg);
        }];
        [_orderBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderBtn;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:14.0];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bg).offset(14);
            make.left.mas_equalTo(self.bg).offset(7);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(25);
        }];
    }
    return _titleLab;
}

-(UILabel *)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        [self.contentView addSubview:_descLab];
        _descLab.font=[UIFont systemFontOfSize:10.0];
        _descLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bg).offset(32);
            make.left.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self.bg).offset(-12);
            make.bottom.mas_equalTo(self.bg).offset(-5);
        }];
    }
    return _descLab;
}
-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        [self.contentView addSubview:_priceLab];
        _priceLab.font=[UIFont systemFontOfSize:14.0];
        _priceLab.textColor=Public_Red_Color;
        _priceLab.textAlignment = NSTextAlignmentRight;
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(147);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.bg).offset(-12);
            make.top.mas_equalTo(self.titleLab);
        }];
    }
    return _priceLab;
}

//-(UIButton*)placeOrderBtn
//{
//    if (!_placeOrderBtn) {
//        _placeOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [self.bg addSubview:_placeOrderBtn];
//        _placeOrderBtn.backgroundColor=Public_Red_Color;
//        _placeOrderBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
//        _placeOrderBtn.layer.cornerRadius=5.0;
//        _placeOrderBtn.layer.masksToBounds=YES;
//        [_placeOrderBtn setTitle:@"下单" forState:UIControlStateNormal];
//        [_placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.placeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(54);
//            make.height.mas_equalTo(32);
//            make.right.mas_equalTo(self.bg).offset(-9);
//            make.centerY.mas_equalTo(self.bg);
//        }];
//        [_placeOrderBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _placeOrderBtn;
//}

-(void)reloadUIWithModel:(OrderStructM *)model
{
    [self bg];
    [self orderBtn];
    [self titleLab];
    [self priceLab];
    self.titleLab.text = model.title;
//    [self placeOrderBtn];
 
        [self descLab];
        self.priceLab.text=[NSString stringWithFormat:@"%@元",model.price];
        
    
        self.descLab.text = model.desc;
        self.descLab.numberOfLines = 2;
   
    
}

-(void)placeOrderAction
{
    
    if (self.LookPricePopCellBlock) {
        self.LookPricePopCellBlock();
    }
}
@end
