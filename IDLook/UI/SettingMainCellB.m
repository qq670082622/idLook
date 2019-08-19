//
//  EditInfoCellC.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SettingMainCellB.h"

@interface SettingMainCellB ()
@property(nonatomic,strong)UIButton *loginoutBtn;
@end

@implementation SettingMainCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loginoutBtn];
    }
    return self;
}

-(UIButton*)loginoutBtn
{
    if (!_loginoutBtn) {
        _loginoutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_loginoutBtn];
        _loginoutBtn.enabled=NO;
        _loginoutBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
        [_loginoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_loginoutBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [_loginoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _loginoutBtn;
}

@end