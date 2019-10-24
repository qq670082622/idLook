//
//  AddCardCell.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddCardCell.h"

@interface AddCardCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;

@end

@implementation AddCardCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *lineV= [[UIView alloc]init];
        [self.contentView addSubview:lineV];
        lineV.backgroundColor=Public_LineGray_Color;
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

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

-(UITextField*)textField
{
    if (!_textField) {
        _textField=[[UITextField alloc]init];
        [self.contentView addSubview:_textField];
        _textField.font=[UIFont systemFontOfSize:15.0];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(120);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-30);
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


-(void)reloadUIWithDic:(NSDictionary *)dic
{
    
    self.titleLab.text=dic[@"title"];
    self.textField.placeholder=dic[@"placeholder"];
    
    UIFont * font = [UIFont systemFontOfSize:15.0];
  //  [self.textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    UIColor * color = [UIColor colorWithHexString:@"#BCBCBC"];
  //  [self.textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    NSMutableAttributedString *fontString = [[NSMutableAttributedString alloc] initWithString:dic[@"content"] attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
    [_textField setAttributedText:fontString];
   // self.textField.text=dic[@"content"];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.textFielChangeBlock) {
        self.textFielChangeBlock(textField.text);
    }
}

-(void)textFieldDidBeginEdit:(UITextField*)textField
{
    
}

@end
