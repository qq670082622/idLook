//
//  AuthFootV.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AuthFootV.h"

@interface AuthFootV ()
@property(nonatomic,strong)UIButton *lastBtn;
@property(nonatomic,strong)UIButton *nextBtn;
@end

@implementation AuthFootV

-(UIButton*)lastBtn
{
    if (!_lastBtn) {
        _lastBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_lastBtn];
        [_lastBtn setBackgroundImage:[UIImage imageNamed:@"auth_last"] forState:UIControlStateNormal];
        [_lastBtn setTitle:@"上一步" forState:UIControlStateNormal];
        [_lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.mas_centerX).offset(-6);
        }];
        [_lastBtn addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastBtn;
}

-(UIButton*)nextBtn
{
    if (!_nextBtn) {
        _nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextBtn];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"auth_next_01"] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.mas_centerX).offset(6);
        }];
        [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _nextBtn;
}

-(void)reloadUIWithType:(NSInteger)type
{
    if (type==0) {
        [self.nextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.centerX.mas_equalTo(self);
        }];
        [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"auth_next"] forState:UIControlStateNormal];
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else if (type==1)
    {
        [self.lastBtn setBackgroundImage:[UIImage imageNamed:@"auth_last"] forState:UIControlStateNormal];
        [self.lastBtn setTitle:@"上一步" forState:UIControlStateNormal];
        
        [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"auth_next_01"] forState:UIControlStateNormal];
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    }
    else if (type==2)
    {
        [self.lastBtn setBackgroundImage:[UIImage imageNamed:@"auth_last"] forState:UIControlStateNormal];
        [self.lastBtn setTitle:@"上一步" forState:UIControlStateNormal];
        
        [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"auth_next_01"] forState:UIControlStateNormal];
        [self.nextBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    }

}

-(void)lastAction
{
    self.clickLastStep();
}

-(void)nextAction
{
    self.clickNextStep();
}

@end
