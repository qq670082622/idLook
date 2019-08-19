//
//  PriceBottomVB.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PriceBottomVB.h"

@interface PriceBottomVB ()
@property (nonatomic,strong)MLLabel *promtLab;  //提示文字
@property(nonatomic,strong)UILabel *priceLab;     //价格
@property(nonatomic,strong)UILabel *descLab;   //
@property(nonatomic,strong)UILabel *scoreLab;     //积分

@end

@implementation PriceBottomVB

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
    UIView *topV = [[UIView alloc]init];
    [self addSubview:topV];
    topV.backgroundColor=[UIColor colorWithHexString:@"#FFF8E5"];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(68);
    }];
    
//    UIImageView *promtV=[[UIImageView alloc]init];
//    [self addSubview:promtV];
//    promtV.contentMode=UIViewContentModeScaleAspectFill;
//    promtV.image=[UIImage imageNamed:@"order_promt"];
//    [promtV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(topV);
//        make.left.mas_equalTo(self).offset(15);
//        make.size.mas_equalTo(CGSizeMake(12, 12));
//    }];
    
    MLLabel *promtLab = [[MLLabel alloc] init];
    promtLab.font = [UIFont systemFontOfSize:11];
    promtLab.numberOfLines=0;
    promtLab.lineSpacing=3.0;
    promtLab.textColor = [UIColor colorWithHexString:@"#FF6600"];
    [self addSubview:promtLab];
    [promtLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topV);
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
    }];
    self.promtLab=promtLab;
    
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:submitBtn];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
    submitBtn.backgroundColor=Public_Red_Color;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(60);
    }];
    [submitBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];

    UILabel *lab1 = [[UILabel alloc] init];
    lab1.font = [UIFont systemFontOfSize:14];
    lab1.textColor = Public_Text_Color;
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.mas_equalTo(submitBtn).offset(7);
    }];
    lab1.text=@"总价";
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.font = [UIFont boldSystemFontOfSize:15];
    priceLab.textColor = Public_Red_Color;
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab1.mas_right).offset(5);
        make.centerY.mas_equalTo(lab1);
    }];
    self.priceLab=priceLab;
    
    UIButton *placeDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:placeDetailBtn];
    [placeDetailBtn setTitle:@"价格明细" forState:UIControlStateNormal];
    [placeDetailBtn setTitleColor:[UIColor colorWithHexString:@"#75CAFF"] forState:UIControlStateNormal];
    placeDetailBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [placeDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(submitBtn.mas_left).offset(-10);
        make.centerY.mas_equalTo(submitBtn);
        make.width.mas_equalTo(80);
    }];
    
    [placeDetailBtn addTarget:self action:@selector(placeDetailBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.font = [UIFont systemFontOfSize:10];
    lab2.textColor = Public_Text_Color;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.mas_equalTo(lab1.mas_bottom).offset(3);
    }];
    self.descLab=lab2;
    
    UILabel *lab3 = [[UILabel alloc] init];
    lab3.font = [UIFont systemFontOfSize:10];
    lab3.textColor = Public_Red_Color;
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.mas_equalTo(lab2.mas_bottom).offset(3);
    }];
    self.scoreLab=lab3;
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

-(void)reloadUIWithTotalPrice:(NSInteger)total withSale:(NSInteger)sale withScore:(NSInteger)score
{
   
    self.priceLab.text=[NSString stringWithFormat:@"¥%ld",total];

    self.descLab.text=@"不包含服务费400元/天";
    
    NSString *desc = @"";
    if ([UserInfoManager getUserSubType]==UserSubTypePurPersonal) {
        desc=@"请在艺人确认档期后，去我的订单支付首款，并在拍摄前一天支付剩余尾款。";
    }
    else
    {
        desc=@"请在艺人确认档期后，去我的订单支付首款，并在拍摄完成后10个工作日内支付剩余尾款。";
    }
    
    if (sale<=0) {
        self.promtLab.text=[NSString stringWithFormat:@"此价格不包含6.4%%增值税，如您需要发票，可在下单后申请开票。%@",desc];
    }
    else
    {
        self.promtLab.text=[NSString stringWithFormat:@"此价格不包含6.4%%增值税，如您需要发票，可在下单后申请开票。本单已为您优惠%ld元，%@",sale,desc];
    }
    
    self.scoreLab.text=[NSString stringWithFormat:@"下单立得%ld积分",score];
}

@end
