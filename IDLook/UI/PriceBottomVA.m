//
//  PriceBottomVA.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PriceBottomVA.h"

@interface PriceBottomVA ()
@property(nonatomic,strong)UILabel *priceLab;     //价格
@property(nonatomic,strong)UIButton *placeDetailBtn;  //明细按钮
@end

@implementation PriceBottomVA

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIButton *placeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:placeOrderBtn];
    [placeOrderBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    placeOrderBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
    placeOrderBtn.backgroundColor=Public_Red_Color;
    [placeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(110);
    }];
    [placeOrderBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.text = @"试镜费";
    lab1.font = [UIFont systemFontOfSize:13.0];
    lab1.textColor = Public_Text_Color;
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.mas_equalTo(self);
    }];
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.font = [UIFont boldSystemFontOfSize:18.0];
    priceLab.textColor = Public_Red_Color;
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab1.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
    }];
    self.priceLab=priceLab;
    
    UILabel *descLab = [[UILabel alloc] init];
    descLab.font = [UIFont systemFontOfSize:10.0];
    descLab.textColor = Public_Text_Color;
    descLab.text=@"(在线支付)";
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLab.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
    }];
    
    UIButton *placeDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:placeDetailBtn];
    [placeDetailBtn setTitle:@"价格明细" forState:UIControlStateNormal];
    [placeDetailBtn setTitleColor:[UIColor colorWithHexString:@"#75CAFF"] forState:UIControlStateNormal];
    placeDetailBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [placeDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceLab.mas_right).offset(10);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [placeDetailBtn addTarget:self action:@selector(placeDetailBtnAction) forControlEvents:UIControlEventTouchUpInside];
    placeDetailBtn.hidden=YES;
    self.placeDetailBtn=placeDetailBtn;
    
}

//下单
-(void)placeOrderAction
{
    self.placeOrderBlock();
}

//价格明细
-(void)placeDetailBtnAction
{
    self.praceDetailBlock();
}

-(void)reloadUIWithPrice:(NSString *)price WithType:(NSInteger)type
{
    self.priceLab.text=[NSString stringWithFormat:@"¥%ld",[price integerValue]];
    
}

@end
