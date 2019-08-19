/*
 @header  ShotStepCellD.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/27
 @description
      
 */

#import "ShotStepCellD.h"

@interface ShotStepCellD ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)OrderStructM *model;
@end

@implementation ShotStepCellD

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
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=[UIColor colorWithHexString:@"#999999"];
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
        _textField.font=[UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(120);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(50);
        }];
        _textField.keyboardType=UIKeyboardTypeNumberPad;
        _textField.textColor=[UIColor colorWithHexString:@"CCCCCC"];
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
        [_textField addTarget:self action:@selector(textFieldDidBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
    }
    return _textField;
}


-(void)reloadUIWithModel:(OrderStructM *)model
{
    self.model=model;
    self.titleLab.text=model.title;
    self.textField.placeholder=model.placeholder;
    self.textField.text=model.content;
    
    if (model.isEdit) {
        self.textField.enabled=YES;
    }
    else
    {
        self.textField.enabled=NO;
    }
    
    UIFont * font = [UIFont systemFontOfSize:13.0];
    [self.textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    UIColor * color = [UIColor colorWithHexString:@"#CCCCCC"];
    [self.textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    self.model.content=textField.text;
    self.textFieldChangeBlock(textField.text);
}

-(void)textFieldDidBeginEdit:(UITextField*)textField
{
    self.BeginEdit();
}


@end
