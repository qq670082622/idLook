//
//  PlaceOrderHeadV.m
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceOrderHeadV.h"

@interface PlaceOrderHeadV ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation PlaceOrderHeadV

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(UIView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIView alloc]init];
        _bgV.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_bgV];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(40);
        }];
    }
    return _bgV;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:14.0];
        _titleLabel.textColor=[UIColor colorWithHexString:@"#909090"];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bgV);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _titleLabel;
}

-(void)reloadUIWithTitle:(NSString *)title
{
    [self bgV];
    self.titleLabel.text=title;
}

@end
