//
//  AddSubAccountCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AddSubAccountCell.h"
#import "VerffyCodeBtn.h"

@interface AddSubAccountCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)CustomTextField *textField;
@property(nonatomic,strong)UIButton *eyeBtn;
@property(nonatomic,strong)VerffyCodeBtn *codeBtn;
@property(strong,nonatomic) NSTimer *timer;
@property(assign,nonatomic) NSInteger count;
@end

@implementation AddSubAccountCell

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
        
        [_textField addTarget:self
                       action:@selector(textFieldDidBeginEdit:)
             forControlEvents:UIControlEventEditingDidBegin];
        
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

-(VerffyCodeBtn*)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [[VerffyCodeBtn alloc]init];
        [_codeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_codeBtn];
        [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        WeakSelf(self);
        _codeBtn.voiceCodeRefreshUI = ^{
         
        };
    }
    return _codeBtn;
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

//获取验证码
-(void)getVerificationCode
{
    if (self.getVerificationCodeBlock) {
        self.getVerificationCodeBlock();
    }
}

-(void)beganTimerAction
{
    [self.codeBtn timeFailBeginFrom:30];
}

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    self.titleLab.text = dic[@"title"];
    self.textField.placeholder=dic[@"placeholder"];
    self.textField.text = dic[@"content"];
    AddSubCellType type  = [dic[@"type"]integerValue];
    if (type==AddSubCellTypePhone || type==AddSubCellTypeCode) {
        self.textField.keyboardType=UIKeyboardTypePhonePad;
        if (type==AddSubCellTypeCode) {
            [self codeBtn];
        }
    }
    else if (type==AddSubCellTypePassword)
    {
        self.textField.isNormal=YES;
        self.textField.isPasswordType=YES;
        [self.textField clearButtonRectForBounds:_textField.bounds];
        self.textField.secureTextEntry=YES;
        self.textField.keyboardType=UIKeyboardTypeASCIICapable;
        [self eyeBtn];
    }
    else
    {
        self.textField.keyboardType=UIKeyboardTypeDefault;
    }
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.textFieldChangeBlock) {
        self.textFieldChangeBlock(textField.text);
    }
}

-(void)textFieldDidBeginEdit:(UITextField*)textField
{
    
}

@end
