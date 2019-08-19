//
//  MsgSettingCell.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MsgSettingCell.h"

@interface MsgSettingCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UISwitch *swch;

@end

@implementation MsgSettingCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
 
    }
    return self;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

- (UISwitch *)swch
{
    if(!_swch)
    {
        _swch = [[UISwitch alloc] init];
        [self.contentView addSubview:_swch];
        _swch.onTintColor=Public_Red_Color;
        [_swch addTarget:self action:@selector(switchBtnChangeValue:) forControlEvents:UIControlEventTouchUpInside];
        [_swch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _swch;
}

- (void)reloadUIWithType:(MsgSettingCellAType)type
{
    [self swch];
    
    if(type==MsgSettingCellATypeReceive)
    {
        self.titleLab.text = @"接收新消息通知";
        self.swch.on= [DeviceSettingManager getMsgNotify];//[UserInfoManager getMsgNotify];
    }
    else if(type==MsgSettingCellATypeSound)
    {
        self.titleLab.text = @"声音";
        self.swch.on=  [DeviceSettingManager getSoundStatus];//[UserInfoManager getSoundStatus];
    }
    else if(type==MsgSettingCellATypeVibrate)
    {
        self.titleLab.text = @"振动";
        self.swch.on= [DeviceSettingManager getUserVibirateStatus]; //[UserInfoManager getUserVibirateStatus];
    }
    else if(type==MsgSettingCellATypeWifiAutoPlay)
    {
        self.titleLab.text = @"wifi环境下自动播放";
        self.swch.on=[UserInfoManager getWifiAuthPlay];
    }
    else if (type==MsgSettingCellATypeListIsMute)
    {
        self.titleLab.text = @"自动播放是否静音";
        self.swch.on=[UserInfoManager getListPlayIsMute];
    }
}

-(void)switchBtnChangeValue:(UISwitch*)swit
{
    BOOL isOpen=swit.isOn;
    
    self.MsgSettingCellABlock(isOpen);
}

@end
