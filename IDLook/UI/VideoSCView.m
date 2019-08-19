//
//  VideoSCView.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoSCView.h"

@interface VideoSCView ()
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIScrollView *scView;
@property(nonatomic,strong)UIView *slider;

@end

@implementation VideoSCView

-(void)setTypeViewArray:(NSArray *)typeViewArray
{
    _typeViewArray=typeViewArray;
    [self initUI];
}

-(UIScrollView*)scView
{
    if (!_scView) {
        _scView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
        _scView.backgroundColor=Public_Background_Color;
        _scView.scrollEnabled = YES;//设置是否支持滚动
        _scView.showsVerticalScrollIndicator = YES;//设置是否显示垂直滚动条
        [self addSubview:_scView];
        _scView.alwaysBounceVertical = YES; //当contentsize小于scrollview尺寸时，垂直方向添加弹簧效果
    }
    return  _scView;
}

//绘制UI
-(void)initUI
{
    for (UIView *view in self.scView.subviews) {
        [view removeFromSuperview];
    }
    
    for (NSInteger i=0;i<_typeViewArray.count;i++)
    {
        UIButton *btn=[[UIButton alloc] init];
        btn.tag=100000+i;
        [btn setTitle:_typeViewArray[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [btn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [btn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(0,60*i,self.frame.size.width, 60)];
        btn.selected=NO;
        [self.scView addSubview:btn];
        
        if (i==0)
        {
            btn.selected=YES;
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
            btn.backgroundColor=[UIColor whiteColor];
            self.selectedBtn=btn;
        }
    }
    
    self.scView.contentSize = CGSizeMake(90,60*_typeViewArray.count);//设置滚动区域大小
    
    //slider
    UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(0,0, 4,60)];
    slider.backgroundColor = Public_Red_Color;
    [self.scView addSubview:slider];
    self.slider=slider;
}

//点击了类型btn
-(void)typeBtnClick:(UIButton*)selectedBtn
{
    if (selectedBtn == _selectedBtn) {
        return;
    }
    
    //计算scrollview偏移量
    CGFloat originY = selectedBtn.center.y - CGRectGetMidY(self.scView.frame);
    CGFloat maxOffsetY = self.scView.contentSize.height - self.scView.frame.size.height;
    if (originY < 0 || maxOffsetY<=0) {
        originY = 0;
    }else if (originY > maxOffsetY && maxOffsetY>0){
        originY = maxOffsetY;
    }

    [self.scView setContentOffset:CGPointMake(0,originY) animated:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        selectedBtn.selected=YES;
        selectedBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
        selectedBtn.backgroundColor=[UIColor whiteColor];
        
        self.selectedBtn.selected=NO;
        self.selectedBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        self.selectedBtn.backgroundColor=[UIColor clearColor];
        
        self.slider.frame=CGRectMake(0,selectedBtn.frame.origin.y, 4, 60);
    }];
    
    self.selectedBtn = selectedBtn;
    
    if (self.ScreeSliderAClick) {
        self.ScreeSliderAClick(selectedBtn.tag-100000);
    }
}



@end
