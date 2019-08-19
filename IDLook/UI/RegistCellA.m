//
//  RegistCellA.m
//  IDLook
//
//  Created by HYH on 2018/8/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RegistCellA.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface RegistCellA ()
@property(nonatomic,strong)UIImageView *bg;
@property(nonatomic,strong)UIButton *uploadBGBtn;
@property(nonatomic,strong)UIImageView *uploadHeadV;
@property(nonatomic,strong)UILabel *stateLab;
@end

@implementation RegistCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.layer.borderColor=Public_LineGray_Color.CGColor;
//        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UIImageView*)bg
{
    if (!_bg) {
        _bg=[[UIImageView alloc]init];
        _bg.layer.masksToBounds=YES;
        _bg.layer.cornerRadius=4;
        _bg.backgroundColor=Public_Background_Color;
        _bg.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_bg];
        [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _bg;
}

-(UIImageView*)uploadHeadV
{
    if (!_uploadHeadV) {
        _uploadHeadV = [[UIImageView alloc]init];
        [self.contentView addSubview:_uploadHeadV];
        _uploadHeadV.userInteractionEnabled=YES;
        _uploadHeadV.layer.masksToBounds=YES;
        _uploadHeadV.layer.cornerRadius=38;
        _uploadHeadV.clipsToBounds=YES;
        _uploadHeadV.image = [UIImage imageNamed:@"upload_head"];
        _uploadHeadV.contentMode=UIViewContentModeScaleAspectFill;
        [_uploadHeadV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(70);
            make.size.mas_equalTo(CGSizeMake(76, 76));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadHeadAction)];
        [_uploadHeadV addGestureRecognizer:tap];
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.font = [UIFont systemFontOfSize:12.0];
        titleLab.textColor=[UIColor whiteColor];
        titleLab.textAlignment=NSTextAlignmentCenter;
        [_uploadHeadV addSubview:titleLab];
        titleLab.tag=1000;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_uploadHeadV);
            make.bottom.mas_equalTo(_uploadHeadV).offset(-17);
        }];
    }
    return _uploadHeadV;
}

-(UILabel*)stateLab
{
    if (!_stateLab) {
        _stateLab= [[UILabel alloc]init];
        _stateLab.font=[UIFont systemFontOfSize:12.0];
        _stateLab.textColor=[UIColor whiteColor];
        _stateLab.text=@"审核中";
        _stateLab.textAlignment=NSTextAlignmentCenter;
        _stateLab.backgroundColor=[[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.6];
        [self.uploadHeadV addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.uploadHeadV);
            make.bottom.mas_equalTo(self.uploadHeadV.mas_bottom);
            make.left.mas_equalTo(self.uploadHeadV);
            make.height.mas_equalTo(25);
        }];
    }
    return _stateLab;
}

-(UIButton*)uploadBGBtn
{
    if (!_uploadBGBtn) {
        _uploadBGBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_uploadBGBtn];
        _uploadBGBtn.layer.masksToBounds=YES;
        _uploadBGBtn.layer.cornerRadius=4.0;
        _uploadBGBtn.layer.borderColor=[UIColor colorWithHexString:@"#909090"].CGColor;
        _uploadBGBtn.layer.borderWidth=1.0;
        [_uploadBGBtn setTitle:@"编辑个人主页背景" forState:UIControlStateNormal];
        [_uploadBGBtn setTitleColor:[UIColor colorWithHexString:@"#909090"] forState:UIControlStateNormal];
        _uploadBGBtn.titleLabel.font =[UIFont systemFontOfSize:13.0];
        [_uploadBGBtn setImage:[UIImage imageNamed:@"camera_small"] forState:UIControlStateNormal];
        [_uploadBGBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-53);
            make.size.mas_equalTo(CGSizeMake(168, 30));
        }];
        _uploadBGBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 3, 0, -3);
        [_uploadBGBtn addTarget:self action:@selector(uploadBGAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uploadBGBtn;
}

-(void)reloadUIHead:(UIImage *)head withBG:(UIImage *)bg withheadUrl:(NSString *)url1 withBGUrl:(NSString *)url2 withType:(NSInteger)type isShowState:(BOOL)isShow
{
    [self bg];
    [self uploadHeadV];
    [self uploadBGBtn];
    
    UILabel *headLab = [self.uploadHeadV viewWithTag:1000];

    if (type==0) //注册用image
    {
        if (head==nil) {
            self.uploadHeadV.image = [UIImage imageNamed:@"upload_head"];
            headLab.text=@"上传头像";
        }
        else
        {
            self.uploadHeadV.image = head;
            headLab.text=@"";
        }
        self.bg.image = bg;
    }
    else  //修改用url
    {
        if (url1.length==0) {
            self.uploadHeadV.image = [UIImage imageNamed:@"upload_head"];
            headLab.text=@"编辑头像";
        }
        else
        {
            [self.uploadHeadV sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"upload_head"]];
            headLab.text=@"";
        }
        
        [self.bg sd_setImageWithUrlStr:url2];
    }

    if (isShow) {
        self.stateLab.hidden=NO;
    }
    else
    {
        self.stateLab.hidden=YES;
    }
}

//上传头像
-(void)uploadHeadAction
{
    if (self.uploadHeadBlock) {
        self.uploadHeadBlock();
    }
}

//上传背景图
-(void)uploadBGAction
{
    if (self.uploadBGBlock) {
        self.uploadBGBlock();
    }
}

@end
