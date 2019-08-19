//
//  UserInfoCellC.m
//  IDLook
//
//  Created by Mr Hu on 2019/3/7.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "UserInfoCellC.h"

@interface UserInfoCellC ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UIButton *playBtn;  //查看报价
@property(nonatomic,strong)UILabel *totalLab;
@property(nonatomic,strong)UIButton *timeBtn;
@end

@implementation UserInfoCellC
-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.cornerRadius=5.0;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(15);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
        
//        UIView *bgV = [[UIView alloc]init];
//        bgV.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.3];
//        [_icon addSubview:bgV];
//        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(_icon).insets(UIEdgeInsetsZero);
//        }];
    }
    return _icon;
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

-(UILabel*)totalLab
{
    if (!_totalLab) {
        _totalLab=[[UILabel alloc]init];
        [self.bgV addSubview:_totalLab];
        _totalLab.font=[UIFont systemFontOfSize:12];
        _totalLab.textColor=[UIColor whiteColor];
        [_totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgV).offset(15);
            make.centerY.mas_equalTo(self.bgV).offset(0);
        }];
    }
    return _totalLab;
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
            make.right.mas_equalTo(self.icon).offset(-8);
            make.bottom.mas_equalTo(self.icon).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}

-(void)reloadUIWithWorksModel:(UserWorkModel *)model
{
    [self.icon sd_setImageWithUrlStr:model.coverUrl placeholderImage:[UIImage imageNamed:@"default_video"]];

    self.totalLab.text=[NSString stringWithFormat:@"%ld次观看  |  %ld次下载",model.plays,model.downloads];
    
    if (model.url.length==0) {
        self.playBtn.hidden=YES;
        self.timeBtn.hidden=YES;
    }
    else
    {
        self.playBtn.hidden=NO;
        self.timeBtn.hidden=NO;
        [self.timeBtn setTitle:[PublicManager timeFormatted:model.videoTime] forState:UIControlStateNormal];
    }
}


-(void)playAction
{
    
}


@end
