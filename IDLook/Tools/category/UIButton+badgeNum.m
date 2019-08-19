//
//  UIButton+badgeNum.m
//  mvvm
//
//  Created by 吴铭 on 2018/12/27.
//  Copyright © 2018年 吴铭. All rights reserved.
//

#import "UIButton+badgeNum.h"

@implementation UIButton (badgeNum)
- (void)setBadge:(NSString *)number andFont:(int)font
{
    if ([number isEqualToString:@"0"]) {
        UILabel *badge = [self viewWithTag:11];
        [badge removeFromSuperview];
        return;
    }
    CGFloat width = self.bounds.size.width;
    CGFloat wid = [self widthWithFont:font andText:number];
    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(width-wid/2, -wid/2,wid, wid)];
    badge.text = number;
    badge.textAlignment = NSTextAlignmentCenter;
    badge.font = [UIFont systemFontOfSize:font];
    badge.backgroundColor = [UIColor redColor];
    badge.textColor = [UIColor whiteColor];
    badge.layer.cornerRadius = wid/2;
    badge.layer.masksToBounds = YES;
    badge.tag = 11;
    [self addSubview:badge];
    
}

-(CGFloat)widthWithFont:(int)font andText:(NSString *)text
{
    CGFloat wid = (text.length*font)*0.8;
    wid = wid<16?16:wid;
    return wid;
}


@end
