//
//  AuditionBottomV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditionBottomV.h"

@interface AuditionBottomV ()
@property(nonatomic,strong)UILabel *priceLab;     //价格
@property(nonatomic,strong)UIButton *placeDetailBtn;  //明细按钮
@end

@implementation AuditionBottomV

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
        make.width.mas_equalTo(130);
    }];
    [placeOrderBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.text = @"总价";
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
    priceLab.text=@"¥0";
    self.priceLab=priceLab;
    
#if 0
    UIButton *placeDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:placeDetailBtn];
    [placeDetailBtn setTitle:@"价格明细" forState:UIControlStateNormal];
    [placeDetailBtn setTitleColor:[UIColor colorWithHexString:@"#47AEFF"] forState:UIControlStateNormal];
    placeDetailBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [placeDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(placeOrderBtn.mas_left).offset(-10);
        make.centerY.mas_equalTo(placeOrderBtn);
    }];
    [placeDetailBtn addTarget:self action:@selector(placeDetailBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.placeDetailBtn=placeDetailBtn;
#endif
}

//下单
-(void)placeOrderAction
{
    if (self.placeOrderBlock) {
        self.placeOrderBlock();
    }
}

//价格明细
-(void)placeDetailBtnAction
{
    if (self.priceDetailBlock) {
        self.priceDetailBlock();
    }
}

-(void)reloadUIWithPrice:(NSString *)price
{
    self.priceLab.text=[NSString stringWithFormat:@"¥%ld",[price integerValue]];
}


@end
