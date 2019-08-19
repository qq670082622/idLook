//
//  OrderDetialCellN.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderDetialCellN.h"

@interface  OrderDetialCellN ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descLab;
@property(nonatomic,strong)UIImageView *arrow;
@end

@implementation OrderDetialCellN

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        _titleLab.text=@"脚本";
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

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        [self.contentView addSubview:_descLab];
        _descLab.font=[UIFont systemFontOfSize:16.0];
        _descLab.textColor=[UIColor colorWithHexString:@"#47AEFF"];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-30);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _descLab;
}

-(void)reloadUI
{
    [self titleLab];
    [self arrow];
    if ([UserInfoManager getUserType]==UserTypePurchaser) {
        self.descLab.text=@"查看";
    }
    else
    {
        self.descLab.text=@"去下载";
    }
}

@end
