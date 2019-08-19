//
//  AssetsTopV.m
//  IDLook
//
//  Created by HYH on 2018/5/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AssetsTopV.h"

@interface AssetsTopV ()
@property (nonatomic,strong)UIImageView *headIcon;
@property(nonatomic,strong)UILabel *totalMoney;
@end

@implementation AssetsTopV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
     
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIImageView *headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0,-SafeAreaTopHeight, UI_SCREEN_WIDTH,160+SafeAreaTopHeight)];
    headIcon.image=[UIImage imageNamed:@"assets_bg"];
    [self addSubview:headIcon];
    self.headIcon=headIcon;

    UILabel *totalMoney=[[UILabel alloc]init];
    totalMoney.font=[UIFont boldSystemFontOfSize:40];
    totalMoney.textColor=[UIColor whiteColor];
    totalMoney.text=@"0.00";
    [self addSubview:totalMoney];
    [totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(110-SafeAreaTopHeight);
    }];
    self.totalMoney=totalMoney;
    
    UILabel *title=[[UILabel alloc]init];
    title.font=[UIFont systemFontOfSize:15];
    title.textColor=[[UIColor whiteColor] colorWithAlphaComponent:0.7];
    title.text=@"账户余额";
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(totalMoney.mas_top).offset(-16);
    }];
    
    UIButton *forwardBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:forwardBtn];
    [forwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(totalMoney.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(97, 32));
    }];
    forwardBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
    [forwardBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [forwardBtn setImage:[UIImage imageNamed:@"assets_arrow"] forState:UIControlStateNormal];
    [forwardBtn setTitle:@"提现" forState:UIControlStateNormal];
    forwardBtn.layer.cornerRadius=16.0;
    forwardBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    forwardBtn.layer.borderWidth=1.0;
    
    forwardBtn.titleLabel.backgroundColor = forwardBtn.backgroundColor;
    forwardBtn.imageView.backgroundColor = forwardBtn.backgroundColor;
    //在使用一次titleLabel和imageView后才能正确获取titleSize
    CGSize titleSize = forwardBtn.titleLabel.bounds.size;
    CGSize imageSize = forwardBtn.imageView.bounds.size;
    CGFloat interval = 1.0;
    forwardBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    forwardBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
    
    forwardBtn.backgroundColor=[UIColor clearColor];
    [forwardBtn addTarget:self action:@selector(forwardAction) forControlEvents:UIControlEventTouchUpInside];
}

//提现
-(void)forwardAction
{
    self.forwardBlock();
}

-(void)changeImageFrameWithOffY:(CGFloat)offY
{
    CGRect frame = self.headIcon.frame;
    frame.origin.y=offY;
    frame.size.height = 110+SafeAreaTopHeight-offY;
    self.headIcon.frame = frame;
}

-(void)refreshTotalAssets:(NSString *)money
{
    self.totalMoney.text=money;
}

@end
