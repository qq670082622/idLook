//
//  ModifyWorksCellB.m
//  IDLook
//
//  Created by HYH on 2018/6/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ModifyWorksCellB.h"

@interface ModifyWorksCellB ()
@property(nonatomic,strong)UIImageView *icon;
@end

@implementation ModifyWorksCellB

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.layer.cornerRadius=5.0;
        _icon.backgroundColor=[UIColor blackColor];
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _icon;
}

-(void)reloadUIWithUrl:(NSString *)url
{
    [self.icon sd_setImageWithUrlStr:url placeholderImage:[UIImage imageNamed:@"default_photo"]];
}

@end
