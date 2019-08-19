//
//  VideoDetialCellA.m
//  IDLook
//
//  Created by HYH on 2018/6/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoDetialCellA.h"

@interface VideoDetialCellA ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIImageView *play;

@end

@implementation VideoDetialCellA

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.clipsToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return _icon;
}

-(UIImageView*)play
{
    if (!_play) {
        _play=[[UIImageView alloc]init];
        [self.contentView addSubview:_play];
        _play.image=[UIImage imageNamed:@"u_play"];
        [_play mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon);
            make.centerX.mas_equalTo(self.icon);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }
    return _play;
}

-(void)reloadUIWithModel:(WorksModel *)model
{
    [self.icon sd_setImageWithUrlStr:model.cutvideo placeholderImage:[UIImage imageNamed:@"default_video"]];
    
    [self play];
}


@end
