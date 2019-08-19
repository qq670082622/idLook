//
//  UploadWorksCellA.m
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadWorksCellA.h"

@interface UploadWorksCellA ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@end

@implementation UploadWorksCellA

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
        _titleLab.font=[UIFont systemFontOfSize:16.0];
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
        _textField.font=[UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(120);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(50);
        }];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
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


-(void)reloadUIWithDic:(NSDictionary *)dic
{
    
    self.titleLab.text=dic[@"title"];
    self.textField.placeholder=dic[@"placeholder"];
    
    BOOL isEdit = [dic [@"isEdit"] boolValue];
    if (isEdit==YES) {
        self.textField.enabled=YES;
        self.arrow.hidden=YES;
    }
    else
    {
        self.arrow.hidden=NO;
        self.textField.enabled=NO;
    }
    
    UIFont * font = [UIFont systemFontOfSize:16.0];
    [self.textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    UIColor * color = [UIColor colorWithHexString:@"#BCBCBC"];
    [self.textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
    self.textField.text=dic[@"content"];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    self.textFieldChangeBlock(textField.text);
}

@end
