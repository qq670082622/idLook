//
//  ForwardCellA.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ForwardCellA.h"

@interface ForwardCellA ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *cashLab;
@property(nonatomic,strong)UILabel *rmbLab;
@property(nonatomic,strong)UILabel *descLab;

@property(nonatomic,strong)UIButton *allforwardBtn;

@property(nonatomic,assign)CGFloat total;

@end

@implementation ForwardCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *lineV= [[UIView alloc]init];
        [self.contentView addSubview:lineV];
        lineV.backgroundColor=Public_LineGray_Color;
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-40);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

-(UILabel*)cashLab
{
    if (!_cashLab) {
        _cashLab = [[UILabel alloc]init];
        _cashLab.textColor=Public_Text_Color;
        _cashLab.font=[UIFont boldSystemFontOfSize:15.0];
        [self.contentView addSubview:_cashLab];
        [_cashLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(10);
        }];
        _cashLab.text=@"提现金额";
    }
    return _cashLab;
}

-(UILabel*)rmbLab
{
    if (!_rmbLab) {
        _rmbLab = [[UILabel alloc]init];
        _rmbLab.textColor=Public_Text_Color;
        _rmbLab.font=[UIFont systemFontOfSize:32];
        [self.contentView addSubview:_rmbLab];
        [_rmbLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.cashLab.mas_bottom).offset(20);
        }];
        _rmbLab.text=@"¥";
    }
    return _rmbLab;
}

-(CustomTextField*)textField
{
    if (!_textField) {
        _textField=[[CustomTextField alloc]init];
        _textField.isNumber=YES;
        _textField.delegate=self;
        _textField.font=[UIFont systemFontOfSize:20];
        _textField.keyboardType=UIKeyboardTypeNumberPad;
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(44);
            make.centerY.mas_equalTo(self.rmbLab);
            make.right.mas_equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(50);
        }];
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

-(UILabel*)descLab
{
    if (!_descLab) {
        _descLab = [[UILabel alloc]init];
        _descLab.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
        _descLab.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_descLab];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
        }];
    }
    return _descLab;
}

-(UIButton*)allforwardBtn
{
    if (!_allforwardBtn) {
        _allforwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_allforwardBtn];
        [_allforwardBtn setTitle:@"全部提现" forState:UIControlStateNormal];
        [_allforwardBtn setTitleColor:[UIColor colorWithHexString:@"#47AEFF"] forState:UIControlStateNormal];
        _allforwardBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_allforwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.descLab);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.size.mas_equalTo(CGSizeMake(65, 20));
        }];
        [_allforwardBtn addTarget:self action:@selector(allForwardAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allforwardBtn;
}

-(void)reloadUIWithTotal:(CGFloat)total
{
    self.total=total;
    [self cashLab];
    [self textField];
//    [self.textField becomeFirstResponder];
    [self rmbLab];
    [self allforwardBtn];
    self.descLab.text=[NSString stringWithFormat:@"可提现金额%.2f元",total];
}

-(void)allForwardAction
{
    self.textField.text = [NSString stringWithFormat:@"%.2f",self.total];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text floatValue]>self.total) {
        self.descLab.text=@"金额已超过可提现金额";
        self.descLab.textColor=Public_Red_Color;
    }
    else
    {
        self.descLab.text=[NSString stringWithFormat:@"可提现金额%.2f元",self.total];
        self.descLab.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
    }
}

@end
