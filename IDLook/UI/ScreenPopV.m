//
//  ScreenPopV.m
//  IDLook
//
//  Created by HYH on 2018/6/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ScreenPopV.h"
#import "ScreenPopVCM.h"
#import "ScreenSubV.h"

@interface ScreenPopV ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)UIScrollView *scrollV;
@property(nonatomic,strong)ScreenPopVCM *scm;

@end

@implementation ScreenPopV

- (id)init
{
    if(self=[super init])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(UI_SCREEN_WIDTH, 0,UI_SCREEN_WIDTH*0.8, UI_SCREEN_HEIGHT);
    }
    return self;
}

-(UIScrollView*)scrollV
{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, UI_SCREEN_WIDTH*0.8, UI_SCREEN_HEIGHT-20-45-SafeAreaTabBarHeight_IphoneX)];
        _scrollV.delegate = self;
        _scrollV.userInteractionEnabled=YES;
        _scrollV.pagingEnabled=NO;
        _scrollV.scrollEnabled = YES;
        _scrollV.backgroundColor = [UIColor clearColor];
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollV];
        _scrollV.alwaysBounceVertical=YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
        [_scrollV addGestureRecognizer:tap];
    }
    return _scrollV;
}

-(ScreenPopVCM*)scm
{
    if (!_scm) {
        _scm=[[ScreenPopVCM alloc]init];
        _scm.masteryType=self.type;
        [_scm refreshData];
    }
    return _scm;
}


- (void)showWithType:(NSInteger)type
{
    self.type=type;
    
    UIWindow *showWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    if(!showWindow)return;
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    [showWindow addSubview:self];
    self.maskV=maskV;
    
    [self initUI];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(UI_SCREEN_WIDTH*0.2, 0, UI_SCREEN_WIDTH*0.8,UI_SCREEN_HEIGHT);
    
    [UIView commitAnimations];
}

- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH*0.8,UI_SCREEN_HEIGHT);
    [UIView commitAnimations];
}

-(void)endEdit
{
    [self endEditing:YES];
}

- (void)initUI
{
    [self scrollV];
    [self initScrollView];
    
    UIButton *resetBtn=[[UIButton alloc]init];
    [self addSubview:resetBtn];
    resetBtn.layer.borderColor=Public_LineGray_Color.CGColor;
    resetBtn.layer.borderWidth=0.5;
    resetBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [resetBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-SafeAreaTabBarHeight_IphoneX);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH*0.32, 45));
    }];
    [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmBtn=[[UIButton alloc]init];
    [self addSubview:confirmBtn];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.backgroundColor=Public_Red_Color;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-SafeAreaTabBarHeight_IphoneX);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH*0.48, 45));
    }];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
}

//重置
-(void)resetAction
{
    for (ScreenSubV *subV in self.scrollV.subviews)
    {
        [subV allcCancleSelect];
    }
}

//确定
-(void)confirmAction
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    for (ScreenSubV *subV in self.scrollV.subviews)
    {
        NSString *tempString = [subV.selectArray componentsJoinedByString:@","];//分隔符逗号
        ScreenCellType type = subV.tag-100;

        if (type==ScreenCellTypeAge)
        {
            [dic setObject:tempString forKey:@"age"];
            if (([subV.minTextF.text integerValue]>[subV.maxTextF.text integerValue])&&[subV.maxTextF.text integerValue]>0) {
                [dic setObject:subV.maxTextF.text forKey:@"agestart"];
                [dic setObject:subV.minTextF.text forKey:@"ageend"];
            }
            else
            {
                [dic setObject:subV.minTextF.text forKey:@"agestart"];
                [dic setObject:subV.maxTextF.text forKey:@"ageend"];
            }

        }
        else if (type==ScreenCellTypePrice)
        {
            [dic setObject:tempString forKey:@"price"];
            if (([subV.minTextF.text integerValue]>[subV.maxTextF.text integerValue])&&[subV.maxTextF.text integerValue]>0) {
                [dic setObject:subV.maxTextF.text forKey:@"pricestart"];
                [dic setObject:subV.minTextF.text forKey:@"priceend"];
            }
            else
            {
                [dic setObject:subV.minTextF.text forKey:@"pricestart"];
                [dic setObject:subV.maxTextF.text forKey:@"priceend"];
            }
        }
        else if (type==ScreenCellTypeHeight)
        {
            [dic setObject:tempString forKey:@"height"];
            if (([subV.minTextF.text integerValue]>[subV.maxTextF.text integerValue])&&[subV.maxTextF.text integerValue]>0) {
                [dic setObject:subV.maxTextF.text forKey:@"heightstart"];
                [dic setObject:subV.minTextF.text forKey:@"heightend"];
            }
            else
            {
                [dic setObject:subV.minTextF.text forKey:@"heightstart"];
                [dic setObject:subV.maxTextF.text forKey:@"heightend"];
            }
        }
        else if (type==ScreenCellTypeWeight)
        {
            [dic setObject:tempString forKey:@"weight"];
            if (([subV.minTextF.text integerValue]>[subV.maxTextF.text integerValue])&&[subV.maxTextF.text integerValue]>0) {
                [dic setObject:subV.maxTextF.text forKey:@"weightstart"];
                [dic setObject:subV.minTextF.text forKey:@"weightend"];
            }
            else
            {
                [dic setObject:subV.minTextF.text forKey:@"weightstart"];
                [dic setObject:subV.maxTextF.text forKey:@"weightend"];
            }
        }
        else if (type==ScreenCellTypeRole)
        {
            [dic setObject:tempString forKey:@"role"];
        }
        
        else if (type==ScreenCellTypeAdv)
        {
            NSMutableArray *arr1=[NSMutableArray new];
            NSMutableArray *arr2=[NSMutableArray new];
            NSMutableArray *arr3=[NSMutableArray new];
            
            //将三种广告类型分开
            for (int i =0; i<subV.selectArray.count; i++)
            {
                NSInteger value = [subV.selectArray[i] integerValue];

                if (value<20) {
                    [arr1 addObject:subV.selectArray[i]];
                }
                else if (value<30)
                {
                    [arr2 addObject:subV.selectArray[i]];

                }
                else if (value<40)
                {
                    [arr3 addObject:subV.selectArray[i]];
                }
            }
            
            NSString *tempString1 = [arr1 componentsJoinedByString:@","];//分隔符逗号
            NSString *tempString2 = [arr2 componentsJoinedByString:@","];//分隔符逗号
            NSString *tempString3 = [arr3 componentsJoinedByString:@","];//分隔符逗号
            [dic setObject:tempString1 forKey:@"video"];
            [dic setObject:tempString2 forKey:@"print"];
            [dic setObject:tempString3 forKey:@"activity"];
        }
    }
    self.confrimBlock(dic);
    [self hide];
}

-(void)initScrollView
{
    CGFloat totalH = 20.0; //总高度
    for (int i =0; i<self.scm.ds.count; i++) {
        CGFloat height = [[(NSDictionary*) self.scm.ds[i] objectForKey:kScreenPopVCMCellHeight] floatValue];
        ScreenSubV *subV = [[ScreenSubV alloc]init];
        ScreenCellType  type= [[self.scm.ds[i] objectForKey:kScreenPopVCMCellType]integerValue];
        [subV reloadUIWithDic:self.scm.ds[i] withSelect:[self getSelectContentWithType:type]];
        subV.tag=100+type;
        [self.scrollV addSubview:subV];
        subV.frame=CGRectMake(0, totalH, UI_SCREEN_WIDTH*0.8, height);
        totalH+=height;
        
        if (type==ScreenCellTypePrice) {  //价格
            subV.minTextF.text=self.selectDic[@"pricestart"];
            subV.maxTextF.text=self.selectDic[@"priceend"];
        }
        else if (type==ScreenCellTypeAge)  //年龄
        {
            subV.minTextF.text=self.selectDic[@"agestart"];
            subV.maxTextF.text=self.selectDic[@"ageend"];
        }
        else if (type==ScreenCellTypeHeight)   //身高
        {
            subV.minTextF.text=self.selectDic[@"heightstart"];
            subV.maxTextF.text=self.selectDic[@"heightend"];
        }
        else if (type==ScreenCellTypeWeight)   //体重
        {
            subV.minTextF.text=self.selectDic[@"weightstart"];
            subV.maxTextF.text=self.selectDic[@"weightend"];
        }
    }
    self.scrollV.contentSize=CGSizeMake(0, totalH);
}

-(NSString*)getSelectContentWithType:(ScreenCellType)type
{
    if (type==ScreenCellTypeAge)
    {
        return self.selectDic[@"age"];
    }
    else if (type==ScreenCellTypePrice)
    {
        return self.selectDic[@"price"];
    }
    else if (type==ScreenCellTypeHeight)
    {
        return self.selectDic[@"height"];
    }
    else if (type==ScreenCellTypeWeight)
    {
        return self.selectDic[@"weight"];
    }
    else if (type==ScreenCellTypeRole)
    {
        return self.selectDic[@"role"];
    }
    else if (type==ScreenCellTypeAdv)
    {
        return [NSString stringWithFormat:@"%@,%@,%@",self.selectDic[@"video"],self.selectDic[@"print"],self.selectDic[@"activity"]];
    }
    return @"";
}

@end
