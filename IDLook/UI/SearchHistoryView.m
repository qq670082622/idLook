//
//  SearchHistoryView.m
//  IDLook
//
//  Created by HYH on 2018/4/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SearchHistoryView.h"

@interface SearchHistoryView()
{
    NSInteger yCoordinate; //第二组y轴坐标
}
@end

@implementation SearchHistoryView

-(void)layoutIfNeeded
{
    [super layoutIfNeeded];
    
    [self initHistoryView];
    [self initHotView];

}

-(void)initHistoryView
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 25,120,13)];
    title.text = @"搜索历史";
    title.font = [UIFont systemFontOfSize:13.0];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(15, 46, UI_SCREEN_WIDTH-30, 0.5)];
    lineV.backgroundColor=Public_LineGray_Color;
    [self addSubview:lineV];
    
    UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delectBtn setBackgroundImage:[UIImage imageNamed:@"icon_delect"] forState:UIControlStateNormal];
    [self addSubview:delectBtn];
    [delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(title);
        make.right.mas_equalTo(self).offset(-15);
    }];
    [delectBtn addTarget:self action:@selector(delectHistory) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = [UserInfoManager getSearchHistoryType];
    
    //没有搜索历史时
    if (arr.count==0) {
        
        UILabel *detial = [[UILabel alloc] init];
        detial.text = @"暂无搜索历史～";
        detial.font = [UIFont systemFontOfSize:13.0];
        detial.textColor = [UIColor lightGrayColor];
        [self addSubview:detial];
        [detial mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(lineV.mas_bottom).offset(20);
        }];
        yCoordinate=0;
        
        title.hidden=YES;
        lineV.hidden=YES;
        delectBtn.hidden=YES;
        detial.hidden=YES;
    }
    else
    {
        NSInteger x = 15;
        NSInteger y = 60;
        CGFloat height = 32;

        for (NSInteger i=0; i<arr.count; i++) {
            NSString *str = [arr objectAtIndex:i];
            CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            CGFloat width = size.width+75;
            
            if (width>self.frame.size.width-30) {
                width=self.frame.size.width-30;
            }
            if (x + width > self.frame.size.width-20) {
                x = 15;
                y = y + height+10; //10为两行之间的高度间隔
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, (int)width,(int)height)];
            label.text = str;
            label.userInteractionEnabled=YES;
            label.font = [UIFont systemFontOfSize:13.0];
            label.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
            label.textColor = [UIColor colorWithHexString:@"#666666"];
            label.textAlignment=NSTextAlignmentCenter;
            label.layer.cornerRadius=4.0;
            label.layer.masksToBounds=YES;
            [self addSubview:label];
            label.tag=100+i;
            x = x + width + 10; //10为两个标签之间的宽度间隔
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickType:)];
            [label addGestureRecognizer:tap];
        }
        yCoordinate=y+height;
    }
}

-(void)initHotView
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 25+yCoordinate,120,13)];
    title.text = @"热门搜索";
    title.font = [UIFont systemFontOfSize:13.0];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(15, 46+yCoordinate, UI_SCREEN_WIDTH-30, 0.5)];
    lineV.backgroundColor=Public_LineGray_Color;
    [self addSubview:lineV];
    
    NSArray *arr = @[@"阳光",@"文艺",@"动感",@"职场",@"温柔",@"甜美",@"性感",@"成熟",@"潮酷",@"可爱",@"慈祥",@"平凡",@"居家",@"帅气",@"搞笑"];
    NSInteger x = 15;
    NSInteger y = 60+yCoordinate;
    
    for (NSInteger i=0; i<arr.count; i++) {
        NSString *str = [arr objectAtIndex:i];
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        CGFloat width = size.width+75;
        CGFloat height = 32;
        
        if (width>self.frame.size.width-30) {
            width=self.frame.size.width-30;
        }
        
        if (x + width > self.frame.size.width-20) {
            x = 15;
            y = y + height+10; //10为两行之间的高度间隔
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, (int)width,(int)height)];
        label.text = str;
        label.userInteractionEnabled=YES;
        label.font = [UIFont systemFontOfSize:13.0];
        label.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.textAlignment=NSTextAlignmentCenter;
        label.layer.cornerRadius=4.0;
        label.layer.masksToBounds=YES;
        [self addSubview:label];
        label.tag=1000+i;
        x = x + width + 10; //10为两个标签之间的宽度间隔
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickType:)];
        [label addGestureRecognizer:tap];
    }
}

-(void)delectHistory
{
    [UserInfoManager setSearchHistory:nil];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self initHistoryView];
    [self initHotView];
}

-(void)refreshUI
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self initHistoryView];
    [self initHotView];
}

-(void)clickType:(UITapGestureRecognizer*)tap
{
    UILabel *lab = (UILabel*)tap.view;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickType:)]) {
        [self.delegate didClickType:lab.text];
    }
}

@end
