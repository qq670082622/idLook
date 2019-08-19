//
//  AuditNoticeCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditNoticeCellA.h"

@interface AuditNoticeCellA ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIImageView *arrow;    //
@property(nonatomic,strong)CustomTextField *textField;
@end


@implementation AuditNoticeCellA

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

-(CustomTextField*)textField
{
    if (!_textField) {
        _textField=[[CustomTextField alloc]init];
        [self.contentView addSubview:_textField];
        _textField.font =  [UIFont systemFontOfSize:15];
        _textField.textColor=Public_Text_Color;
        _textField.textAlignment=NSTextAlignmentLeft;
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(120);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-30);
            make.height.mas_equalTo(48);
        }];
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
        
    }
    return _textField;
}

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    self.titleLab.text=dic[@"title"];
    [self lineV];
    [self arrow];
    
    self.textField.text=dic[@"content"];
    self.textField.placeholder=dic[@"placeholder"];
    
    NSInteger type = [dic[@"type"]integerValue];
    if (type==0) {
        self.textField.enabled=NO;
        self.arrow.hidden=NO;
    }
    else
    {
        self.textField.enabled=YES;
        self.arrow.hidden=YES;
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.textFieldChangeBlock) {
        self.textFieldChangeBlock(textField.text);
    }
}

@end
