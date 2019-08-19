//
//  ScheduleCellB.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleCellB.h"

@interface ScheduleCellB ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIImageView *arrow;    //
@property(nonatomic,strong)UIView *lineV;
@end

@implementation ScheduleCellB

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(UITextField*)textField
{
    if (!_textField) {
        _textField=[[UITextField alloc]init];
        _textField.font=[UIFont systemFontOfSize:15];
        _textField.textColor=Public_Text_Color;
        _textField.enabled=NO;
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(120);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.arrow).offset(-20);
            make.height.mas_equalTo(48);
        }];
    }
    return _textField;
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

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    self.titleLab.text=dic[@"title"];
    self.textField.placeholder=dic[@"placeholder"];
    self.textField.text=dic[@"content"];
    [self arrow];
    [self lineV];
}

@end
