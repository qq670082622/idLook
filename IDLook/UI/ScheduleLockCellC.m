//
//  ScheduleLockCellC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockCellC.h"

@interface ScheduleLockCellC ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UIImageView *icon;   //头像
@property(nonatomic,strong)UILabel *nameLab;  //名称
@property(nonatomic,strong)UIImageView *sexIcon;   //性别
@property(nonatomic,strong)UILabel *regionLab;  //所在地
@property(nonatomic,strong)UILabel *priceLab;  //价格
@property(nonatomic,strong)UILabel *shotDayLab;  //拍摄日期
@property(nonatomic,strong)UILabel *shotTypeLab;  //拍摄类别

@end

@implementation ScheduleLockCellC

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

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"拍摄艺人";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.bgV).offset(12);
        }];
    }
    return _titleLab;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=16;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgV).offset(46);
            make.left.mas_equalTo(self.bgV).offset(12);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
    }
    return _icon;
}

-(UILabel*)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont systemFontOfSize:16.0];
        _nameLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _nameLab;
}

-(UIImageView*)sexIcon
{
    if (!_sexIcon) {
        _sexIcon=[[UIImageView alloc]init];
        [self.contentView addSubview:_sexIcon];
        [_sexIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLab.mas_right).offset(2);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _sexIcon;
}

-(UILabel*)regionLab
{
    if (!_regionLab) {
        _regionLab=[[UILabel alloc]init];
        _regionLab.font=[UIFont systemFontOfSize:13];
        _regionLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_regionLab];
        [_regionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sexIcon.mas_right).offset(2);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _regionLab;
}

-(UILabel*)priceLab
{
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
        _priceLab.font=[UIFont systemFontOfSize:16.0];
        _priceLab.textColor=[UIColor colorWithHexString:@"#4E4E4E"];
        [self.contentView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-12);
            make.centerY.mas_equalTo(self.icon);
        }];
    }
    return _priceLab;
}

-(UILabel*)shotDayLab
{
    if (!_shotDayLab) {
        _shotDayLab=[[UILabel alloc]init];
        _shotDayLab.font=[UIFont systemFontOfSize:13];
        _shotDayLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_shotDayLab];
        [_shotDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.icon.mas_bottom).offset(9);
        }];
    }
    return _shotDayLab;
}

-(UILabel*)shotTypeLab
{
    if (!_shotTypeLab) {
        _shotTypeLab=[[UILabel alloc]init];
        _shotTypeLab.font=[UIFont systemFontOfSize:13];
        _shotTypeLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_shotTypeLab];
        [_shotTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(12);
            make.top.mas_equalTo(self.shotDayLab.mas_bottom).offset(5);
        }];
    }
    return _shotTypeLab;
}


-(void)reloadUIWithProjectOrderInfo:(ProjectOrderInfoM *)info
{
    if (info==nil) return;

    [self bgV];
    [self titleLab];
    [self.icon sd_setImageWithUrlStr:info.actorInfo[@"actorHead"] placeholderImage:[UIImage imageNamed:@"head_default"]];
    self.nameLab.text=info.actorInfo[@"actorName"];
    NSInteger sex = [info.actorInfo[@"sex"]integerValue];
    self.sexIcon.image = [UIImage imageNamed:sex==1?@"icon_male":@"icon_female"];
    self.regionLab.text=[NSString stringWithFormat:@"• %@",info.actorInfo[@"region"]];
    self.priceLab.text=[NSString stringWithFormat:@"￥%ld",info.totalPrice];
    self.shotDayLab.text=[NSString stringWithFormat:@"拍摄日期：%@至%@",info.shotStart,info.shotEnd];
    self.shotTypeLab.text=[NSString stringWithFormat:@"拍摄类别：%@",info.shotType];
}


@end
