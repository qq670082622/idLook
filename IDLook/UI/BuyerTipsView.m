//
//  BuyerTipsView.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "BuyerTipsView.h"
#import "SPMarqueeView.h"
@interface BuyerTipsView()
- (IBAction)TopListAction:(id)sender;

@end
@implementation BuyerTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"BuyerTipsView" owner:nil options:nil] lastObject];
    }
    return self;
}
-(void)setData:(NSArray *)data
{
    _data = [NSArray arrayWithArray:data];
    SPMarqueeView *marqueeView = [[SPMarqueeView alloc]initWithFrame:CGRectMake(108, 16, self.width-130, 34)];
    [self addSubview:marqueeView];
    marqueeView.backgroundColor = [UIColor whiteColor];
    //  marqueeView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.f, [UIScreen mainScreen].bounds.size.height/2.f);
//    marqueeView.marqueeTitleArray = @[@"新闻",
//                                      @"游戏",
//                                      @"娱乐"];
    marqueeView.marqueeContentArray = data;
    [marqueeView start];
    marqueeView.block = ^(NSInteger index) {
        NSLog(@"点击了第%ld组数据",index);
    };
}
//-(void)loadUIWithData:(NSArray *)data
//{
//    _data = data;
//  
//}
- (IBAction)TopListAction:(id)sender {
    self.topAction();
}
@end
