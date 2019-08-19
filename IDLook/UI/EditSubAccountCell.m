//
//  EditSubAccountCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "EditSubAccountCell.h"

@interface EditSubAccountCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)CustomTextField *textField;
@property(nonatomic,strong)UIButton *eyeBtn;
@end

@implementation EditSubAccountCell

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.numberOfLines=0;
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_lessThanOrEqualTo(self.textField.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(CustomTextField*)textField
{
    if (!_textField) {
        _textField=[[CustomTextField alloc]init];
        [self.contentView addSubview:_textField];
        _textField.font =  [UIFont systemFontOfSize:16];
        _textField.textColor=Public_Text_Color;
        _textField.textAlignment=NSTextAlignmentLeft;
        _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(110);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-37);
            make.height.mas_equalTo(48);
        }];
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

-(UIButton*)eyeBtn
{
    if (!_eyeBtn) {
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeBtn setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
        [_eyeBtn setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
        _eyeBtn.selected=YES;
        [self.contentView addSubview:_eyeBtn];
        [_eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-25);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [_eyeBtn addTarget:self action:@selector(isShowPassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyeBtn;
}


-(void)isShowPassword:(UIButton*)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.textField.secureTextEntry=YES;
    }
    else
    {
        self.textField.secureTextEntry=NO;
    }
}

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    self.titleLab.text = dic[@"title"];
    self.textField.placeholder=dic[@"placeholder"];
    self.textField.text = dic[@"content"];
    EditSubCellType type  = [dic[@"type"]integerValue];
    if (type==EditSubCellTypePhone) {
        self.textField.keyboardType=UIKeyboardTypePhonePad;
        self.textField.textColor=Public_DetailTextLabelColor;
        self.textField.enabled=NO;
    }
    else if (type==EditSubCellTypePassword)
    {
        self.textField.isNormal=YES;
        self.textField.isPasswordType=YES;
        [self.textField clearButtonRectForBounds:_textField.bounds];
        self.textField.secureTextEntry=YES;
        self.textField.keyboardType=UIKeyboardTypeASCIICapable;
        [self eyeBtn];
        self.textField.textColor=Public_Text_Color;
        self.textField.enabled=YES;
    }
    else
    {
        self.textField.keyboardType=UIKeyboardTypeDefault;
        self.textField.textColor=Public_Text_Color;
        self.textField.enabled=YES;
    }
    
}



- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.textFieldChangeBlock) {
        self.textFieldChangeBlock(textField.text);
    }
}

@end
