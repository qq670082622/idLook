//
//  VideoSelCell.m
//  IDLook
//
//  Created by HYH on 2018/6/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoSelCell.h"

@interface VideoSelCell ()

@property (nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIButton *timeBtn;

@end

@implementation VideoSelCell

- (UIImageView  *)icon
{
    if(!_icon)
    {
        _icon = [[UIImageView alloc] init];
        _icon.layer.cornerRadius = 6.f;
        _icon.layer.masksToBounds = YES;
//        _icon.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClicked)];
        [_icon addGestureRecognizer:tap];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return _icon;
}

- (UIButton *)btn
{
    if(!_btn)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setBackgroundImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_btn setBackgroundImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];
        
        [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(23, 23));
            make.right.equalTo(self.contentView).offset(-5);
            make.top.equalTo(self.contentView).offset(5);
        }];
    }
    return _btn;
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

- (void)reloadWithDic:(NSDictionary *)dic;
{

    self.icon.image = dic[@"image"];

    [self.timeBtn setTitle:dic[@"time"] forState:UIControlStateNormal];

    BOOL isSelect = [dic[@"isSelect"] boolValue];
    
    self.btn.selected=isSelect;;
}

#pragma mark -
#pragma mark - others

- (void)btnClicked
{
    self.btn.selected=!self.btn.selected;
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    ani.fromValue =@1.0;
    ani.toValue =@1.3;
    ani.duration =.1f;
    ani.autoreverses = YES;
    [self.btn.layer addAnimation:ani forKey:@"scale"];
    
    self.didSelected(self.btn.selected);
    
}


@end
