//
//  AuthCellA.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthCellA.h"

@interface AuthCellA ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UITextField *textField;

@end

@implementation AuthCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:14.0];
        _titleLab.textColor=Public_Text_Color;
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
        _textField.font=[UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(120);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.arrow).offset(-20);
            make.height.mas_equalTo(50);
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

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-30);
        }];
    }
    return _arrow;
}


-(void)reloadUIWithModel:(AuthStructModel *)model
{

    self.titleLab.text=model.title;
    self.textField.placeholder=model.placeholder;
    
    if (model.cellType==AuthCellTypeArrow) {
        self.arrow.hidden=NO;
        self.textField.enabled=NO;
    }
    else
    {

        self.textField.enabled=YES;
        self.arrow.hidden=YES;
    }
    
    UIFont * font = [UIFont systemFontOfSize:13.0];
    [self.textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    UIColor * color = [UIColor colorWithHexString:@"#CCCCCC"];
    [self.textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
    self.textField.text=model.content;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.textFielChangeBlock) {
        self.textFielChangeBlock(textField.text);
    }
}

-(void)textFieldDidBeginEdit:(UITextField*)textField
{
    self.BeginEdit();
}

@end
