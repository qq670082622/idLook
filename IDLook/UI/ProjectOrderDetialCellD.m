//
//  ProjectOrderDetialCellD.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOrderDetialCellD.h"

@interface ProjectOrderDetialCellD ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *descLab;  //
@property(nonatomic,strong)UILabel *priceLab;  //
@property(nonatomic,strong)UIButton *askBtn;
@end


@implementation ProjectOrderDetialCellD


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"档期保障";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(12);
        }];
    }
    return _titleLab;
}


-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        _descLab.font=[UIFont systemFontOfSize:13];
        _descLab.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(8);
        }];
        _descLab.text=@"档期预约金：";
    }
    return _descLab;
}


-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont systemFontOfSize:13];
        _priceLab.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLab.mas_right).offset(2);
            make.centerY.mas_equalTo(self.descLab);
        }];
    }
    return _priceLab;
}

-(UIButton*)askBtn
{
    if (!_askBtn) {
        _askBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_askBtn setBackgroundImage:[UIImage imageNamed:@"project_expain"] forState:UIControlStateNormal];
        [self.contentView addSubview:_askBtn];
        [_askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.descLab);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
        [_askBtn addTarget:self action:@selector(askAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askBtn;
}

-(void)reloadUIWithInfo:(ProjectOrderInfoM *)info
{
    [self titleLab];
    [self descLab];
    NSString *state =@"";
    if ([info.subState isEqualToString:@"pending_pay_first"]) {
        state=@"未支付";
    }
    else if ([info.subState isEqualToString:@"wait_actor_accept"] || [info.subState isEqualToString:@"pending_pay_last"] || [info.subState isEqualToString:@"pay_done"] || [info.subState isEqualToString:@"finish"])
    {
        state=@"已支付";
    }
    else
    {
        state=@"";
    }
    self.priceLab.text = [NSString stringWithFormat:@"￥%ld(%@）",info.firstPrice,state];
    [self askBtn];
}

-(void)askAction
{
    if (self.explainScheduleBlock) {
        self.explainScheduleBlock();
    }
}

@end
