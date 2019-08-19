//
//  AccountManageCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AccountManageCell.h"

@interface AccountManageCell ()
@property(nonatomic,strong)UIImageView *bg;
@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *accountLab;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UIButton *modfiyBtn;
@end

@implementation AccountManageCell

-(UIImageView*)bg
{
    if (!_bg) {
        _bg=[[UIImageView alloc]init];
        [self.contentView addSubview:_bg];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _bg;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bg).offset(20);
            make.left.mas_equalTo(self.bg).offset(20);
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        _titleLab.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _titleLab;
}

-(UILabel*)accountLab
{
    if (!_accountLab) {
        _accountLab=[[UILabel alloc]init];
        _accountLab.font=[UIFont boldSystemFontOfSize:28];
        _accountLab.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_accountLab];
        [_accountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
        }];
    }
    return _accountLab;
}

-(UILabel*)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont systemFontOfSize:12];
        _nameLab.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.bg).offset(-20);
        }];
    }
    return _nameLab;
}

-(UIButton*)modfiyBtn
{
    if (!_modfiyBtn) {
        _modfiyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_modfiyBtn];
        _modfiyBtn.layer.cornerRadius=3;
        _modfiyBtn.layer.masksToBounds=YES;
        _modfiyBtn.layer.borderWidth=1;
        _modfiyBtn.layer.borderColor=[[UIColor whiteColor]colorWithAlphaComponent:0.3].CGColor;
        [_modfiyBtn setTitle:@"修改" forState:UIControlStateNormal];
        [_modfiyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _modfiyBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_modfiyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon);
            make.right.mas_equalTo(self.bg).offset(-20);
            make.size.mas_equalTo(CGSizeMake(44, 28));
        }];
        
        [_modfiyBtn addTarget:self action:@selector(modfiyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modfiyBtn;
}


-(void)reloadUIWithDic:(NSDictionary *)dic withType:(NSInteger)type
{
    if (type==0) {
        self.bg.image=[UIImage imageNamed:@"bg_bank1"];
        self.icon.image=[UIImage imageNamed:@"icon_bank"];
        self.titleLab.text= dic[@"bankName"];
        self.accountLab.text= [self returnBankCard:dic[@"bankCardNo"]];
        self.nameLab.text=[NSString stringWithFormat:@"持卡人：%@**", [dic[@"accountName"]length]>0?[dic[@"accountName"] substringToIndex:1]:@"*"];
    }
    else if (type==1)
    {
        self.bg.image=[UIImage imageNamed:@"bg_alipay1"];
        self.icon.image=[UIImage imageNamed:@"icon_alipay"];
        self.titleLab.text= dic[@"aliPayName"];
        self.accountLab.text=[self returnAlipay:dic[@"aliPayId"]];
        self.nameLab.text=@"";
    }
    [self modfiyBtn];

}

#pragma mark--银行卡号中间部分密文显示
-(NSString *)returnBankCard:(NSString *)BankCardStr
{
    if (BankCardStr.length>4) {
        NSString *formerStr = [BankCardStr substringFromIndex:BankCardStr.length-4];
        NSString *CardNumberStr = [NSString stringWithFormat:@"••••  ••••  ••••  %@",formerStr];
        return CardNumberStr;
    }
    return BankCardStr;
}

#pragma mark--支付宝中间部分密文显示
-(NSString *)returnAlipay:(NSString *)alipay
{
    if (alipay.length>4) {
        NSString *formerStr1 = [alipay substringToIndex:3];
        NSString *formerStr2 = [alipay substringFromIndex:alipay.length-4];
        
        NSString *alipayNumberStr = [NSString stringWithFormat:@"%@  ••••  %@",formerStr1,formerStr2];
        return alipayNumberStr;
    }
    return alipay;
}

-(void)modfiyAction
{
    if (self.modifyAccountBlock) {
        self.modifyAccountBlock();
    }
}

@end
