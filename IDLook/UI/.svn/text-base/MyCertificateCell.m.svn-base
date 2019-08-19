//
//  MyCertificateCell.m
//  IDLook
//
//  Created by HYH on 2018/5/23.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyCertificateCell.h"

@interface MyCertificateCell ()
@property(nonatomic,strong)UIImageView *bg;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,strong)UIImageView *arrow;

@end

@implementation MyCertificateCell

-(UIImageView*)bg
{
    if (!_bg) {
        _bg=[[UIImageView alloc]init];
        [self.contentView addSubview:_bg];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _bg;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16.0];
        _titleLab.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(35);
            make.left.mas_equalTo(self.bg).offset(35);
        }];
    }
    return _titleLab;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self.bg).offset(-35);
        }];
    }
    return _arrow;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:13.0];
        _desc.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self.arrow.mas_left).offset(-10);
        }];
    }
    return _desc;
}

-(void)reloadUIWithModel:(CertificateM *)model
{
    if (model.type==0) {
        if (model.isExist) {
            self.bg.image=[UIImage imageNamed:@"certificate_bg1"];
        }
        else
        {
            self.bg.image=[UIImage imageNamed:@"certificate_bg5"];

        }
        self.titleLab.text=@"脸探肖像合作授权书";
    }
    else if (model.type==1)
    {
        if (model.isExist) {
            self.bg.image=[UIImage imageNamed:@"certificate_bg2"];
        }
        else
        {
            self.bg.image=[UIImage imageNamed:@"certificate_bg5"];
        }
        self.titleLab.text=@"微出镜照片授权书";
    }
    else if (model.type==2)
    {
        if (model.isExist) {
            self.bg.image=[UIImage imageNamed:@"certificate_bg3"];
        }
        else
        {
            self.bg.image=[UIImage imageNamed:@"certificate_bg5"];

        }
        self.titleLab.text=@"微出镜视频授权书";
    }
    else if (model.type==3)
    {
        if (model.isExist) {
            self.bg.image=[UIImage imageNamed:@"certificate_bg4"];
        }
        else
        {
            self.bg.image=[UIImage imageNamed:@"certificate_bg5"];

        }
        self.titleLab.text=@"试葩间视频授权书";
    }
    
    if (model.isExist) {
        self.arrow.image=[UIImage imageNamed:@"certificate_arrow_1"];
        self.desc.textColor=[UIColor whiteColor];
    }
    else
    {
        self.arrow.image=[UIImage imageNamed:@"certificate_arrow_2"];
        self.desc.textColor=[UIColor colorWithHexString:@"#999999"];

    }
    
    if (model.state==0) {
        self.desc.text=@"待审核";
    }
    else if (model.state==1)
    {
        self.desc.text=@"审核已通过";
    }
    else if(model.state==2)
    {
        self.desc.text=@"审核未通过";
    }
    else
    {
        self.desc.text=@"未上传";
    }
    
    
    
}

@end
