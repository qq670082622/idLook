//
//  PublicPageControl.m
//  IDLook
//
//  Created by HYH on 2018/5/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PublicPageControl.h"

@implementation PublicPageControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}
-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,11,4)];
        
        if (subviewIndex == currentPage)
        {
            subview.layer.cornerRadius = 2;
            subview.layer.masksToBounds = YES;
        }
        else
        {
            subview.layer.cornerRadius = 2;
            subview.layer.masksToBounds = YES;
            
        }
    }
    
}

@end
