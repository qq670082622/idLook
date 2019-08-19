//
//  PlaceOrderCustomCell.m
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceOrderCustomCell.h"

@interface PlaceOrderCustomCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)OrderStructM *model;
@end

@implementation PlaceOrderCustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.userInteractionEnabled=YES;
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.width.mas_equalTo(110);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [_titleLab addGestureRecognizer:tap];
    }
    return _titleLab;
}

-(UITextField*)textField
{
    if (!_textField) {
        _textField=[[UITextField alloc]init];
        _textField.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(124);
            make.centerY.mas_equalTo(self.contentView);
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
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}


-(void)reloadUIWithModel:(OrderStructM *)model
{
    self.model=model;
    self.titleLab.text=model.title;
    self.textField.placeholder=model.placeholder;
    self.textField.text=model.content;
    
    if (model.isEdit) {
        self.textField.enabled=YES;
        self.arrow.hidden=YES;
    }
    else
    {
        self.arrow.hidden=NO;
        self.textField.enabled=NO;
    }
    
    UIFont * font = [UIFont systemFontOfSize:16];
    [self.textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    UIColor * color = [UIColor colorWithHexString:@"#BCBCBC"];
    [self.textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    self.model.content=textField.text;
}

-(void)textFieldDidBeginEdit:(UITextField*)textField
{
    self.BeginEdit();
}

-(void)hide
{
    
}

@end
