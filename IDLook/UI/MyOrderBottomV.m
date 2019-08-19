//
//  MyOrderBottomV.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyOrderBottomV.h"

@interface MyOrderBottomV ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIButton *payBtn;     //付款

@end

@implementation MyOrderBottomV

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:14];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"合计：";
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.centerY.mas_equalTo(self.payBtn);
        }];
    }
    return _titleLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        [self addSubview:_priceLab];
        _priceLab.font=[UIFont boldSystemFontOfSize:17];
        _priceLab.textColor=Public_Red_Color;
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset(3);
            make.centerY.mas_equalTo(self.payBtn);
        }];
    }
    return _priceLab;
}

-(UIButton*)payBtn
{
    if (!_payBtn) {
        _payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_payBtn];
        _payBtn.backgroundColor=Public_Red_Color;
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(0);
            make.right.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(104, 48));
        }];
        [_payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}


-(void)reloadUIWithPrice:(NSInteger)price
{
    [self titleLab];
    self.priceLab.text = [NSString stringWithFormat:@"¥%ld",price];
    [self payBtn];

}

-(void)payAction
{
    if (self.OrderBottomPayBlock) {
        self.OrderBottomPayBlock();
    }
}

@end
