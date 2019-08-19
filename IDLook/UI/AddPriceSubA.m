//
//  AddPriceSubA.m
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddPriceSubA.h"

@interface AddPriceSubA ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@end

@implementation AddPriceSubA

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.layer.borderColor=[UIColor colorWithHexString:@"#F7F7F7"].CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _titleLab;
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
            make.right.mas_equalTo(self).offset(-32);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.titleLab.mas_right).offset(15);
        }];
        _textField.enabled=NO;
        _textField.textColor=Public_Text_Color;
        _textField.placeholder=@"请选择广告类别";
    }
    return _textField;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-15);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _arrow;
}

-(void)reloadUIWithType:(NSInteger)type withTtile:(NSString *)title
{
    self.titleLab.text=@"广告类别";
    [self textField];
    if (type==0) {//新增
        self.arrow.image=[UIImage imageNamed:@"center_arror_icon"];
    }
    else//修改
    {
        self.arrow.image=[UIImage imageNamed:@""];
        self.textField.text=title;
    }
}

@end
