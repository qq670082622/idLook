//
//  CenterHeadView.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CenterHeadView.h"

@interface CenterHeadView ()
@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation CenterHeadView

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
            make.height.mas_equalTo(48);
        }];
    }
    return _bgV;
}


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:13.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#909090"];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.bgV);
        }];
    }
    return _titleLab;
}

-(void)reloadUIWithTitle:(NSString*)title
{
    [self bgV];
    self.titleLab.text=title;
}

@end
