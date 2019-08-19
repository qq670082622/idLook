//
//  ModifyWorksCellA.m
//  IDLook
//
//  Created by HYH on 2018/6/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ModifyWorksCellA.h"

@interface ModifyWorksCellA ()
@property(nonatomic,strong)UIImageView *videIcon;
@property(nonatomic,strong)UIButton *playBtn;
@end

@implementation ModifyWorksCellA

-(UIImageView*)videIcon
{
    if (!_videIcon) {
        _videIcon=[[UIImageView alloc]init];
        _videIcon.layer.masksToBounds=YES;
        _videIcon.contentMode=UIViewContentModeScaleAspectFill;
        _videIcon.layer.cornerRadius=5.0;
        _videIcon.backgroundColor=[UIColor blackColor];
        [self.contentView addSubview:_videIcon];
        [_videIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(20);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _videIcon;
}

-(UIButton*)playBtn
{
    if (!_playBtn) {
        _playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_playBtn];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"u_play_big"] forState:UIControlStateNormal];
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.videIcon);
            make.centerY.mas_equalTo(self.videIcon);
        }];
        _playBtn.enabled=NO;
    }
    return _playBtn;
}

-(void)reloadUIWithUrl:(NSString *)url
{
    [self.videIcon sd_setImageWithUrlStr:url placeholderImage:[UIImage imageNamed:@"default_video"]];
    [self playBtn];
}

@end
