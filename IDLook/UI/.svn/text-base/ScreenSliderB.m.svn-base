//
//  ScreenSliderB.m
//  IDLook
//
//  Created by HYH on 2018/7/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ScreenSliderB.h"

@interface ScreenSliderB ()
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIScrollView *scView;
@end

@implementation ScreenSliderB

-(void)setTypeViewArray:(NSArray *)typeViewArray
{
    _typeViewArray=typeViewArray;
    [self initUI];
}

-(UIScrollView*)scView
{
    if (!_scView) {
        _scView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45)];
        _scView.backgroundColor=[UIColor whiteColor];
        _scView.scrollEnabled = YES;//设置是否支持滚动
        _scView.showsHorizontalScrollIndicator = NO;//设置是否显示水平滚动条
        [self addSubview:_scView];
    }
    return  _scView;
}

//绘制UI
-(void)initUI
{
    for (UIView *view in self.scView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.scView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    CGRect rect=CGRectMake(0, 0, 0, 0);
    for (NSInteger i=0;i<_typeViewArray.count;i++)
    {
        UIButton *btn=[[UIButton alloc] init];
        btn.tag=100000+i;
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=4.0;
        [btn setTitle:_typeViewArray[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [btn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [btn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(rect.origin.x+rect.size.width+20,9, [self autoLblWidth:btn.titleLabel]+50, 32)];
        btn.selected=NO;
        btn.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
        [self.scView addSubview:btn];
        rect=btn.frame;

    }
    self.scView.contentSize = CGSizeMake(rect.origin.x+rect.size.width+20, self.scView.frame.size.height);//设置滚动区域大小
    
}

//点击了类型btn
-(void)typeBtnClick:(UIButton*)selectedBtn
{
//    if (selectedBtn == _selectedBtn) {
//        return;
//    }
    
    //计算scrollview偏移量
    CGFloat originX = selectedBtn.center.x - CGRectGetMidX(self.scView.frame);
    CGFloat maxOffsetX = self.scView.contentSize.width - self.scView.frame.size.width;
    if (originX < 0) {
        originX = 0;
    }else if (originX > maxOffsetX){
        originX = maxOffsetX;
    }
    [self.scView setContentOffset:CGPointMake(originX, 0) animated:YES];
    
    selectedBtn.selected=YES;
    selectedBtn.backgroundColor=[Public_Red_Color colorWithAlphaComponent:0.2];
    
    self.selectedBtn.selected=NO;
    self.selectedBtn.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
    
    if (selectedBtn!=_selectedBtn) {
        self.selectedBtn = selectedBtn;
        if (self.ScreeSliderBClick) {
            self.ScreeSliderBClick(self.selectedBtn.titleLabel.text);
        }
    }
    else
    {
        self.selectedBtn=nil;
        if (self.ScreeSliderBClick) {
            self.ScreeSliderBClick(@"");
        }
    }
}

//lbl自动宽的标题栏view
- (CGFloat)autoLblWidth:(UILabel*)label
{
    NSDictionary *attribute = @{NSFontAttributeName:label.font};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, label.frame.size.height)
                                           options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    return size.width;
}


@end
