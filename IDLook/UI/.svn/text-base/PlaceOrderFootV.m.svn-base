//
//  PlaceOrderFootV.m
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceOrderFootV.h"

@interface PlaceOrderFootV ()
@property(nonatomic,strong)UIButton *nextBtn;

@end

@implementation PlaceOrderFootV

-(UIButton*)nextBtn
{
    if (!_nextBtn) {
        _nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextBtn];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"auth_next"] forState:UIControlStateNormal];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

-(void)reloadUIWithTitle:(NSString*)title
{
    [self.nextBtn setTitle:title forState:UIControlStateNormal];
}

-(void)nextAction
{
    self.nextStep();
}

@end
