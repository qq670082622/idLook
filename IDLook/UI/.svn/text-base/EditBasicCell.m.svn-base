//
//  EditBasicCell.m
//  IDLook
//
//  Created by HYH on 2018/5/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditBasicCell.h"

@interface EditBasicCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UILabel *mustLab;
@property(nonatomic,strong)UITextField *textField;

@end

@implementation EditBasicCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
//        self.contentView.layer.borderWidth=0.5;
        
        UIView *lineV= [[UIView alloc]init];
        [self.contentView addSubview:lineV];
        lineV.backgroundColor=Public_LineGray_Color;
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
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
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(UILabel*)mustLab
{
    if (!_mustLab) {
        _mustLab=[[UILabel alloc]init];
        _mustLab.font=[UIFont systemFontOfSize:10];
        _mustLab.textAlignment=NSTextAlignmentCenter;
        _mustLab.textColor=Public_Red_Color;
        _mustLab.layer.masksToBounds=YES;
        _mustLab.layer.cornerRadius=7.5;
        _mustLab.layer.borderColor=[UIColor colorWithHexString:@"#FF534C"].CGColor;
        _mustLab.layer.borderWidth=1.0;
        [self.contentView addSubview:_mustLab];
        _mustLab.text=@"必填";
        [_mustLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab.mas_right).offset(2);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(30, 15));
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
        _textField.font =  [UIFont systemFontOfSize:15.0];
        _textField.textColor=[UIColor colorWithHexString:@"#191919"];
        _textField.textAlignment=NSTextAlignmentRight;
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(120);
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

-(void)reloadUIWithDic:(NSDictionary *)dic withType:(PickerType)type
{
    self.titleLab.text=dic[@"title"];
    BOOL isShowArrow = [dic[@"isShowArrow"] boolValue];
    if (isShowArrow) {
        self.arrow.hidden=NO;
        self.textField.enabled=NO;
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-35);
        }];
        
    }
    else
    {
        self.arrow.hidden=YES;
        self.textField.enabled=YES;
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-20);
        }];
    }
    
    if (type<=PickerTypeShoeSize)
    {
        NSString *str;
        if (type==PickerTypeShoeSize) {
            str=@"码";
        }
        else if (type==PickerTypeWeight)
        {
            str=@"kg";
        }
        else
        {
            str=@"cm";
        }
        
        if ([dic[@"content"] integerValue]==0) {
            self.textField.text=@"";
        }
        else
        {
            self.textField.text=[NSString stringWithFormat:@"%@%@",dic[@"content"],str];
        }
    }
    else
    {
        if ([dic[@"content"] length]==0) {
            self.textField.text=@"";
        }
        else
        {
            if (type==PickerTypeGrade)
            {
                self.textField.text=[NSString stringWithFormat:@"%@",dic[@"content"]];
            }
            else
            {
                self.textField.text=[NSString stringWithFormat:@"%@",dic[@"content"]];
            }
        }
    }
    
    self.textField.placeholder = dic[@"placeholder"];

    BOOL isMustInput = [dic[@"IsMustInput"] boolValue];
    if (isMustInput) {
        self.mustLab.hidden=NO;
    }
    else
    {
        self.mustLab.hidden=YES;
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
}

-(void)textFieldDidBeginEdit:(UITextField*)textField
{
}


@end
