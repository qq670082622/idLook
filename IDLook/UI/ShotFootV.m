/*
 @header  ShotFootV.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/22
 @description
 
 */

#import "ShotFootV.h"

@implementation ShotFootV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    
    UIView *bg=[[UIView alloc]init];
    bg.userInteractionEnabled=YES;
    [self addSubview:bg];
    bg.backgroundColor=[UIColor whiteColor];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(10);
        make.height.mas_equalTo(0);
    }];
    bg.hidden=YES;
    
    UIImageView *icon=[[UIImageView alloc]init];
    [bg addSubview:icon];
    icon.image=[UIImage imageNamed:@"icon_ upgrade"];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bg);
        make.left.mas_equalTo(bg).offset(15);
    }];
    
    MLLabel *desLab = [[MLLabel alloc] init];
    desLab.font = [UIFont systemFontOfSize:12];
    desLab.lineSpacing=5.0;
    desLab.textColor = Public_Text_Color;
    desLab.text=@"升级为企业买家便可获得拍摄完成后10个工作日内支付订单总金额的特权！";
    desLab.numberOfLines=0;
    [bg addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).offset(10);
        make.right.mas_equalTo(bg).offset(-100);
        make.centerY.mas_equalTo(bg);
    }];
    
    UIButton *upgradeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [bg addSubview:upgradeBtn];
    upgradeBtn.layer.cornerRadius=15.0;
    upgradeBtn.layer.masksToBounds=YES;
    upgradeBtn.layer.borderColor=[UIColor colorWithHexString:@"#49B4FF"].CGColor;
    upgradeBtn.layer.borderWidth=1.0;
    [upgradeBtn setTitle:@"立即升级" forState:UIControlStateNormal];
    [upgradeBtn setTitleColor:[UIColor colorWithHexString:@"#49B4FF"] forState:UIControlStateNormal];
    upgradeBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [upgradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bg);
        make.right.mas_equalTo(bg).offset(-15);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    [upgradeBtn addTarget:self action:@selector(upgradeAction) forControlEvents:UIControlEventTouchUpInside];
    

    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:12];
    lab.textColor = Public_DetailTextLabelColor;
    lab.text=@"售前咨询电话：";
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(34);
        make.bottom.mas_equalTo(self).offset(-12);
    }];
    
    UIButton *phone = [UIButton buttonWithType:UIButtonTypeCustom];
    [phone setTitle:@"400 833 6969" forState:UIControlStateNormal];
    [phone setTitleColor:[UIColor colorWithHexString:@"#47AEFF"] forState:UIControlStateNormal];
    phone.titleLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right).offset(5);
        make.centerY.mas_equalTo(lab).offset(0);
    }];
    [phone addTarget:self action:@selector(takePhone) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *promtV=[[UIImageView alloc]init];
    [self addSubview:promtV];
    promtV.contentMode=UIViewContentModeScaleAspectFill;
    promtV.image=[UIImage imageNamed:@"order_promt"];
    [promtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-35);
        make.left.mas_equalTo(self).offset(17);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.font = [UIFont systemFontOfSize:12];
    lab2.textColor = Public_DetailTextLabelColor;
    lab2.text=@"点击“提交订单”表示您已阅读并同意";
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(34);
        make.centerY.mas_equalTo(promtV);
    }];
    
    UIButton *protolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protolBtn setTitle:@"《代收代付条款》" forState:UIControlStateNormal];
    [protolBtn setTitleColor:[UIColor colorWithHexString:@"#47AEFF"] forState:UIControlStateNormal];
    protolBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:protolBtn];
    [protolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab2.mas_right).offset(2);
        make.centerY.mas_equalTo(lab2).offset(0);
    }];
    [protolBtn addTarget:self action:@selector(protolAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([UserInfoManager getUserSubType]==UserSubTypePurPersonal)
    {
        [bg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(10);
            make.height.mas_equalTo(65);
        }];
        bg.hidden=NO;
    }
    
}

-(void)takePhone
{
    if (self.takePhoneBlock) {
        self.takePhoneBlock();
    }
}

-(void)upgradeAction
{
    if (self.upgradeBlock) {
        self.upgradeBlock();
    }
}

-(void)protolAction
{
    if (self.protocolBlock) {
        self.protocolBlock();
    }
}

@end
