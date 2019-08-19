//
//  AddPriceFootV.m
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddPriceFootV.h"

@interface AddPriceFootV()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *desc1;
@property(nonatomic,strong)UILabel *desc2;
@end

@implementation AddPriceFootV

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:13.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self).offset(30);
        }];
        _titleLab.text=@"温馨提示";
    }
    return _titleLab;
}

-(UILabel*)desc1
{
    if (!_desc1) {
        _desc1=[[UILabel alloc]init];
        [self addSubview:_desc1];
        _desc1.font=[UIFont systemFontOfSize:12.0];
        _desc1.textColor=[UIColor colorWithHexString:@"#999999"];
        [_desc1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(15);
        }];
        _desc1.text=@"单项报价所包含：拍摄天数为1天，肖像年限为1年";
    }
    return _desc1;
}

-(UILabel*)desc2
{
    if (!_desc2) {
        _desc2=[[UILabel alloc]init];
        [self addSubview:_desc2];
        _desc2.font=[UIFont systemFontOfSize:12.0];
        _desc2.textColor=[UIColor colorWithHexString:@"#999999"];
        [_desc2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self.desc1.mas_bottom).offset(8);
        }];
        _desc2.text=@"拍摄城市为演员所在地，肖像范围为中国大陆地区";
    }
    return _desc2;
}

-(void)reloadUI
{
    [self titleLab];
    [self desc1];
    [self desc2];
}
@end
