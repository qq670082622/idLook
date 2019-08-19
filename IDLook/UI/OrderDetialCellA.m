//
//  OrderDetialCellA.m
//  IDLook
//
//  Created by HYH on 2018/6/27.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellA.h"

@interface OrderDetialCellA ()
@property(nonatomic,strong)UIImageView *bg;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *stateLab;
@property(nonatomic,strong)UIImageView *waitIcon;
@property(nonatomic,strong)UIImageView *arrow;

@end

@implementation OrderDetialCellA

-(UIImageView*)bg
{
    if (!_bg) {
        _bg=[[UIImageView alloc]init];
        [self.contentView addSubview:_bg];
        _bg.image=[UIImage imageNamed:@"order_top_bg"];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return _bg;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:14];
        _titleLab.textColor=[UIColor whiteColor];
        _titleLab.text=@"订单进度：";
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(UIImageView*)waitIcon
{
    if (!_waitIcon) {
        _waitIcon=[[UIImageView alloc]init];
        [self.contentView addSubview:_waitIcon];
        _waitIcon.image=[UIImage imageNamed:@"order_wait"];
        [_waitIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _waitIcon;
}

-(UILabel*)stateLab
{
    if (!_stateLab) {
        _stateLab=[[UILabel alloc]init];
        [self.contentView addSubview:_stateLab];
        _stateLab.font=[UIFont boldSystemFontOfSize:16.0];
        _stateLab.textColor=[UIColor whiteColor];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.waitIcon.mas_right).offset(5);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _stateLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"order_arrow"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        _arrow.hidden=YES;
    }
    return _arrow;
}

-(void)reloadUIWithModel:(OrderModel *)model
{
    [self bg];
    [self titleLab];
    [self waitIcon];
    self.stateLab.text=[model getOrderStateWihtOrderInfo:model];
    [self arrow];
    
    if ([model.orderstate isEqualToString:@"finished"]) {
        self.waitIcon.image=[UIImage imageNamed:@"order_finished"];
    }
    else if ([model.orderstate isEqualToString:@"cancel"] || [model.orderstate isEqualToString:@"rejected"] || [model.orderstate isEqualToString:@"overtime"] || [model.orderstate isEqualToString:@"buydefault"] ||[model.orderstate isEqualToString:@"actordefault"]||[model.orderstate isEqualToString:@"noschedule"])
    {
        self.waitIcon.image=[UIImage imageNamed:@"order_cancel"];
    }

    else
    {
        self.waitIcon.image=[UIImage imageNamed:@"order_wait"];
    }
    
}

@end
