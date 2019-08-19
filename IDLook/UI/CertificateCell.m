//
//  CertificateCell.m
//  IDLook
//
//  Created by HYH on 2018/7/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CertificateCell.h"

@interface CertificateCell()
@property(nonatomic,strong)UIImageView *icon;
@end

@implementation CertificateCell

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.cornerRadius=5.0;
        _icon.layer.shadowOffset = CGSizeMake(5, 5);
        _icon.layer.shadowOpacity = 1.0;
        _icon.clipsToBounds=YES;
        _icon.layer.shadowColor = [[UIColor colorWithHexString:@"#549DD2"] colorWithAlphaComponent:0.1].CGColor;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
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
    [self.icon sd_setImageWithUrlStr:url placeholderImage:[UIImage imageNamed:@"default_video"]];
}

@end
