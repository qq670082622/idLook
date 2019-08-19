//
//  AuditPOSubV.m
//  IDLook
//
//  Created by Mr Hu on 2019/7/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditPOSubV.h"

@interface AuditPOSubV ()
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)MLLabel *titleLab;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIImageView *arrow;

@end

@implementation AuditPOSubV

-(UIView*)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor=Public_Background_Color;
        [self addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(12);
            make.right.mas_equalTo(self).offset(-12);
            make.top.mas_equalTo(self).offset(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineV;
}

-(MLLabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[MLLabel alloc]init];
        _titleLab.numberOfLines=0;
        _titleLab.userInteractionEnabled=YES;
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.lineSpacing=4;
        _titleLab.textColor=Public_DetailTextLabelColor;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(12);
            make.top.mas_equalTo(self.lineV).offset(14);
            make.width.mas_equalTo(65);
        }];
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        //        [_titleLab addGestureRecognizer:tap];
    }
    return _titleLab;
}

-(UITextField*)textField
{
    if (!_textField) {
        _textField=[[UITextField alloc]init];
        _textField.font=[UIFont systemFontOfSize:15];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(108);
            make.centerY.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self.arrow).offset(-20);
            make.height.mas_equalTo(50);
        }];
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
        [_textField addTarget:self action:@selector(textFieldDidBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
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
            make.centerY.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self).offset(-15);
        }];
    }
    return _arrow;
}

-(void)reloadUIWithModel:(OrderStructM *)model
{
    self.titleLab.text =model.title;
    self.textField.placeholder = model.placeholder;
    self.textField.text = model.content;
    
    self.arrow.hidden=model.isChoose;
    
    self.textField.enabled=model.isEdit;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    self.textFieldChangeBlock(textField.text);
}

-(void)textFieldDidBeginEdit:(UITextField*)textField
{
    self.BeginEdit();
}

@end
