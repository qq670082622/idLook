//
//  AuditServiceDetialCellB.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditServiceDetialCellB.h"

@interface AuditServiceDetialCellB ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *orderIdLabel;  //订单编号
@property(nonatomic,strong)UILabel *orderDateLabel;  //下单时间
@end

@implementation AuditServiceDetialCellB

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


-(void)reloadUIWithModel:(RoleServiceModel*)model;
{
    [self titleLab];
    self.orderIdLabel.text=[NSString stringWithFormat:@"订单编号：%@",model.orderId];
    self.orderDateLabel.text=[NSString stringWithFormat:@"下单时间：%@",model.orderTime];
}


@end
