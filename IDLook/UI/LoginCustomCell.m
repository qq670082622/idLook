//
//  LoginCustomCell.m
//  IDLook
//
//  Created by HYH on 2018/4/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "LoginCustomCell.h"

@interface LoginCustomCell ()
@property(nonatomic,strong)UIImageView *leftView;
@property(nonatomic,strong)UIButton *eyeBtn;
@end

@implementation LoginCustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *lineV=[[UIView alloc]init];
        lineV.backgroundColor=Public_LineGray_Color;
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.mas_equalTo(self.contentView).offset(30);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

-(UIImageView*)leftView
{
    if (!_leftView) {
        _leftView=[[UIImageView alloc]init];
        [self.contentView addSubview:_leftView];
        _leftView.contentMode=UIViewContentModeScaleAspectFill;
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(30);
        }];
        
        UIView *rightV=[[UIView alloc]init];
        rightV.backgroundColor=[UIColor colorWithHexString:@"#FFC4C8"];
        [self.contentView addSubview:rightV];
        [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(54);
            make.size.mas_equalTo(CGSizeMake(1.5, 17));
        }];
    }
    return _leftView;
}

-(CustomTextField*)textField
{
    if (!_textField) {
        _textField=[[CustomTextField alloc]init];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(70);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-30);
            make.height.mas_equalTo(50);
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

-(void)reloadUIWithModel:(LoginCellStrutM *)model
{

    self.leftView.image=[UIImage imageNamed:model.imageN];
    self.textField.placeholder=model.placeholder;
    
    self.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    [self setTextFielModel:model.cellType];
    
    self.textField.tag=model.cellType;
}

-(void)setTextFieldText:(NSString *)text
{
    self.textField.text=text;
}

-(void)setTextFielModel:(LRCellType)type
{
    if (type==LRCellTypePhone) {
        self.textField.keyboardType=UIKeyboardTypeNumberPad;//UIKeyboardTypeNamePhonePad;
    }
    else if (type==LRCellTypePassword)
    {
        self.textField.isNormal=YES;
        [self.textField clearButtonRectForBounds:_textField.bounds];

        self.textField.secureTextEntry=YES;

        self.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        [self eyeBtn];

    }
}

- (void)textFieldDidChange:(CustomTextField *)textField
{
//    if(textField.tag==LoginMainCellAAccount)
//    {
//        if (textField.text.length > 11)
//        {
//            textField.text = [textField.text substringToIndex:11];
//        }
//    }
//    else if(textField.tag==LoginMainCellAPassWord)
//    {
//        if (textField.text.length > 12)
//        {
//            textField.text = [textField.text substringToIndex:12];
//        }
//    }
    self.textFDidChanged(textField);
}

@end
