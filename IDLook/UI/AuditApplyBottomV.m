//
//  AuditApplyBottomV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditApplyBottomV.h"

@interface AuditApplyBottomV ()
@property(nonatomic,strong)UILabel *priceLab;     //价格
@end

@implementation AuditApplyBottomV

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
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *promtV=[[UIImageView alloc]init];
    [self addSubview:promtV];
    promtV.contentMode=UIViewContentModeScaleAspectFill;
    promtV.image=[UIImage imageNamed:@"order_promt"];
    [promtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topV);
        make.left.mas_equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    UILabel *promtLab = [[UILabel alloc] init];
    promtLab.font = [UIFont systemFontOfSize:12];
    promtLab.numberOfLines=0;
    promtLab.textColor = [UIColor colorWithHexString:@"#FF6600"];
    [self addSubview:promtLab];
    [promtLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topV);
        make.left.mas_equalTo(self).offset(40);
        make.right.mas_equalTo(self).offset(-15);
    }];
    promtLab.text=@"提交成功后，脸探平台客服会在1个工作日内通过电话联系您， 请留意。";
    
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:submitBtn];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
    submitBtn.backgroundColor=Public_Red_Color;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(topV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(130, 48));
    }];
    [submitBtn addTarget:self action:@selector(placeOrderAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.font = [UIFont systemFontOfSize:14];
    lab1.textColor = Public_Text_Color;
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.centerY.mas_equalTo(submitBtn);
    }];
    lab1.text=@"总价";
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.font = [UIFont boldSystemFontOfSize:18];
    priceLab.textColor = Public_Red_Color;
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab1.mas_right).offset(5);
        make.centerY.mas_equalTo(lab1);
    }];
    priceLab.text=@"￥0";
    self.priceLab=priceLab;

}

//下单
-(void)placeOrderAction
{
    if (self.placeOrderBlock) {
        self.placeOrderBlock();
    }
}


-(void)reloadUIWithTotalPrice:(NSInteger)total
{
    
    self.priceLab.text=[NSString stringWithFormat:@"¥%ld",total];
}

@end
