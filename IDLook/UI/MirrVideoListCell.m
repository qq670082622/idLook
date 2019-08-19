//
//  MirrVideoListCell.m
//  IDLook
//
//  Created by HYH on 2018/5/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MirrVideoListCell.h"

@interface MirrVideoListCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *buyBtn;
@property(nonatomic,strong)UIButton *timeBtn;

@end

@implementation MirrVideoListCell


-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.layer.cornerRadius=5.0;
        _icon.layer.masksToBounds=YES;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(-30);
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:13.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.buyBtn);
        }];
    }
    return _titleLab;
}

-(UIButton*)buyBtn
{
    if (!_buyBtn) {
        _buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_buyBtn];
        _buyBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"u_buy"] forState:UIControlStateNormal];
        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
        [_buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _buyBtn;
}

-(UIButton*)timeBtn
{
    if (!_timeBtn) {
        _timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_timeBtn];
        _timeBtn.layer.masksToBounds=YES;
        _timeBtn.layer.cornerRadius=9;
        _timeBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
        _timeBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_timeBtn setTitle:@"00:00" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeBtn setImage:[UIImage imageNamed:@"u_video_s"] forState:UIControlStateNormal];
        [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon).offset(6);
            make.bottom.mas_equalTo(self.icon).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}

-(void)reloadUIWithModel:(WorksModel*)model;
{
    [self.icon sd_setImageWithUrlStr:model.cutvideo placeholderImage:[UIImage imageNamed:@"default_video"]];
    self.titleLab.text = model.title;
    [self.timeBtn setTitle:model.timevideo forState:UIControlStateNormal];
    
    if ([UserInfoManager getUserType]==UserTypePurchaser) {
        self.buyBtn.hidden=NO;
    }
    else
    {
        self.buyBtn.hidden=YES;
    }
}

//购买
-(void)buyAction
{
    self.buyVideoBlock();
}

@end
