//
//  MsgMainHeadV.m
//  IDLook
//
//  Created by HYH on 2018/5/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MsgMainHeadV.h"

@interface MsgMainHeadV ()
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIView *circularV;
@property(nonatomic,strong)UILabel *timeLab;
@end

@implementation MsgMainHeadV

-(UIView*)lineV
{
    if (!_lineV) {
        _lineV=[[UIView alloc]init];
        _lineV.backgroundColor=Public_LineGray_Color;
        [self.contentView addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(27);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.width.mas_equalTo(2);
        }];
    }
    return _lineV;
}

-(UIView*)circularV
{
    if (!_circularV) {
        _circularV=[[UIView alloc]init];
        _circularV.layer.masksToBounds=YES;
        _circularV.layer.cornerRadius=8.0;
        _circularV.backgroundColor=[UIColor colorWithHexString:@"#D8D8D8"];
        [self.contentView addSubview:_circularV];
        [_circularV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView).offset(-15);
            make.centerX.mas_equalTo(self.lineV);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
    }
    return _circularV;
}

-(UILabel*)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:12.0];
        _timeLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView).offset(-10);
            make.left.mas_equalTo(self.contentView).offset(20);
        }];
    }
    return _timeLab;
}

-(void)reloadUIWithDate:(NSString *)date
{
//    [self lineV];
//    [self circularV];
    self.timeLab.text=date;
}

@end
