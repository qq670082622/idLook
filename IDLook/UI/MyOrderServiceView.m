//
//  MyOrderServiceView.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/16.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyOrderServiceView.h"
#import "OrderModel.h"

@interface MyOrderServiceView ()
@property(nonatomic,strong)UILabel *serviceLab;      //服务费
@property(nonatomic,strong)UILabel *servicePriceLab;      //服务费价格
@property(nonatomic,strong)UIButton *selectBtn;  //选择按钮

@end

@implementation MyOrderServiceView

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_selectBtn];
        [_selectBtn setImage:[UIImage imageNamed:@"work_disable"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"work_disable_01"] forState:UIControlStateSelected];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(0);
            make.size.mas_equalTo(CGSizeMake(46, 45));
        }];
//        _selectBtn.enabled=NO;
    }
    return _selectBtn;
}

-(UILabel*)serviceLab
{
    if (!_serviceLab) {
        _serviceLab=[[UILabel alloc]init];
        _serviceLab.font=[UIFont systemFontOfSize:15];
        _serviceLab.textColor=Public_Text_Color;
        [self addSubview:_serviceLab];
        [_serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(45);
            make.bottom.mas_equalTo(self).offset(-12);
        }];
    }
    return _serviceLab;
}

-(UILabel*)servicePriceLab
{
    if (!_servicePriceLab) {
        _servicePriceLab=[[UILabel alloc]init];
        _servicePriceLab.font=[UIFont systemFontOfSize:15];
        _servicePriceLab.textColor=Public_Text_Color;
        [self addSubview:_servicePriceLab];
        [_servicePriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-20);
            make.bottom.mas_equalTo(self).offset(-12);
        }];
    }
    return _servicePriceLab;
}

-(void)reloadUIWithModel:(OrderProjectModel *)model
{
    NSString *str = [NSString stringWithFormat:@"服务费%@",model.documentarystatus==0?@"":@"(已支付)"];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(3,str.length-3)];
    self.serviceLab.attributedText=attStr;
    
    self.servicePriceLab.text= [NSString stringWithFormat:@"¥%ld",400*model.auditiondays];
    
    BOOL isHideBtn = YES ;
    if (model.ordeState != OrderStateTypeAll&& model.documentarystatus==0) {
        BOOL btnStatus=NO;
        for (int i=0; i<model.orderlist.count; i++) {
            OrderModel *orderModel = model.orderlist[i];
            if ([orderModel.orderstate isEqualToString:@"acceptted"]) {
                isHideBtn =NO;
            }
            if (orderModel.isChoose){
                btnStatus=YES;
            }
        }
        self.selectBtn.selected=btnStatus;
    }

    self.selectBtn.hidden=isHideBtn;
}

@end
