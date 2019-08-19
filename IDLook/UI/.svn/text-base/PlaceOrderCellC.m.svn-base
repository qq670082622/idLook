//
//  PlaceOrderCellC.m
//  IDLook
//
//  Created by HYH on 2018/6/21.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceOrderCellC.h"

@interface PlaceOrderCellC ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UILabel *photoLab;

@end

@implementation PlaceOrderCellC

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}


-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}

-(UILabel*)photoLab
{
    if (!_photoLab) {
        _photoLab=[[UILabel alloc]init];
        [self.contentView addSubview:_photoLab];
        _photoLab.font=[UIFont systemFontOfSize:12.0];
        _photoLab.text=@"要求：单张5M内图片";
        _photoLab.textColor=[UIColor colorWithHexString:@"#75CAFF"];
        [_photoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrow.mas_left).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(120, 48));
        }];
    }
    return _photoLab;
}

-(void)reloadUIWithTitile:(NSString *)title
{
    self.titleLab.text=title;
    [self arrow];
    [self photoLab];
}

@end
