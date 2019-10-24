//
//  FeedbackCellB.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "FeedbackCellB.h"

@interface FeedbackCellB ()
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation FeedbackCellB

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:16.0];
        _titleLab.text=@"联系方式";
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
        _textField.placeholder=@"请输入您的联系方式";
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(123);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(50);
        }];
        UIFont * font = [UIFont systemFontOfSize:13.0];
       // [self.textField setValue:font forKeyPath:@"_placeholderLabel.font"];
        
        UIColor * color = [UIColor colorWithHexString:@"#BCBCBC"];
       // [self.textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *fontString = [[NSMutableAttributedString alloc] initWithString:_textField.text attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
        [_textField setAttributedText:fontString];
    }
    return _textField;
}

-(void)reloadUI
{
    [self titleLab];
    [self textField];
}

@end
