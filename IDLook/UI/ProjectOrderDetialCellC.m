//
//  ProjectOrderDetialCellC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOrderDetialCellC.h"

@interface ProjectOrderDetialCellC ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *orderIdLabel;  //订单编号
@property(nonatomic,strong)UILabel *orderDateLabel;  //下单时间
@end

@implementation ProjectOrderDetialCellC

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"订单信息";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(12);
        }];
    }
    return _titleLab;
}


-(UILabel*)orderIdLabel
{
    if (!_orderIdLabel) {
        _orderIdLabel=[[UILabel alloc]init];
        _orderIdLabel.font=[UIFont systemFontOfSize:13];
        _orderIdLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_orderIdLabel];
        [_orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(43);
        }];
    }
    return _orderIdLabel;
}


-(UILabel*)orderDateLabel
{
    if (!_orderDateLabel) {
        _orderDateLabel=[[UILabel alloc]init];
        _orderDateLabel.font=[UIFont systemFontOfSize:13];
        _orderDateLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_orderDateLabel];
        [_orderDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.orderIdLabel.mas_bottom).offset(5);
        }];
    }
    return _orderDateLabel;
}


-(void)reloadUIWithInfo:(ProjectOrderInfoM *)info
{
    [self titleLab];
    
    NSString *str1=[NSString stringWithFormat:@"订单编号：%@",info.orderId];
    NSMutableAttributedString * attStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [attStr1 addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(5,str1.length-5)];
    self.orderIdLabel.attributedText=attStr1;
    
    NSString *str2=[NSString stringWithFormat:@"提交时间：%@",info.orderDate];
    NSMutableAttributedString * attStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [attStr2 addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(5,str2.length-5)];
    self.orderDateLabel.attributedText=attStr2;
}

@end
