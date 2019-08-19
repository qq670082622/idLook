//
//  BlackListCell.m
//  IDLook
//
//  Created by HYH on 2018/8/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "BlackListCell.h"

@interface BlackListCell ()
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *desc;
@end

@implementation BlackListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=5.0;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
    }
    return _icon;
}

-(UILabel*)name
{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=[UIFont boldSystemFontOfSize:18.0];
        _name.textColor=Public_Text_Color;
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(15);
            make.top.mas_equalTo(self.icon).offset(10);
        }];
    }
    return _name;
}



-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:13.0];
        _desc.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-37);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _desc;
}



-(void)reloadUIWithDic:(NSDictionary *)dic
{
    NSString *head;
    NSString *nick;
    if ([UserInfoManager getIsJavaService]) {
        head=dic[@"actorHeadMini"];
        nick=dic[@"actorNickName"];
    }
    else
    {
        head=dic[@"headmini"];
        nick=dic[@"nickname"];
    }
    
    [self.icon sd_setImageWithUrlStr:head placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.name.text= nick;
}


@end
