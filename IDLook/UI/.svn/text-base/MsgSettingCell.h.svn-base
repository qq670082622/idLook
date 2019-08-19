//
//  MsgSettingCell.h
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MsgSettingCellAType)
{
    MsgSettingCellATypeReceive = 0,  //接收新消息通知
    MsgSettingCellATypeSound,        //声音
    MsgSettingCellATypeVibrate,       //震动
    MsgSettingCellATypeWifiAutoPlay,    //wifi自动播放
    MsgSettingCellATypeListIsMute       //列表是否静音
};

@interface MsgSettingCell : UITableViewCell

- (void)reloadUIWithType:(MsgSettingCellAType)type;
@property(nonatomic,copy)void(^MsgSettingCellABlock)(BOOL on);

@end
