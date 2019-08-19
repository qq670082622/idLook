//
//  ScriptCell.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/22.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ScriptCell.h"

@interface ScriptCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIButton *timeBtn;     //视频时间

@end

@implementation ScriptCell

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.cornerRadius=4.0;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return _icon;
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

-(void)reloadUIWithModel:(ScriptModel *)model
{
    if (model.type==1) {
        [self.icon sd_setImageWithUrlStr:model.cuturl placeholderImage:[UIImage imageNamed:@"default_home"]];
        NSString *time = [PublicManager timeFormatted:model.duration];
        [self.timeBtn setTitle:time forState:UIControlStateNormal];
        self.timeBtn.hidden=NO;
    }
    else if (model.type==2)
    {
        [self.icon sd_setImageWithUrlStr:model.imageurl placeholderImage:[UIImage imageNamed:@"default_home"]];
        self.timeBtn.hidden=YES;
    }
}

@end
