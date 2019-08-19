//
//  ScheduleLockFootV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/4.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ScheduleLockFootV.h"

@implementation ScheduleLockFootV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{

    UIImageView *icon=[[UIImageView alloc]init];
    [self addSubview:icon];
    icon.image=[UIImage imageNamed:@"project_prompt"];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    UILabel *desLab = [[MLLabel alloc] init];
    desLab.font = [UIFont systemFontOfSize:12];
    desLab.textColor = Public_DetailTextLabelColor;
    desLab.text=@"点击“提交订单”表示您已阅读并同意";
    desLab.numberOfLines=0;
    [self addSubview:desLab];
    [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).offset(3);
        make.centerY.mas_equalTo(self);
    }];
    
    UIButton *lookProtBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:lookProtBtn];
    [lookProtBtn setTitle:@"《档期预约金服务协议》" forState:UIControlStateNormal];
    [lookProtBtn setTitleColor:[UIColor colorWithHexString:@"#00B0FF"] forState:UIControlStateNormal];
    lookProtBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [lookProtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(desLab.mas_right).offset(0);
    }];
    [lookProtBtn addTarget:self action:@selector(lookProtocolAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)lookProtocolAction
{
    if (self.lookProtocolBlock) {
        self.lookProtocolBlock();
    }
}

@end
