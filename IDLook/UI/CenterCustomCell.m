//
//  CenterCustomCell.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CenterCustomCell.h"

@interface CenterCustomCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UILabel *mustLab;
@property(nonatomic,strong)UITextField *textField;

@end

@implementation CenterCustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.contentView.layer.borderColor=Public_Red_Color.CGColor;
//        self.contentView.layer.borderWidth=0.5;
        
//        UIView *lineV= [[UIView alloc]init];
//        [self.contentView addSubview:lineV];
//        lineV.backgroundColor=Public_LineGray_Color;
//        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.contentView);
//            make.right.mas_equalTo(self.contentView);
//            make.bottom.mas_equalTo(self.contentView);
//            make.height.mas_equalTo(0.5);
//        }];
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.numberOfLines=0;
        _titleLab.font=[UIFont systemFontOfSize:16.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_lessThanOrEqualTo(self.textField.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(UILabel*)mustLab
{
    if (!_mustLab) {
        _mustLab=[[UILabel alloc]init];
        _mustLab.font=[UIFont systemFontOfSize:18.0];
        _mustLab.textColor=Public_Red_Color;
//        _mustLab.textAlignment=NSTextAlignmentCenter;
//        _mustLab.layer.masksToBounds=YES;
//        _mustLab.layer.cornerRadius=7.5;
//        _mustLab.layer.borderColor=[UIColor colorWithHexString:@"#FF534C"].CGColor;
//        _mustLab.layer.borderWidth=1.0;
        [self.contentView addSubview:_mustLab];
        _mustLab.text=@"*";
        [_mustLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset(2);
            make.centerY.mas_equalTo(self.contentView).offset(3);
        }];
    }
    return _mustLab;
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

-(UITextField*)textField
{
    if (!_textField) {
        _textField=[[UITextField alloc]init];
        [self.contentView addSubview:_textField];
        _textField.font =  [UIFont systemFontOfSize:16];
        _textField.textColor=Public_Text_Color;
        _textField.textAlignment=NSTextAlignmentLeft;
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(124);
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

-(void)reloadUIWithModel:(EditStructM *)model
{
    self.titleLab.text=model.title;
    if (model.isShowArrow) {
        self.arrow.hidden=NO;
        self.textField.enabled=NO;
    }
    else
    {
        self.arrow.hidden=YES;
        self.textField.enabled=YES;
        if (model.type==UserInfoTypeAge) {
            self.textField.enabled=NO;
        }
        else
        {
            self.textField.enabled=YES;
        }
    }
    
    if (model.IsMustInput) {
        self.mustLab.hidden=NO;
    }
    else
    {
        self.mustLab.hidden=YES;
    }

    NSString *content = [NSString stringWithFormat:@"%@",model.content];
    self.textField.text= content;
    
    self.textField.placeholder = model.placeholder;
    
    if (model.type>=UserInfoTypeHeight && model.type<=UserInfoTypeShoeSize) {
        NSString *str;
        if (model.type==UserInfoTypeShoeSize) {
            str=@"码";
        }
        else if (model.type==UserInfoTypeWeight)
        {
            str=@"kg";
        }
        else
        {
            str=@"cm";
        }
        
        if ([model.content integerValue]==0) {
            self.textField.text=@"";
        }
        else
        {
            self.textField.text=[NSString stringWithFormat:@"%@%@",model.content,str];
        }
    }
    
    if (model.type==UserInfoTypeEmail) {
        self.textField.keyboardType=UIKeyboardTypeEmailAddress;
    }
    else if (model.type==UserInfoTypePostcode || model.type==UserInfoTypeContactPhone)
    {
        self.textField.keyboardType=UIKeyboardTypePhonePad;
    }
    else
    {
        self.textField.keyboardType=UIKeyboardTypeDefault;
    }
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
