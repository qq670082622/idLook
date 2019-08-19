//
//  UserHeaderV.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserHeaderV.h"

@interface UserHeaderV ()
{
    UIScrollView *_scView;//类型滚动视图
    NSInteger _typeViewIndex;
}
@property (nonatomic,weak) UIButton *selectedBtn;

@property(nonatomic,strong)UIView *slider;
@property(nonatomic,assign)NSInteger curePage;
@property(nonatomic,strong)UIView *line2;
@end

@implementation UserHeaderV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initUI1];
    }
    return self;
}

-(void)setTypeViewArray:(NSArray *)typeViewArray
{
    _typeViewArray=typeViewArray;
    [self initUI];
}

-(void)initUI1
{
    NSArray *array=@[@"过往作品",@"自我介绍",@"试戏作品",@"模特卡"];
    CGFloat width = UI_SCREEN_WIDTH/array.count;
    
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
    topV.backgroundColor=[UIColor whiteColor];
    [self addSubview:topV];
    
    for (int i = 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [topV addSubview:button];
        button.frame=CGRectMake(width*i,0,width,48);
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *btn = (UIButton*)[self viewWithTag:100+self.curePage];
    
    //slider
    UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(btn.frame.origin.x+(width-85)/2,45,85,3)];
    slider.backgroundColor = Public_Red_Color;
    [topV addSubview:slider];
    self.slider=slider;
    
    _scView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,48, self.frame.size.width,48)];
    _scView.backgroundColor=[UIColor whiteColor];
    _scView.scrollEnabled = YES;//设置是否支持滚动
    _scView.showsHorizontalScrollIndicator = NO;//设置是否显示水平滚动条
    [self addSubview:_scView];
    
    UIView *lineV1 = [[UIView alloc]init];
    lineV1.backgroundColor=Public_LineGray_Color;
    [self addSubview:lineV1];
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(48);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *lineV2 = [[UIView alloc]init];
    lineV2.backgroundColor=Public_LineGray_Color;
    [self addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(96);
        make.height.mas_equalTo(0.5);
    }];
    self.line2=lineV2;
}

//绘制UI
-(void)initUI
{
    for (UIView *view in _scView.subviews) {
        [view removeFromSuperview];
    }
    if (_typeViewArray.count==0) {
        self.line2.hidden=YES;
    }
    else
    {
        self.line2.hidden=NO;
    }

    CGRect rect=CGRectMake(0, 0, 0, 0);
    for (NSInteger i=0;i<_typeViewArray.count;i++)
    {
        UIButton *btn=[[UIButton alloc] init];
        btn.tag=100000+i;
        [btn setTitle:_typeViewArray[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:Public_DetailTextLabelColor forState:UIControlStateNormal];
        [btn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(rect.origin.x+rect.size.width,0,70,48)];
        btn.selected=NO;
        [_scView addSubview:btn];
        rect=btn.frame;
        
        if (i==0)
        {
            btn.selected=YES;
            self.selectedBtn=btn;
        }
    }
    _scView.contentSize = CGSizeMake(rect.origin.x+rect.size.width+20, _scView.frame.size.height);//设置滚动区域大小
}

//切换作品种类
-(void)btnClicked:(UIButton*)sender
{
    CGFloat width = UI_SCREEN_WIDTH/4;

    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame=CGRectMake(sender.frame.origin.x+(width-85)/2,45, 85, 3);
    }];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickWorkWithIndex:)])
    {
        [self.delegate clickWorkWithIndex:sender.tag-100];
    }
}

//点击了类型btn
-(void)typeBtnClick:(UIButton*)selectedBtn
{
    
    if (selectedBtn == _selectedBtn) {
        return;
    }
    
    //计算scrollview偏移量
    CGFloat originX = selectedBtn.center.x - CGRectGetMidX(_scView.frame);
    CGFloat maxOffsetX = _scView.contentSize.width - _scView.frame.size.width;
    if (originX < 0) {
        originX = 0;
    }else if (originX > maxOffsetX){
        originX = maxOffsetX;
    }
    [_scView setContentOffset:CGPointMake(originX, 0) animated:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        selectedBtn.selected=YES;
        self.selectedBtn.selected=NO;
    }];
    
    _selectedBtn = selectedBtn;
    
    _typeViewIndex=selectedBtn.tag-100000;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickTypeViewWithIndex:)])
    {
        [self.delegate clickTypeViewWithIndex:_typeViewIndex];
    }
}

- (void)moveSliderToPage:(NSInteger)page
{
    UIButton *selectedBtn = [_scView viewWithTag:page+100000];
    
    if (selectedBtn == _selectedBtn) {
        return;
    }
    
    //计算scrollview偏移量
    CGFloat originX = selectedBtn.center.x - CGRectGetMidX(_scView.frame);
    CGFloat maxOffsetX = _scView.contentSize.width - _scView.frame.size.width;
    if (originX < 0) {
        originX = 0;
    }else if (originX > maxOffsetX){
        originX = maxOffsetX;
    }
    [_scView setContentOffset:CGPointMake(originX, 0) animated:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        selectedBtn.selected=YES;
        self.selectedBtn.selected=NO;
    }];
    
    _selectedBtn = selectedBtn;
}

-(void)moveSlideWorkType:(NSInteger)page
{
    CGFloat width = UI_SCREEN_WIDTH/4;
    
    UIButton *sender = [self viewWithTag:page+100];

    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame=CGRectMake(sender.frame.origin.x+(width-85)/2,45, 85, 3);
    }];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickWorkWithIndex:)])
    {
        [self.delegate clickWorkWithIndex:sender.tag-100];
    }
}

@end
