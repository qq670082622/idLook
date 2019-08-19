//
//  PayWayCell.m
//  IDLook
//
//  Created by HYH on 2018/7/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PayWayCell.h"

@interface PayWayCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *desc;
@end

@implementation PayWayCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=2.0;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _icon;
}

-(UILabel*)title
{
    if (!_title) {
        _title=[[UILabel alloc]init];
        _title.font=[UIFont systemFontOfSize:15.0];
        _title.textColor=Public_Text_Color;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(11);
            make.top.mas_equalTo(self.contentView).offset(22);
        }];
    }
    return _title;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:12.0];
        _desc.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(11);
            make.top.mas_equalTo(self.title.mas_bottom).offset(6);
        }];
    }
    return _desc;
}

-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"pay_select_n"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"pay_select_h"] forState:UIControlStateSelected];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _selectBtn;
}

-(void)realoadUIWithDic:(NSDictionary *)dic
{
    self.icon.image=[UIImage imageNamed:dic[@"image"]];
    self.title.text=dic[@"title"];
    self.desc.text=dic[@"desc"];
    [self selectBtn];
}

@end
