//
//  OrderDetialCellB.m
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellB.h"

@interface OrderDetialCellB ()
@property(nonatomic,strong)UILabel *orderIDLab;
@property(nonatomic,strong)UILabel *timeLab;

@end

@implementation OrderDetialCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)orderIDLab
{
    if (!_orderIDLab) {
        _orderIDLab=[[UILabel alloc]init];
        [self.contentView addSubview:_orderIDLab];
        _orderIDLab.font=[UIFont systemFontOfSize:12];
        _orderIDLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [_orderIDLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _orderIDLab;
}


-(UILabel*)timeLab
{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        [self.contentView addSubview:_timeLab];
        _timeLab.font=[UIFont systemFontOfSize:12.0];
        _timeLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _timeLab;
}

-(void)reloadUIWithModel:(OrderModel *)model
{
    self.orderIDLab.text=[NSString stringWithFormat:@"订单编号：%@",model.orderId];
    self.timeLab.text=model.orderdate;
}

@end
