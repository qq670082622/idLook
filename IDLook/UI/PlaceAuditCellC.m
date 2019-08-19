//
//  PlaceAuditCellC.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceAuditCellC.h"

@interface PlaceAuditCellC ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIImageView *auth;

@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong) UILabel *weight;  //身高体重
@property(nonatomic,strong) UIButton *reginBtn;  //所在地
@property(nonatomic,strong)UILabel *occupationLab; //职业
@end

@implementation PlaceAuditCellC

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.cornerRadius=30;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds=YES;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView).offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    }
    return _icon;
}

-(UIImageView*)auth
{
    if (!_auth) {
        _auth=[[UIImageView alloc]init];
        [self.contentView addSubview:_auth];
        _auth.image=[UIImage imageNamed:@"home_auth"];
        _auth.contentMode=UIViewContentModeScaleAspectFill;
        [_auth mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.icon).offset(0);
            make.bottom.mas_equalTo(self.icon).offset(0);
        }];
    }
    return _auth;
}

-(UILabel*)name
{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont systemFontOfSize:17];
        _name.textColor=Public_Text_Color;
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.top.mas_equalTo(self.icon).offset(7);
        }];
    }
    return _name;
}

-(UILabel*)weight
{
    if (!_weight) {
        _weight=[[UILabel alloc]init];
        _weight.font=[UIFont systemFontOfSize:12.0];
        _weight.textColor=[UIColor colorWithHexString:@"#CCCCCC"];
        [self.contentView addSubview:_weight];
        [_weight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.bottom.mas_equalTo(self.icon).offset(-7);
        }];
    }
    return _weight;
}

-(UIButton*)reginBtn
{
    if (!_reginBtn) {
        _reginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_reginBtn];
        [_reginBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
        _reginBtn.titleLabel.font=[UIFont systemFontOfSize:11.0];
        [_reginBtn setImage:[UIImage imageNamed:@"home_postion_gray"] forState:UIControlStateNormal];
        [_reginBtn setImage:[UIImage imageNamed:@"home_postion_gray"] forState:UIControlStateHighlighted];
        [_reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.weight.mas_right).offset(10);
            make.bottom.mas_equalTo(self.icon).offset(-7);
        }];
        _reginBtn.enabled=NO;
        //粗体
        if (IsBoldSize()) {
            _reginBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 7);
        }
    }
    return _reginBtn;
}

-(UILabel*)occupationLab
{
    if (!_occupationLab) {
        _occupationLab=[[UILabel alloc]init];
        [self.contentView addSubview:_occupationLab];
        _occupationLab.layer.masksToBounds=YES;
        _occupationLab.layer.cornerRadius=9.0;
        _occupationLab.textAlignment=NSTextAlignmentCenter;
        _occupationLab.backgroundColor=[[UIColor colorWithHexString:@"#FF2C54"]colorWithAlphaComponent:0.1];
        _occupationLab.textColor =[UIColor colorWithHexString:@"#FF2C54"];
        _occupationLab.font=[UIFont systemFontOfSize:11.0];
        [_occupationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.name.mas_right).offset(5);
            make.centerY.mas_equalTo(self.name);
            make.size.mas_equalTo(CGSizeMake(70, 18));
        }];
    }
    return _occupationLab;
}

-(void)reloadUIWithInfo:(UserInfoM *)info
{
    [self.icon sd_setImageWithUrlStr:info.head placeholderImage:[UIImage imageNamed:@"default_home"]];
    [self auth];
    
    self.weight.text=[NSString stringWithFormat:@"%ldcm·%ldkg ",info.height,info.weight];
    self.reginBtn.hidden=info.region.length>0?NO:YES;
    [self.reginBtn setTitle:info.region forState:UIControlStateNormal];
    
    self.occupationLab.hidden=info.mastery>0?NO:YES;
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"masteryType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if (info.mastery == [dic[@"attrid"] integerValue]) {
            self.occupationLab.text = dic[@"attrname"];
        }
    }
    
    
    NSString *sex = @"";
    if (info.sex==1) {
        sex=@"/男";
    }
    else if (info.sex==2)
    {
        sex=@"/女";
    }
    else
    {
        sex=@"  ";
    }
    
    NSString *str=[NSString stringWithFormat:@"%@%@",info.nick.length>0?info.nick:info.name,sex];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:11.0]} range:NSMakeRange(str.length-2,2)];
    self.name.attributedText=attStr;
}

@end
