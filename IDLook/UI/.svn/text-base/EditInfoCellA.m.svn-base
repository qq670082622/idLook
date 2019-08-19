//
//  EditInfoCellA.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditInfoCellA.h"

@interface EditInfoCellA ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;

@end

@implementation EditInfoCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:14.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
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
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=30;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.arrow.mas_left).offset(-15);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    }
    return _icon;
}


-(void)reloadUI
{

    self.titleLab.text=@"头像";
    [self arrow];
    [self.icon sd_setImageWithUrlStr:[UserInfoManager getUserHead] placeholderImage:[UIImage imageNamed:@"head_default"]];
}

@end
