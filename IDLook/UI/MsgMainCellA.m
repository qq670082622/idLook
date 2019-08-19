//
//  MsgMainCell.m
//  IDLook
//
//  Created by HYH on 2018/5/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MsgMainCellA.h"

@interface MsgMainCellA ()
@property(nonatomic,strong)UIView *bg;
@property(nonatomic,strong)UILabel *orderTypeLab;
@property(nonatomic,strong)UILabel *stateLab;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *desc1;
@property(nonatomic,strong)UILabel *desc2;
@end

@implementation MsgMainCellA
-(void)initUI
{
    [self bg];
    [self orderTypeLab];
    [self icon];
    [self titleLab];
    [self desc1];
    [self desc2];
    
}
-(UIView*)bg
{
    if (!_bg) {
        _bg=[[UIView alloc]init];
        _bg.backgroundColor=[UIColor whiteColor];
        _bg.layer.cornerRadius=4.0;
        _bg.layer.shadowOffset = CGSizeMake(8, 8);
        _bg.layer.shadowOpacity = 1.0;
        _bg.layer.shadowColor = [[UIColor colorWithHexString:@"#91ADC2"] colorWithAlphaComponent:0.05].CGColor;
        [self.contentView addSubview:_bg];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView);
        }];
        
        UIView *lineV= [[UIView alloc]init];
        lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        [_bg addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bg).offset(40);
            make.left.mas_equalTo(_bg).offset(15);
            make.centerX.mas_equalTo(_bg);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _bg;
}

-(UILabel*)orderTypeLab
{
    if (!_orderTypeLab) {
        _orderTypeLab=[[UILabel alloc]init];
        _orderTypeLab.font=[UIFont systemFontOfSize:13.0];
        _orderTypeLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_orderTypeLab];
        [_orderTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bg).offset(15);
            make.left.mas_equalTo(self.bg).offset(15);
        }];
    }
    _orderTypeLab.loadStyle = TABAnimationTypeOnlySkeleton;
    return _orderTypeLab;
}

-(UILabel*)stateLab
{
    if (!_stateLab) {
        _stateLab=[[UILabel alloc]init];
        _stateLab.font=[UIFont systemFontOfSize:13.0];
        _stateLab.textColor=Public_Red_Color;
        [self.contentView addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bg).offset(15);
            make.right.mas_equalTo(self.bg).offset(-15);
        }];
    }
    _stateLab.loadStyle = TABAnimationTypeOnlySkeleton;
    return _stateLab;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=2.0;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bg).offset(15);
            make.bottom.mas_equalTo(self.bg).offset(-15);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    }
    _icon.loadStyle = TABAnimationTypeOnlySkeleton;
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.icon);
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
        }];
    }
    _titleLab.loadStyle = TABAnimationTypeOnlySkeleton;
    return _titleLab;
}

-(UILabel*)desc1
{
    if (!_desc1) {
        _desc1=[[UILabel alloc]init];
        _desc1.numberOfLines=0;
        _desc1.font=[UIFont systemFontOfSize:12.0];
        _desc1.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc1];
        [_desc1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.desc2.mas_top).offset(-5);
        }];
    }
    _desc1.loadStyle = TABAnimationTypeOnlySkeleton;
    return _desc1;
}

-(UILabel*)desc2
{
    if (!_desc2) {
        _desc2=[[UILabel alloc]init];
        _desc2.numberOfLines=0;
        _desc2.font=[UIFont systemFontOfSize:12.0];
        _desc2.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc2];
        [_desc2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.icon);
        }];
    }
    _desc2.loadStyle = TABAnimationTypeOnlySkeleton;
    return _desc2;
}

-(void)reloadUIWithModel:(OrderProjectModel *)projectModel
{
    [self bg];
    self.orderTypeLab.text = projectModel.orderModel.ordertypeName;
    self.stateLab.text=[projectModel.orderModel getOrderStateWihtOrderInfo:projectModel.orderModel];
    [self.icon sd_setImageWithUrlStr:projectModel.orderModel.actorHead placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.titleLab.text=[NSString stringWithFormat:@"%@",projectModel.name];
    
    if (projectModel.orderModel.ordertype==OrderTypeAudition)
    {
        self.desc1.text=[NSString stringWithFormat:@"试镜方式：%@",[projectModel.orderModel getAuditionWayWithType:projectModel.orderModel.auditionType]];
        if (projectModel.orderModel.auditionType==4) {
            self.desc2.hidden = YES;
        }
        self.desc2.text=[NSString stringWithFormat:@"最晚上传作品日期：%@",projectModel.auditionend];
    }
    else if (projectModel.orderModel.ordertype==OrderTypeShot)
    {
        self.desc1.text = [NSString stringWithFormat:@"定妆场地：%@",projectModel.orderModel.shotordertype==1?@"自备场地":@"平面影棚"];
        self.desc2.text=[NSString stringWithFormat:@"拍摄时间：%@至%@",projectModel.start,projectModel.end];
    }
    else
    {
        self.desc1.text = [NSString stringWithFormat:@"定妆场地：%@",projectModel.orderModel.shotordertype==1?@"自备场地":@"平面影棚"];
        self.desc2.text=[NSString stringWithFormat:@"拍摄时间：%@至%@",projectModel.start,projectModel.end];
    }

}

@end
