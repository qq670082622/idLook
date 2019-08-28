//
//  PricePopV.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/28.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "PricePopV.h"
#import "WWSliderView.h"
@interface PricePopV()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,assign)NSInteger price_High;
@property(nonatomic,assign)NSInteger price_Low;
@property(nonatomic, strong)WWSliderView *rangeSlider;
@end
@implementation PricePopV
- (id)init
{
    if(self=[super init])
    {
        Vheight = 463;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }
    return self;
}
-(void)showTypeWithSelectLowPrice:(NSInteger)lowPrice andHighPrice:(NSInteger)highPrice
{
    
}
@end
