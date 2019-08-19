//
//  AnnunciateDetialCellC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateDetialCellC.h"

@interface AnnunciateDetialCellC ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *roleLabel;  //角色
@property(nonatomic,strong)UILabel *requirTitleLabel;  //要求标题
@property(nonatomic,strong)MLLabel *requirLabel;  //要求
@property(nonatomic,strong)NSArray *myWorkFileList;
@end

@implementation AnnunciateDetialCellC

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(13);
        }];
    }
    return _titleLab;
}

-(UILabel*)roleLabel
{
    if (!_roleLabel) {
        _roleLabel=[[UILabel alloc]init];
        _roleLabel.font=[UIFont systemFontOfSize:13];
        _roleLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_roleLabel];
        [_roleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(43);
        }];
    }
    return _roleLabel;
}

-(UILabel*)requirTitleLabel
{
    if (!_requirTitleLabel) {
        _requirTitleLabel=[[UILabel alloc]init];
        _requirTitleLabel.font=[UIFont systemFontOfSize:13];
        _requirTitleLabel.textColor=Public_DetailTextLabelColor;
        [self.contentView addSubview:_requirTitleLabel];
        [_requirTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(65);
        }];
    }
    return _requirTitleLabel;
}

-(MLLabel*)requirLabel
{
    if (!_requirLabel) {
        _requirLabel=[[MLLabel alloc]init];
        _requirLabel.font=[UIFont systemFontOfSize:13];
        _requirLabel.textColor=Public_Text_Color;
        _requirLabel.numberOfLines=0;
        _requirLabel.lineSpacing=5;
        [self.contentView addSubview:_requirLabel];
        [_requirLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(80);
            make.right.mas_equalTo(self.contentView).offset(-35);
            make.top.mas_equalTo(self.contentView).offset(63);
        }];
    }
    return _requirLabel;
}

-(void)reloadUIWithDic:(NSDictionary*)dic
{
    NSDictionary *shotBroadcastRoleInfo = dic[@"shotBroadcastRoleInfo"];
    NSArray *myWorkFileList = dic[@"myWorkFileList"];
    self.myWorkFileList=myWorkFileList;
    
    self.titleLab.text=@"角色信息";
    
    NSString *str=[NSString stringWithFormat:@"角色选择：%@",shotBroadcastRoleInfo[@"roleName"]];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(5,str.length-5)];
    self.roleLabel.attributedText=attStr;

    self.requirTitleLabel.text=@"角色要求：";
    
    NSString *str2 = shotBroadcastRoleInfo[@"remark"];
    self.requirLabel.text=str2;
    
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[AnnunciateDetialSubV class]]) {
            [view  removeFromSuperview];
        }
    }
    
    for (int i=0; i<myWorkFileList.count; i++) {
        AnnunciateDetialSubV *subV = [[AnnunciateDetialSubV alloc]init];
        [self.contentView addSubview:subV];
        subV.tag=1000+i;
        subV.userInteractionEnabled=YES;
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.requirLabel.mas_bottom).offset(235*i);
            make.height.mas_equalTo(235);
        }];
        [subV reloadUIWithDic:myWorkFileList[i]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [subV addGestureRecognizer:tap];
    }
}

-(void)tapAction:(UITapGestureRecognizer*)tap
{
    if (self.clickSourceWithInfoBlock) {
        self.clickSourceWithInfoBlock(self.myWorkFileList[tap.view.tag-1000]);
    }
}

@end

@interface AnnunciateDetialSubV()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIButton *playBtn;  //
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UIButton *timeBtn;
@end

@implementation AnnunciateDetialSubV

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:13];
        _titleLab.textColor=Public_DetailTextLabelColor;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self).offset(12);
        }];
    }
    return _titleLab;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=5;
        _icon.backgroundColor=[UIColor grayColor];
        [self addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(40);
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(15);
            make.right.mas_equalTo(self).offset(-15);
        }];
    }
    return _icon;
}

-(UIButton*)playBtn
{
    if (!_playBtn) {
        _playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.icon addSubview:_playBtn];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"icon_home_videoPlay"] forState:UIControlStateDisabled];
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon);
            make.centerX.mas_equalTo(self.icon);
        }];
        _playBtn.enabled=NO;
        [_playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        [_icon addSubview:_bgV];
        _bgV.backgroundColor=[[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.4];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon);
            make.right.mas_equalTo(self.icon);
            make.bottom.mas_equalTo(self.icon);
            make.height.mas_equalTo(32);
        }];
    }
    return _bgV;
}

-(UIButton*)timeBtn
{
    if (!_timeBtn) {
        _timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:_timeBtn];
        _timeBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_timeBtn setTitle:@"00:00" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeBtn setImage:[UIImage imageNamed:@"icon_home_videoDuration"] forState:UIControlStateNormal];
        [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon).offset(8);
            make.bottom.mas_equalTo(self.icon).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}


-(void)reloadUIWithDic:(NSDictionary*)dic
{
    
    NSInteger workType = [dic[@"workType"]integerValue];   //作品类型 1：模特卡；2：自我介绍视频；3：试镜视频
    NSInteger fileType = [dic[@"fileType"]integerValue]; //文件类型 1：图片；2：视频
    
    if (fileType==1) {
        self.playBtn.hidden=YES;
        self.timeBtn.hidden=YES;
        self.bgV.hidden=YES;
        [self.icon sd_setImageWithUrlStr: dic[@"url"] placeholderImage:[UIImage imageNamed:@"default_video"]];
    }
    else
    {
        self.playBtn.hidden=NO;
        self.timeBtn.hidden=NO;
        self.bgV.hidden=NO;
        int time = [dic[@"duration"] intValue];
        [self.timeBtn setTitle:[PublicManager timeFormatted:time] forState:UIControlStateNormal];
        [self.icon sd_setImageWithUrlStr: dic[@"cuturl"] placeholderImage:[UIImage imageNamed:@"default_video"]];
    }
    
    switch (workType) {
        case 1:
            self.titleLab.text=@"模特卡：";
            break;
        case 2:
            self.titleLab.text=@"自我介绍视频：";
            break;
        case 3:
            self.titleLab.text=@"试镜视频：";
            break;
        default:
            break;
    }
}

-(void)playAction
{
    
}

@end
