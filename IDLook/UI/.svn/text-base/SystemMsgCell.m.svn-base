//
//  SystemMsgCell.m
//  IDLook
//
//  Created by HYH on 2018/6/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SystemMsgCell.h"

@interface SystemMsgCell ()
@property(nonatomic,strong)UIView *bg;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)MLLabel *descLab;
@end

@implementation SystemMsgCell

-(UIView*)bg
{
    if (!_bg) {
        _bg=[[UIView alloc]init];
        _bg.backgroundColor=[UIColor whiteColor];
        _bg.layer.cornerRadius=5.0;
        [self.contentView addSubview:_bg];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return _bg;
}


-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds=YES;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(25);
            make.top.mas_equalTo(self.contentView).offset(18);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.icon);
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
        }];
    }
    return _titleLab;
}

-(MLLabel*)descLab
{
    if (!_descLab) {
        _descLab=[[MLLabel alloc]init];
        _descLab.numberOfLines=0;
        _descLab.font=[UIFont systemFontOfSize:13.0];
        _descLab.textColor=[UIColor colorWithHexString:@"#999999"];
        _descLab.lineSpacing = 5;
        [self.contentView addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-25);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
        }];
    }
    return _descLab;
}


-(void)reloadUIWithDic:(NSDictionary *)dic
{
    [self bg];

    [self.icon sd_setImageWithUrlStr:dic[@"url"] placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.titleLab.text=dic[@"title"];
    self.descLab.text=dic[@"content"];
}


@end
