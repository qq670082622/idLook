//
//  HomeTopV.m
//  IDLook
//
//  Created by Mr Hu on 2018/12/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeTopV.h"

@implementation HomeTopV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    NSArray *array = @[@"广告演员",@"影视剧演员",@"外籍模特",@"前景演员"];

    
    CGFloat width = UI_SCREEN_WIDTH/4;
    for (int i =0; i<array.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self addSubview:button];
        button.tag=1000+i;
        button.layer.borderWidth=0.5;
        button.layer.borderColor=Public_LineGray_Color.CGColor;
        button.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateSelected];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.frame=CGRectMake(width*i, self.height-48, width,48);
        [button addTarget:self action:@selector(buttionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)buttionClick:(UIButton*)sender
{
    if (self.selectWithType) {
        self.selectWithType(sender.tag-1000);
    }
}

@end
