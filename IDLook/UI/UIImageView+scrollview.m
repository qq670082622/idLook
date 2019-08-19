//
//  UIImageView+scrollview.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/9.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UIImageView+scrollview.h"

#define noDisableVerticalScrollTag 836913
#define noDisableHorizontalScrollTag 836914

@implementation UIImageView (scrollview)

-(void)setAlpha:(CGFloat)alpha
{
    if (self.superview.tag == noDisableVerticalScrollTag)
    {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleLeftMargin)
        {
            if (self.frame.size.width < 10 && self.frame.size.height > self.frame.size.width)
            {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.height < sc.contentSize.height) {
                    return;
                }
            }
        }
    }
    if (self.superview.tag == noDisableHorizontalScrollTag)
    {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleTopMargin)
        {
            if (self.frame.size.height < 10 && self.frame.size.height < self.frame.size.width)
            {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.width < sc.contentSize.width) {
                    return;
                }
            }
        }
    }
    [super setAlpha:alpha];
}

@end
