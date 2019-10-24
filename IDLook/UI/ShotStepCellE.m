/*
 @header  ShotStepCellE.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/8
 @description
 
 */

#import "ShotStepCellE.h"

@interface ShotStepCellE ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)OrderStructM *model;
@property(nonatomic,strong)UIButton *helpBtn;
@end

@implementation ShotStepCellE

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.userInteractionEnabled=YES;
        _titleLab.font=[UIFont systemFontOfSize:14.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.width.mas_equalTo(110);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [_titleLab addGestureRecognizer:tap];
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
            make.top.mas_equalTo(self.contentView).offset(10);
            make.right.mas_equalTo(self.arrow).offset(-20);
            make.height.mas_equalTo(30);
        }];
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
        [_textField addTarget:self action:@selector(textFieldDidBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
    }
    return _textField;
}

-(UIButton*)helpBtn
{
    if (!_helpBtn) {
        _helpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_helpBtn];
        [_helpBtn setTitle:@"外籍演员1天工作时间为6小时" forState:UIControlStateNormal];
        [_helpBtn setImage:[UIImage imageNamed:@"order_ask"] forState:UIControlStateNormal];
        [_helpBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        _helpBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_helpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(120);
            make.bottom.mas_equalTo(self.contentView).offset(-13);
        }];
        _helpBtn.titleLabel.backgroundColor = _helpBtn.backgroundColor;
        _helpBtn.imageView.backgroundColor = _helpBtn.backgroundColor;
        //在使用一次titleLabel和imageView后才能正确获取titleSize
        CGSize titleSize = _helpBtn.titleLabel.bounds.size;
        CGSize imageSize = _helpBtn.imageView.bounds.size;
        CGFloat interval = 1.0;
        _helpBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        _helpBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
        
        [_helpBtn addTarget:self action:@selector(helpAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _helpBtn;
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


-(void)reloadUIWithModel:(OrderStructM *)model
{
    self.model=model;
    self.titleLab.text=model.title;
    self.textField.placeholder=model.placeholder;
    self.textField.text=model.content;
    [self helpBtn];
    
    if (model.isEdit) {
        self.textField.enabled=YES;
        self.arrow.hidden=YES;
    }
    else
    {
        self.arrow.hidden=NO;
        self.textField.enabled=NO;
    }
    
    UIFont * font = [UIFont systemFontOfSize:13.0];
  //  [self.textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    UIColor * color = [UIColor colorWithHexString:@"#CCCCCC"];
   // [self.textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    NSMutableAttributedString *fontString = [[NSMutableAttributedString alloc] initWithString:_textField.text attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
    [_textField setAttributedText:fontString];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    self.model.content=textField.text;
}

-(void)textFieldDidBeginEdit:(UITextField*)textField
{
    self.BeginEdit();
}

-(void)helpAction
{
    if (self.showDetialPopV) {
        self.showDetialPopV();
    }
}

-(void)hide
{
    
}

@end
