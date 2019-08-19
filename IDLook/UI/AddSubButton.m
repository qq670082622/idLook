//
//  AddSubButton.m
//  IDLook
//
//  Created by HYH on 2018/5/22.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AddSubButton.h"

@interface AddSubButton ()
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *icon;
@end

@implementation AddSubButton

-(id)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        self.layer.cornerRadius=5.0;
        self.layer.masksToBounds=YES;
        self.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(UIImageView*)imageV
{
    if (!_imageV) {
        _imageV=[[UIImageView alloc]init];
        [self addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_centerY).offset(5);
        }];
    }
    return _imageV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:12.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#999999"];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.imageV.mas_bottom).offset(10);
        }];
    }
    return _titleLab;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
    }
    return _icon;
}

-(void)setTitle:(NSString *)title
{
    _title=title;
    self.titleLab.text=title;
}

-(void)setImageN:(NSString *)imageN
{
    _imageN=imageN;
    self.imageV.image=[UIImage imageNamed:imageN];
}

-(void)setIconImage:(UIImage *)iconImage
{
    _iconImage=iconImage;
    self.icon.image=iconImage;
}

-(void)tapAction
{
    self.addAction();
}

@end
