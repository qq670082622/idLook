//
//  PricePreviewPopV.m
//  IDLook
//
//  Created by HYH on 2018/7/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PricePreviewPopV.h"
#import "PreviewSubVB.h"
#import "AddPriceFootV.h"
#import "AddPriceModel.h"
#import "PreviewSubVA.h"

@interface PricePreviewPopV ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)UIScrollView *scrollV;
@property(nonatomic,strong)UILabel *totlePriceLab;
@property(nonatomic,strong)PreviewSubVB *subB;
@end

@implementation PricePreviewPopV

- (id)init
{
    if(self=[super init])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 500);
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=10.0;
        self.userInteractionEnabled=YES;
    }
    return self;
}

- (void)showWithTitle:(NSString *)title
{
    
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
    
    [self initUIWithTitle:title];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    NSLog(@"safe is %d",SafeAreaTabBarHeight_IphoneX);
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-490-SafeAreaTabBarHeight_IphoneX, UI_SCREEN_WIDTH,500);
    
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
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 500);
    [UIView commitAnimations];
    
    [self resetData];
}


- (void)initUIWithTitle:(NSString*)title
{

    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(20);
    }];
    titleLab.text =title;
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setImage:[UIImage imageNamed:@"price_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.right.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UIButton *generateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [generateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [generateBtn setTitle:@"生成报价" forState:UIControlStateNormal];
    generateBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    generateBtn.backgroundColor=Public_Red_Color;
    [generateBtn addTarget:self action:@selector(generatePriceAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:generateBtn];
    [generateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(150, 50));
        make.right.equalTo(self);
    }];
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.font = [UIFont systemFontOfSize:15.0];
    priceLab.textColor = [UIColor colorWithHexString:@"#666666"];
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(generateBtn);
        make.left.mas_equalTo(self).offset(15);
    }];
    self.totlePriceLab=priceLab;

    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, UI_SCREEN_WIDTH, 500-50-60)];
    scrollV.delegate = self;
    scrollV.pagingEnabled=NO;
    scrollV.scrollEnabled = YES;
    scrollV.backgroundColor = Public_Background_Color;
    scrollV.showsHorizontalScrollIndicator = YES;
    scrollV.showsVerticalScrollIndicator = YES;
    scrollV.userInteractionEnabled=YES;
    [self addSubview:scrollV];

    self.scrollV=scrollV;
    self.scrollV.contentSize=CGSizeMake(UI_SCREEN_WIDTH, 180*4+140+75);
    [self initScrollView];
    
    [self refreshUI];
}

-(void)initScrollView
{
    NSArray *titleArray=self.dsm.titleArray;
    for (int i =0; i<self.dsm.ds.count; i++)
    {
        NSArray *array = self.dsm.ds[i];
        PreviewSubVA *subV=[[PreviewSubVA alloc]initWithFrame:CGRectMake(0,180*i,UI_SCREEN_WIDTH,180)];
        subV.tag=10+i;
        [subV reloadUIWithArray:array withTitle:titleArray[i] withIndex:i];
        subV.backgroundColor=[UIColor whiteColor];
        [self.scrollV addSubview:subV];
        WeakSelf(self);
        subV.clickTypeWithTag = ^(NSInteger tag) {
            [weakself clickWithType:i withTag:tag];
        };
    }
    
    NSArray *array = @[@{@"title":@"拍摄费用",@"content":@"¥5000x2天"},
                       @{@"title":@"异地拍摄费用",@"content":@"¥0"},
                       @{@"title":@"肖像年限费用",@"content":@"¥0"},
                       @{@"title":@"肖像范围费用",@"content":@"¥0"}];
    PreviewSubVB *subB=[[PreviewSubVB alloc]initWithFrame:CGRectMake(0,180*4, UI_SCREEN_WIDTH, 140+75)];
    subB.backgroundColor=[UIColor clearColor];
    [subB reloadUIWithArray:array];
    [self.scrollV addSubview:subB];
    self.subB=subB;
}

//生成报价
- (void)generatePriceAction
{
    [self hide];
    self.getPriceBlock();
}

//点击不同类型
-(void)clickWithType:(NSInteger)type withTag:(NSInteger)tag
{
    for (int i =0; i<self.dsm.ds.count; i++)
    {
        NSArray *array = self.dsm.ds[i];
        for (int j=0; j<array.count; j++) {
            AddPriceModel *model =array[j];
            if (i==type) {
                if (j==tag) {
                    model.isSelect=YES;
                }
                else
                {
                    model.isSelect=NO;
                }
            }
        }
    }
    [self refreshUI];
}


//刷新ui
-(void)refreshUI
{
    CGFloat totalPrice =[self CalculationTotalPrice];

    NSString *str;
    if (totalPrice<0) {
        str = [NSString stringWithFormat:@"到手价：商议价"];
    }
    else
    {
        str = [NSString stringWithFormat:@"到手价：¥%d",(int)(totalPrice)];
    }
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0]} range:NSMakeRange(4,str.length-4)];
    self.totlePriceLab.attributedText=attStr;
    
    NSMutableArray *priceArray=[NSMutableArray new];
    for (int i =0; i<self.dsm.ds.count; i++)
    {
        NSArray *array = self.dsm.ds[i];
        for (int j=0; j<array.count; j++) {
            AddPriceModel *model =array[j];
            if (model.isSelect==YES) {
                if (i==0) {
                    [priceArray addObject:[NSString stringWithFormat:@"¥%ld(%d天)",model.price,j+1]];
                }
                else
                {
                    [priceArray addObject:[NSString stringWithFormat:@"¥%ld",model.price]];
                }
            }
        }
    }
    
    if (totalPrice<0) {
        self.scrollV.contentSize=CGSizeMake(UI_SCREEN_WIDTH, 180*4+75);
        self.subB.frame=CGRectMake(0,180*4, UI_SCREEN_WIDTH, 75);
        [self.subB refreshUIWithArray:priceArray withShowBG:NO];
    }
    else
    {
        self.scrollV.contentSize=CGSizeMake(UI_SCREEN_WIDTH, 180*4+140+75);
        self.subB.frame=CGRectMake(0,180*4, UI_SCREEN_WIDTH, 140+75);
        [self.subB refreshUIWithArray:priceArray withShowBG:YES];
    }
}


//计算总价
-(CGFloat)CalculationTotalPrice
{
    CGFloat totalPrice =0.00;
    BOOL isUnknowPrice=NO;  //是否商议价
    for (int i =0; i<self.dsm.ds.count; i++)
    {
        NSArray *array = self.dsm.ds[i];
        for (int j=0; j<array.count; j++) {
            AddPriceModel *model =array[j];
            if (model.isSelect) {
                totalPrice+=model.price;
                if (model.price<0) {
                    isUnknowPrice=YES;
                }
            }
        }
    }
    
    if (isUnknowPrice==YES) {
        totalPrice=-1;
    }
    return totalPrice;
}

//重置数据
-(void)resetData
{
    for (int i =0; i<self.dsm.ds.count; i++)
    {
        NSArray *array = self.dsm.ds[i];
        for (int j=0; j<array.count; j++) {
            AddPriceModel *model =array[j];
            model.isSelect=NO;
        }
    }
}
@end
