/*
 @header  LoginCodeCell.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/15
 @description
 
 */

#import "LoginCodeCell.h"
#import "LoginCustomCell.h"

@interface LoginCodeCell ()

@property(nonatomic,strong)UIImageView *leftView;


@end

@implementation LoginCodeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *lineV=[[UIView alloc]init];
        lineV.backgroundColor=Public_LineGray_Color;
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.mas_equalTo(self.contentView).offset(30);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
        
    }
    return self;
}

-(UIImageView*)leftView
{
    if (!_leftView) {
        _leftView=[[UIImageView alloc]init];
        [self.contentView addSubview:_leftView];
        _leftView.contentMode=UIViewContentModeScaleAspectFill;
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(25);
            make.left.mas_equalTo(self.contentView).offset(30);
        }];
        
        UIView *rightV=[[UIView alloc]init];
        rightV.backgroundColor=[UIColor colorWithHexString:@"#FFC4C8"];
        [self.contentView addSubview:rightV];
        [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_leftView);
            make.left.mas_equalTo(self.contentView).offset(54);
            make.size.mas_equalTo(CGSizeMake(1.5, 17));
        }];
    }
    return _leftView;
}

-(CustomTextField*)textField
{
    if (!_textField) {
        _textField=[[CustomTextField alloc]init];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(70);
            make.centerY.mas_equalTo(self.leftView);
            make.right.mas_equalTo(self.contentView).offset(-30);
            make.height.mas_equalTo(50);
        }];
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}


-(VerffyCodeBtn*)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [[VerffyCodeBtn alloc]init];
        [_codeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_codeBtn];
        [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.leftView);
            make.right.equalTo(self.contentView.mas_right).offset(-30);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        WeakSelf(self);
        _codeBtn.voiceCodeRefreshUI = ^{
            if (weakself.voiceCodeBlock) {
                weakself.voiceCodeBlock();
            }
        };
    }
    return _codeBtn;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:12.0];
        _desc.textColor=[UIColor colorWithHexString:@"#999999"];
        _desc.text=@"没收到验证码？请尝试获取";
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView).offset(-20);
            make.left.mas_equalTo(self.contentView).offset(70);
        }];
    }
    return _desc;
}

-(UIButton*)voiceBtn
{
    if (!_voiceBtn) {
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceBtn setTitle:@"语音验证码" forState:UIControlStateNormal];
        _voiceBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [_voiceBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
        [self.contentView addSubview:_voiceBtn];
        [_voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.desc);
            make.left.mas_equalTo(self.desc.mas_right).offset(0);
        }];
        [_voiceBtn addTarget:self action:@selector(voiceCodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceBtn;
}

-(void)getVerificationCode
{
    self.getVerificationCodeBlock();
}


-(void)reloadUIWithModel:(LoginCellStrutM*)model
{
    self.count=30;

    self.leftView.image=[UIImage imageNamed:model.imageN];
    self.textField.placeholder=model.placeholder;
    
    self.codeBtn.hidden=NO;
    self.textField.clearButtonMode=UITextFieldViewModeNever;
    
    self.textField.keyboardType=UIKeyboardTypeNumberPad;
    
    self.textField.tag=model.cellType;
    if (model.isShowVoiceCode) {
        self.desc.hidden=NO;
        self.voiceBtn.hidden=NO;
    }
    else
    {
        self.desc.hidden=YES;
        self.voiceBtn.hidden=YES;
    }

}

-(void)setTextFieldText:(NSString *)text
{
    self.textField.text=text;
}

- (void)textFieldDidChange:(CustomTextField *)textField
{
    self.textFDidChanged(textField);
}

-(void)voiceCodeAction
{
    if (self.count==30) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
        self.getVoiceCodeBlokc(YES);
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%ld秒后再次发送语音验证码",self.count]];
    }
}

- (void)timeDown
{
    if (self.count != 1){
        self.count -=1;
    }
    else {
        [self.timer invalidate];
        self.count=30;
    }
}

@end
