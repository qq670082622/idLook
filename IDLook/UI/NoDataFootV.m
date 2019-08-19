//
//  NoDataFootV.m
//  IDLook
//
//  Created by HYH on 2018/6/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "NoDataFootV.h"

@interface NoDataFootV ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *desc;
@end

@implementation NoDataFootV

-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView).offset(-100);
        }];
    }
    return _imageView;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        [self.contentView addSubview:_desc];
        _desc.font=[UIFont systemFontOfSize:14.0];
        _desc.textColor=[UIColor colorWithHexString:@"#999999"];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(15);
        }];
    }
    return _desc;
}

-(void)reloadUI
{
    self.imageView.image=[UIImage imageNamed:@"nodata_works"];
    self.desc.text=@"暂无作品";
}

@end
