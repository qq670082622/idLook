//
//  PlaceSchemeCell.m
//  IDLook
//
//  Created by HYH on 2018/7/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceSchemeCell.h"
#import "AddSubButton.h"

@interface PlaceSchemeCell ()
@property(nonatomic,strong)AddSubButton *addBtn;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIButton *timeBtn;
@end

@implementation PlaceSchemeCell


-(AddSubButton*)addBtn
{
    if (!_addBtn) {
        _addBtn=[[AddSubButton alloc]init];
        [self.contentView addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(25);
            make.bottom.mas_equalTo(self.contentView).offset(-25);
            make.centerX.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        WeakSelf(self);
        _addBtn.addAction = ^{
            weakself.addSchemeBlock();
        };
    }
    return _addBtn;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        _icon.layer.cornerRadius=5.0;
        _icon.backgroundColor=[UIColor blackColor];
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(25);
            make.bottom.mas_equalTo(self.contentView).offset(-25);
            make.centerX.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        _icon.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_icon addGestureRecognizer:tap];
    }
    return _icon;
}

-(UIButton*)timeBtn
{
    if (!_timeBtn) {
        _timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_timeBtn];
        _timeBtn.layer.masksToBounds=YES;
        _timeBtn.layer.cornerRadius=9;
        _timeBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
        _timeBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_timeBtn setTitle:@"00:00" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeBtn setImage:[UIImage imageNamed:@"u_video_s"] forState:UIControlStateNormal];
        [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon).offset(6);
            make.bottom.mas_equalTo(self.icon).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}

-(void)reloadUI
{
    self.addBtn.imageN=@"order_photo";
    self.addBtn.title=@"要求：单张5M内图片/视频文件";
}

-(void)setImage:(UIImage *)image
{
    if (image==nil) {
        self.addBtn.hidden=NO;
        self.icon.hidden=YES;
        self.timeBtn.hidden=YES;
    }
    else
    {
        self.addBtn.hidden=YES;
        self.icon.image=image;
        self.icon.hidden=NO;
    }
}

-(void)setTime:(NSString *)time
{
    if (time.length>0) {
        [self.timeBtn setTitle:time forState:UIControlStateNormal];
        self.timeBtn.hidden=NO;
    }
    else
    {
        self.timeBtn.hidden=YES;
    }
}

-(void)tapAction
{
    self.addSchemeBlock();
}

@end
