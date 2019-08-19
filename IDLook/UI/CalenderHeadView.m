//
//  CalenderHeadView.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/2.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CalenderHeadView.h"

@implementation CalenderHeadView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor=Public_LineGray_Color;
        [self addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (UILabel *)yearAndMonthLabel {
    if (_yearAndMonthLabel == nil) {
        _yearAndMonthLabel                 = [[UILabel alloc] init];
        _yearAndMonthLabel.textAlignment   = NSTextAlignmentCenter;
        _yearAndMonthLabel.font            = [UIFont systemFontOfSize:14];
        _yearAndMonthLabel.textColor       = Public_Text_Color;
        [self addSubview:_yearAndMonthLabel];
        [_yearAndMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _yearAndMonthLabel;
}

@end
