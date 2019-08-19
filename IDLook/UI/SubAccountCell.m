//
//  SubAccountCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "SubAccountCell.h"

@interface SubAccountCell ()
@property(nonatomic,strong)UIImageView *icon;   //头像
@property(nonatomic,strong)UILabel *name;      //名称
@property(nonatomic,strong)UILabel *descLab;   //id
@property(nonatomic,strong)UIImageView *arrow;    //
@property(nonatomic,strong)UIView *lineV;
@end

@implementation SubAccountCell

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.cornerRadius=20;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds=YES;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _icon;
}

-(UILabel*)name
{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont systemFontOfSize:15.0];
        _name.textColor=Public_Text_Color;
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.top.mas_equalTo(self.icon);
        }];
    }
    return _name;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        _descLab.font=[UIFont systemFontOfSize:13.0];
        _descLab.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
        [self.contentView addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.icon);
        }];
    }
    return _descLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}

-(UIView*)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor=Public_LineGray_Color;
        [self.contentView addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineV;
}


-(void)reloadUI
{
    [self.icon sd_setImageWithUrlStr:[UserInfoManager getUserHead] placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.name.text=@"李小龙";
    self.descLab.text=@"脸探肖像ID：012445656";
    [self arrow];
    [self lineV];
}

@end
