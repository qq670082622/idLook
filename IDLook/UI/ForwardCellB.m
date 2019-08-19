//
//  ForwardCellB.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ForwardCellB.h"

@interface ForwardCellB ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *accountLab;

@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UIImageView *bg;

@end

@implementation ForwardCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

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

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        _titleLab.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg).offset(20);
            make.top.mas_equalTo(self.bg).offset(34);
        }];
    }
    return _titleLab;
}

-(UILabel*)accountLab
{
    if (!_accountLab) {
        _accountLab=[[UILabel alloc]init];
        _accountLab.font=[UIFont boldSystemFontOfSize:20];
        _accountLab.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_accountLab];
        [_accountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg).offset(20);
            make.bottom.mas_equalTo(self.bg).offset(-16);
        }];
    }
    return _accountLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"assets_arrow"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.bg).offset(-15);
        }];
    }
    return _arrow;
}

-(void)reloadUIWithDic:(NSDictionary *)dic withType:(NSInteger)type
{
    NSDictionary *bankCardInfo = (NSDictionary*)safeObjectForKey(dic, @"bankCardInfo");  //银行卡信息
    NSDictionary *aliPayInfo = (NSDictionary*)safeObjectForKey(dic, @"aliPayInfo");  //支付宝信息

    if (type==0) {
        self.bg.image=[UIImage imageNamed:@"bg_bank"];
        if (bankCardInfo==nil) {
            self.titleLab.text=@"添加银行卡";
            self.accountLab.text=@"";
            [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bg).offset(34);
            }];
        }
        else
        {
            self.titleLab.text = bankCardInfo[@"bankName"];
            self.accountLab.text= [self returnBankCard:bankCardInfo[@"bankCardNo"]];
            [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bg).offset(20);
            }];
        }
    }
    else if (type==1)
    {
        self.bg.image=[UIImage imageNamed:@"bg_alipay"];
        if (aliPayInfo==nil) {
            self.titleLab.text=@"添加支付宝账号";
            self.accountLab.text=@"";
            [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bg).offset(34);
            }];
        }
        else
        {
            self.titleLab.text = aliPayInfo[@"aliPayName"];
            self.accountLab.text=[self returnAlipay:aliPayInfo[@"aliPayId"]];
            [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bg).offset(20);
            }];
        }
    }
    [self arrow];
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

@end
