//
//  ScheduleLockBottomV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockBottomV.h"

@interface ScheduleLockBottomV ()
@property(nonatomic,strong)UILabel *priceLab;     //价格
@property(nonatomic,strong)UILabel *totalPriceLab;   //总价
@end

@implementation ScheduleLockBottomV

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)reloadWithFirstPrice:(NSInteger)firstPrice withTotal:(NSInteger)total
{
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:submitBtn];
    submitBtn.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;  //分行
    submitBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    submitBtn.titleLabel.textColor=[UIColor whiteColor];
    submitBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
    submitBtn.backgroundColor=Public_Red_Color;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(60);
    }];
    [submitBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *str=@"提交订单\n并支付档期预约金";
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(4,str.length-4)];
    [submitBtn setAttributedTitle:attStr forState:UIControlStateNormal];
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.font = [UIFont boldSystemFontOfSize:18];
    priceLab.textColor = Public_Red_Color;
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.mas_equalTo(submitBtn).offset(10);
    }];
    priceLab.text=[NSString stringWithFormat:@"¥ %ld",firstPrice];
    self.priceLab=priceLab;
    
    UILabel *totalPriceLab = [[UILabel alloc] init];
    totalPriceLab.font = [UIFont systemFontOfSize:13];
    totalPriceLab.textColor = Public_Text_Color;
    [self addSubview:totalPriceLab];
    [totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.mas_equalTo(priceLab.mas_bottom).offset(2);
    }];
    totalPriceLab.text=[NSString stringWithFormat:@"总价 ¥%ld",total];
    self.totalPriceLab=totalPriceLab;
    
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
    placeDetailBtn.hidden=YES;
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

@end
