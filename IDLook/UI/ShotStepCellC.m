//
//  ShotStepCellC.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ShotStepCellC.h"
#import "DatePickPopV.h"

@interface ShotStepCellC ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *lineLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UITextField *minTextField;
@property(nonatomic,strong)UITextField *maxTextField;

@end

@implementation ShotStepCellC

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=[UIColor colorWithHexString:@"#F7F7F7"].CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
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
            make.centerX.mas_equalTo(self.contentView).offset(45);
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
        _minTextField.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_minTextField];
        [_minTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(124);
            make.height.mas_equalTo(48);
        }];
        UIFont * font = [UIFont systemFontOfSize:16];
        [_minTextField setValue:font forKeyPath:@"_placeholderLabel.font"];
        
        UIColor * color = [UIColor colorWithHexString:@"#BCBCBC"];
        [_minTextField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
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
        _maxTextField.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_maxTextField];
        [_maxTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-30);
            make.height.mas_equalTo(48);
        }];
        UIFont * font = [UIFont systemFontOfSize:16];
        [_maxTextField setValue:font forKeyPath:@"_placeholderLabel.font"];
        
        UIColor * color = [UIColor colorWithHexString:@"#BCBCBC"];
        [_maxTextField setValue:color forKeyPath:@"_placeholderLabel.textColor"];

    }
    return _maxTextField;
}

-(void)reloadUIWithModel:(OrderStructM *)model
{
    self.titleLab.text=@"拍摄日期";
    [self arrow];
    [self minTextField];
    [self maxTextField];
    self.minTextField.text=model.content;
    self.maxTextField.text=model.desc;
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
