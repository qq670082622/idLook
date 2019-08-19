//
//  ModelCardSubV.m
//  IDFace
//
//  Created by HYH on 2018/5/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ModelCardSubV.h"

@interface ModelCardSubV ()
@property(nonatomic,strong)UIImageView *icon;
//@property(nonatomic,strong)UIView *bottomBG;
@property(nonatomic,strong)UIImageView *videIcon;
@property(nonatomic,strong)UIButton *playBtn;
//@property(nonatomic,strong)UIButton *fullScreenBtn;
//@property(nonatomic,strong)UILabel *currTimeLab;
//@property(nonatomic,strong)UILabel *totalTimeLab;
//@property(nonatomic,strong)UISlider *slider;
@end

@implementation ModelCardSubV

//-(UIView*)bottomBG
//{
//    if (!_bottomBG) {
//        _bottomBG=[[UIView alloc]init];
//        _bottomBG.userInteractionEnabled=YES;
//        [self.videIcon addSubview:_bottomBG];
//        _bottomBG.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
//        [_bottomBG mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.videIcon);
//            make.right.mas_equalTo(self.videIcon);
//            make.bottom.mas_equalTo(self.videIcon);
//            make.height.mas_equalTo(33);
//        }];
//    }
//    return _bottomBG;
//}
//

//
//-(UIButton*)fullScreenBtn
//{
//    if (!_fullScreenBtn) {
//        _fullScreenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [self.bottomBG addSubview:_fullScreenBtn];
//        [_fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"u_screen"] forState:UIControlStateNormal];
//        [_fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.bottomBG).offset(-13);
//            make.centerY.mas_equalTo(self.bottomBG);
//        }];
//    }
//    return _fullScreenBtn;
//}
//
//-(UILabel*)currTimeLab
//{
//    if (!_currTimeLab) {
//        _currTimeLab=[[UILabel alloc]init];
//        _currTimeLab.font=[UIFont systemFontOfSize:11.0];
//        _currTimeLab.textColor=[UIColor whiteColor];
//        [self.bottomBG addSubview:_currTimeLab];
//        [_currTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.playBtn.mas_right).offset(14);
//            make.centerY.mas_equalTo(self.bottomBG);
//        }];
//    }
//    return _currTimeLab;
//}
//
//-(UILabel*)totalTimeLab
//{
//    if (!_totalTimeLab) {
//        _totalTimeLab=[[UILabel alloc]init];
//        _totalTimeLab.font=[UIFont systemFontOfSize:11.0];
//        _totalTimeLab.textColor=[UIColor whiteColor];
//        [self.bottomBG addSubview:_totalTimeLab];
//        [_totalTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.fullScreenBtn.mas_left).offset(-14);
//            make.centerY.mas_equalTo(self.bottomBG);
//        }];
//    }
//    return _totalTimeLab;
//}
//
//-(UISlider*)slider
//{
//    if (!_slider) {
//        _slider = [[UISlider alloc] init];
//        _slider.backgroundColor = [UIColor clearColor];
//        _slider.value = 0.0;
//        _slider.minimumValue = 0.0;
//        _slider.maximumValue = 1.0;
//        _slider.tintColor=[UIColor colorWithHexString:@"#FF4A57"];
//        [self addSubview:_slider];
//        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.bottomBG);
//            make.left.mas_equalTo(self.currTimeLab.mas_right).offset(10);
//            make.right.mas_equalTo(self.totalTimeLab.mas_left).offset(-10);
//            make.height.mas_equalTo(33);
//        }];
//
//        //设置滑块的图片
//        [_slider setThumbImage:[UIImage imageNamed:@"u_detial_play_speed"] forState:UIControlStateNormal];
//        [_slider addTarget:self action:@selector(onThumb:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _slider;
//}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self addSubview:_icon];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds=YES;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(15);
            make.height.mas_equalTo(205);
        }];
    }
    return _icon;
}

-(UIImageView*)videIcon
{
    if (!_videIcon) {
        _videIcon=[[UIImageView alloc]init];
        _videIcon.layer.masksToBounds=YES;
        _videIcon.layer.cornerRadius=5.0;
        _videIcon.userInteractionEnabled=YES;
        _videIcon.clipsToBounds=YES;
        _videIcon.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_videIcon];
        [_videIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.icon.mas_bottom).offset(15);
            make.height.mas_equalTo(205);
        }];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_videIcon addGestureRecognizer:tap];
    }
    return _videIcon;
}

-(UIButton*)playBtn
{
    if (!_playBtn) {
        _playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_playBtn];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"u_play_big"] forState:UIControlStateNormal];
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.videIcon);
            make.centerY.mas_equalTo(self.videIcon);
        }];
        [_playBtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    [self.icon sd_setImageWithUrlStr:dic[@"image"] placeholderImage:[UIImage imageNamed:@"default_video"]];
    
    [self.videIcon sd_setImageWithUrlStr:dic[@"cutvideo"] placeholderImage:[UIImage imageNamed:@"default_video"]];
    
    [self playBtn];
    
//    self.videIcon.image=[UIImage imageNamed:dic[@"video"]];
//    [self bottomBG];
//    [self playBtn];
//    [self fullScreenBtn];
//    self.currTimeLab.text=@"00:38:00";
//    self.totalTimeLab.text=@"02:38:00";
//    [self slider];
    
}

-(void)tapAction
{
//    self.playVideoAction();
}

@end
