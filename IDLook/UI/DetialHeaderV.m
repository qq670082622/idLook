//
//  DetialHeaderV.m
//  IDLook
//
//  Created by HYH on 2018/5/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "DetialHeaderV.h"

@interface DetialHeaderV ()
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *EnTitle;
@end

@implementation DetialHeaderV

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(UILabel*)title
{
    if (!_title) {
        
        _title=[[UILabel alloc]init];
        [self.contentView addSubview:_title];
        _title.font=[UIFont boldSystemFontOfSize:15];
        _title.textColor=Public_Text_Color;
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(30);
            make.centerX.mas_equalTo(self.contentView);
        }];
        
        UIImageView *leftV = [[UIImageView alloc]init];
        [self.contentView addSubview:leftV];
        leftV.image=[UIImage imageNamed:@"u_detial_line"];
        leftV.transform = CGAffineTransformMakeRotation(-M_PI);
        [leftV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_title.mas_left).offset(-10);
            make.centerY.mas_equalTo(_title);
        }];
        
        UIImageView *rightV = [[UIImageView alloc]init];
        [self.contentView addSubview:rightV];
        rightV.image=[UIImage imageNamed:@"u_detial_line"];
        [rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_title.mas_right).offset(10);
            make.centerY.mas_equalTo(_title);
        }];
    }
    return _title;
}

-(UILabel*)EnTitle
{
    if (!_EnTitle) {
        
        _EnTitle=[[UILabel alloc]init];
        [self.contentView addSubview:_EnTitle];
        _EnTitle.font=[UIFont boldSystemFontOfSize:6.0];
        _EnTitle.textColor=[UIColor colorWithHexString:@"#999999"];
        [_EnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.title.mas_bottom).offset(1.5);
            make.centerX.mas_equalTo(self.title);
        }];
    }
    return _EnTitle;
}

-(void)reloadUIWithType:(UserInfoCellDType)type
{
    NSDictionary *dic = [self getTitleWithType:type];
    self.title.text=dic[@"chinese"];
    self.EnTitle.text = dic[@"english"];
}

-(NSDictionary*)getTitleWithType:(UserInfoCellDType)type
{
    NSDictionary *dic;
    switch (type) {
        case UserInfoCellDTypeCertificate:
            dic=@{@"chinese":@"合作授权书",@"english":@"Letter of cooperation"};
            break;
        case UserInfoCellDTypeModelCard:
            dic=@{@"chinese":@"形象展示",@"english":@"Image display"};
            break;
        case UserInfoCellDTypeBasicinfo:
            dic=@{@"chinese":@"基本资料",@"english":@"Basic information"};
            break;
        case UserInfoCellDTypeSchool:
            dic=@{@"chinese":@"专业信息",@"english":@"Graduate institutions"};
            break;
        case UserInfoCellDTypeBrief:
            dic=@{@"chinese":@" 简介 ",@"english":@"Brief introduction"};
            break;
        case UserInfoCellDTypeWorks:
            dic=@{@"chinese":@"代表作品",@"english":@"Representative works"};
            break;
        default:
            break;
    }
    return dic;
}

@end
