//
//  ProjectMainCustomCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectMainCustomCell.h"

@interface ProjectMainCustomCell ()
@end

@implementation ProjectMainCustomCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self bgV];
        [self icon];
        [self nameLabel];
        [self sexIcon];
        [self regionLabel];
        [self stateLabel];
        [self roleLabel];
    }
    return self;
}

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
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=25;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgV).offset(17);
            make.left.mas_equalTo(self.bgV).offset(12);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        _icon.image=[UIImage imageNamed:@"head_default"];
    }
    return _icon;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont boldSystemFontOfSize:15.0];
        _nameLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.top.mas_equalTo(self.icon);
        }];
    }
    return _nameLabel;
}

-(UIImageView*)sexIcon
{
    if (!_sexIcon) {
        _sexIcon=[[UIImageView alloc]init];
        [self.contentView addSubview:_sexIcon];
        [_sexIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(2);
            make.centerY.mas_equalTo(self.nameLabel);
        }];
    }
    return _sexIcon;
}

-(UILabel*)regionLabel
{
    if (!_regionLabel) {
        _regionLabel=[[UILabel alloc]init];
        _regionLabel.font=[UIFont systemFontOfSize:12];
        _regionLabel.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_regionLabel];
        [_regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sexIcon.mas_right).offset(2);
            make.centerY.mas_equalTo(self.nameLabel);
        }];
    }
    return _regionLabel;
}

-(UILabel*)stateLabel
{
    if (!_stateLabel) {
        _stateLabel=[[UILabel alloc]init];
        _stateLabel.font=[UIFont systemFontOfSize:12.0];
        _stateLabel.textColor=Public_Red_Color;
        [self.contentView addSubview:_stateLabel];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgV).offset(-12);
            make.centerY.mas_equalTo(self.nameLabel);
        }];
        _stateLabel.text=@"已确认档期";
    }
    return _stateLabel;
}

-(UILabel*)roleLabel
{
    if (!_roleLabel) {
        _roleLabel=[[UILabel alloc]init];
        _roleLabel.font=[UIFont systemFontOfSize:12];
        _roleLabel.textColor=Public_Text_Color;
        [self.contentView addSubview:_roleLabel];
        [_roleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.top.mas_equalTo(self.contentView).offset(34);
        }];
        _roleLabel.text=@"饰演角色：职场白领";
    }
    return _roleLabel;
}


@end
