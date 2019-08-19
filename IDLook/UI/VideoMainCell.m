//
//  VideoMainCell.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoMainCell.h"

@interface VideoMainCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation VideoMainCell

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.userInteractionEnabled=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
//        [_icon addGestureRecognizer:tap];
        _icon.clipsToBounds=YES;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:13.0];
        _titleLab.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
        _titleLab.textColor=[UIColor whiteColor];
        _titleLab.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(25);
        }];
    }
    return _titleLab;
}


-(void)reloadUIWithDic:(NSDictionary *)dic
{
    [self.icon sd_setImageWithUrlStr:dic[@"url"] placeholderImage:[UIImage imageNamed:@"default_home"]];
    self.titleLab.text=dic[@"attrname"];

}

-(void)clickAction
{
    
}

@end
