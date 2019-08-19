//
//  AddPriceSubB.m
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddPriceSubB.h"

@interface AddPriceSubB ()
@property(nonatomic,strong)UILabel *titleLab;


@end

@implementation AddPriceSubB

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(14);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(100);
        }];
    }
    return _titleLab;
}

-(UILabel*)tipsLab
{
    if (!_tipsLab) {
        _tipsLab=[[UILabel alloc]init];
        [self addSubview:_tipsLab];
        _tipsLab.textColor = [UIColor colorWithHexString:@"FF6600"];
        _tipsLab.font = [UIFont systemFontOfSize:13];
        _tipsLab.textAlignment = 0;
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(_titleLab.mas_bottom).offset(8);
        }];
    }
    return _tipsLab;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab=[[UILabel alloc]init];
        [self addSubview:_descLab];
        _descLab.font=[UIFont systemFontOfSize:15.0];
        _descLab.textColor=Public_Text_Color;
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-10);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(40);
        }];
    }
    return _descLab;
}

-(UITextField*)textField
{
    if (!_textField) {
        _textField=[[UITextField alloc]init];
        _textField.font=[UIFont systemFontOfSize:15.0];
        _textField.keyboardType=UIKeyboardTypeNumberPad;
        _textField.textAlignment=NSTextAlignmentRight;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.descLab.mas_left).offset(-5);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.titleLab.mas_right).offset(15);
        }];
        _textField.enabled=NO;
        _textField.textColor=Public_Text_Color;
        _textField.placeholder=@"请输入单项报价";
    }
    return _textField;
}

-(void)reloadUIWithChange:(BOOL)isChange
{
  _textField.enabled=NO;
_textField.textColor=Public_Text_Color;
_textField.placeholder=@"请输入单项报价";
self.titleLab.text=@"单项报价";
self.descLab.text=@"元/天";
    [self tipsLab];
[self textField];
    if (!isChange) {
        self.tipsLab.hidden = YES;
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
        }];
    }
}
@end
