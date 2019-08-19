//
//  AssetsMainHeadV.m
//  IDLook
//
//  Created by HYH on 2018/5/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AssetsMainHeadV.h"

@interface AssetsMainHeadV ()
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *desc;
@end

@implementation AssetsMainHeadV

-(UILabel*)title
{
    if (!_title) {
        _title=[[UILabel alloc]init];
        _title.numberOfLines=0;
        _title.font=[UIFont systemFontOfSize:13.0];
        _title.textColor=Public_Text_Color;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _title;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.numberOfLines=0;
        _desc.font=[UIFont systemFontOfSize:12.0];
        _desc.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _desc;
}

-(void)reloadUIWithMonth:(NSInteger)month
{
    NSInteger currMonth = [PublicManager getMonthWithDate:[NSDate date]];

    if (currMonth==month) {
        self.title.text=@"本月";
    }
    else
    {
        self.title.text=[NSString stringWithFormat:@"%ld月",month];
    }
}

@end
