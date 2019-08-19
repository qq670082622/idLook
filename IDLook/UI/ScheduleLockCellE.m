//
//  ScheduleLockCellE.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockCellE.h"

@interface ScheduleLockCellE ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIImageView *arrow;
@end

@implementation ScheduleLockCellE

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        _bgV.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_bgV];
        _bgV.layer.masksToBounds=YES;
        _bgV.layer.cornerRadius=6.0;
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(12);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
        }];
    }
    return _bgV;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.image=[UIImage imageNamed:@"order_insurance"];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.bgV).offset(15);
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:12.0];
        _titleLab.textColor=Public_Red_Color;
        _titleLab.text=@"脸探平台免费赠送意外险";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(7);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}


-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.bgV).offset(-15);
        }];
    }
    return _arrow;
}

-(void)reloadUI
{
    [self bgV];
    [self icon];
    [self titleLab];
    [self arrow];
}

@end
