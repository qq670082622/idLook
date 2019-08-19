//
//  ProjectOrderDetialCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOrderDetialCellA.h"

@interface ProjectOrderDetialCellA ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIButton *priceDetailBtn;
@end

@implementation ProjectOrderDetialCellA

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:18];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(16);
        }];
    }
    return _titleLab;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        _descLab.font=[UIFont systemFontOfSize:11];
        _descLab.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
        }];
    }
    return _descLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont systemFontOfSize:13];
        _descLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.titleLab);
        }];
    }
    return _priceLab;
}

-(UIButton*)priceDetailBtn
{
    if (!_priceDetailBtn) {
        _priceDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_priceDetailBtn];
        [_priceDetailBtn setTitle:@"价格明细" forState:UIControlStateNormal];
        [_priceDetailBtn setTitleColor:[UIColor colorWithHexString:@"#47AEFF"] forState:UIControlStateNormal];
        _priceDetailBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        [_priceDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.contentView).offset(-18);
        }];
        [_priceDetailBtn addTarget:self action:@selector(priceDetialAction) forControlEvents:UIControlEventTouchUpInside];
        _priceDetailBtn.hidden=YES;
    }
    return _priceDetailBtn;
}

-(void)reloadUIWithInfo:(ProjectOrderInfoM *)info
{
    self.titleLab.text=info.subStateName;
    self.descLab.text=@"";
    [self priceDetailBtn];
    
    NSString *str=[NSString stringWithFormat:@"总价￥%ld",info.totalPrice];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]} range:NSMakeRange(2,str.length-2)];
    self.priceLab.attributedText=attStr;
    
}

-(void)priceDetialAction
{
    
}

@end
