//
//  ScheduleCellC.m
//  IDLook
//
//  Created by Mr Hu on 2019/5/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleCellC.h"

@interface ScheduleCellC ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *lineLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UITextField *minTextField;
@property(nonatomic,strong)UITextField *maxTextField;
@end

@implementation ScheduleCellC


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

-(UILabel*)lineLab
{
    if (!_lineLab) {
        _lineLab=[[UILabel alloc]init];
        _lineLab.font=[UIFont systemFontOfSize:15.0];
        _lineLab.text=@"—";
        _lineLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_lineLab];
        [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView).offset(35);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _lineLab;
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

-(UITextField*)minTextField
{
    if (!_minTextField) {
        _minTextField=[[UITextField alloc]init];
        _minTextField.delegate=self;
        _minTextField.tag=1000;
        _minTextField.placeholder=@"开始日期";
        _minTextField.enabled=NO;
        _minTextField.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_minTextField];
        [_minTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(120);
            make.height.mas_equalTo(48);
        }];
        UIFont * font = [UIFont systemFontOfSize:16];
      //  [_minTextField setValue:font forKeyPath:@"_placeholderLabel.font"];
        
        UIColor * color = [UIColor colorWithHexString:@"#BCBCBC"];
       // [_minTextField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *fontString = [[NSMutableAttributedString alloc] initWithString:_minTextField.text attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
        [_minTextField setAttributedText:fontString];
    }
    return _minTextField;
}

-(UITextField*)maxTextField
{
    if (!_maxTextField) {
        _maxTextField=[[UITextField alloc]init];
        _maxTextField.delegate=self;
        _maxTextField.tag=1001;
        _maxTextField.placeholder=@"结束日期";
        _maxTextField.enabled=NO;
        _maxTextField.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_maxTextField];
        [_maxTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-45);
            make.height.mas_equalTo(48);
        }];
        UIFont * font = [UIFont systemFontOfSize:16];
      //  [_maxTextField setValue:font forKeyPath:@"_placeholderLabel.font"];
        
        UIColor * color = [UIColor colorWithHexString:@"#BCBCBC"];
       // [_maxTextField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *fontString = [[NSMutableAttributedString alloc] initWithString:_maxTextField.text attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
        [_maxTextField setAttributedText:fontString];
    }
    return _maxTextField;
}

-(void)reloadUIWithDic:(NSDictionary*)dic;
{
    self.titleLab.text=@"拍摄日期";
    [self arrow];
    [self minTextField];
    [self maxTextField];
    self.minTextField.text=dic[@"start"];
    self.maxTextField.text=dic[@"end"];
    [self lineLab];
}

#pragma mark--UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{    
    if (self.dateSelectWithType) {
        self.dateSelectWithType(textField.tag-1000);
    }
    return NO;
}


@end
