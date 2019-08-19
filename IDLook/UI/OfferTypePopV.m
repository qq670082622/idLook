//
//  OfferTypePopV.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OfferTypePopV.h"
#import "PriceModel.h"
#import "AddPriceSubV.h"
#import "PlaceOrderModel.h"
@interface OfferTypePopV ()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)NSMutableArray *dataS;
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,assign)NSInteger select;
@end

@implementation OfferTypePopV

-(NSMutableArray*)dataS
{
    if (!_dataS) {
        _dataS=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataS;
}

- (id)init
{
    if(self=[super init])
    {
        self.select=-1;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    }
    return self;
}

- (void)showOfferTypeWithPriceList:(NSArray *)list withContent:(NSString *)content
{

    for (int i=0; i<list.count; i++) {
        PriceModel *model = [[PriceModel alloc]initWithDic:list[i]];
        [self.dataS addObject:model];
        if ([model.title isEqualToString:content]) {
            self.select=i;
        }
    }
    Vheight = 80+(self.dataS.count/3+1)*60;
    
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
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
    
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
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    [UIView commitAnimations];
}


- (void)initUI
{
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:14.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(14);
        make.left.mas_equalTo(self).offset(15);
    }];
    titleLab.text=@"选择报价类别";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab).offset(0);
        make.right.equalTo(self).offset(-15);
    }];
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(45);
        make.height.mas_equalTo(0.5);
    }];

    CGFloat width = (UI_SCREEN_WIDTH-30-20)/3;
    
    for (int i =0; i<self.dataS.count; i++) {
        PriceModel *model =self.dataS[i];
        AddPriceSubV *subV= [[AddPriceSubV alloc]init];
        subV.tag=100+i;
        [self addSubview:subV];
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(66+60*(i/3));
            make.left.mas_equalTo(self).offset(15+(width+10)*(i%3));
            make.size.mas_equalTo(CGSizeMake(width, 50));
        }];
        subV.title=model.title;
        
        subV.imageN=@"price_bg4";
        
        subV.titleColor=[UIColor colorWithHexString:@"#999999"];
        subV.priceColor=Public_Text_Color;
        
        WeakSelf(self);
        subV.clickWithTag = ^(NSInteger tag) {
            [weakself clickActionWithTag:tag];
        };
        
        subV.price=[NSString stringWithFormat:@"%.f元",[PlaceOrderModel getRatioWithSinglePrice:model.price]*model.price+150];
        
        if (i==self.select) {
            subV.imageN=@"price_bg2_click";
            subV.titleColor=[UIColor whiteColor];
            subV.priceColor=Public_Red_Color;
        }
    }
}

- (void)confirmSelected
{
    [self hide];
}

-(void)clickActionWithTag:(NSInteger)tag
{
    NSString *imageN=@"price_bg4";
    NSString *imageH=@"price_bg2_click";
    PriceModel *model = self.dataS[tag-100];
    for (int i =0; i<self.dataS.count; i++)
    {
        AddPriceSubV *subV = [self viewWithTag:100+i];
        if (i==tag-100)
        {
            subV.imageN=imageH;
            subV.titleColor=[UIColor whiteColor];
            subV.priceColor=Public_Red_Color;
            subV.isSelect=YES;
        }
        else
        {
            subV.imageN=imageN;
            subV.titleColor=[UIColor colorWithHexString:@"#999999"];
            subV.priceColor=Public_Text_Color;
            subV.isSelect=NO;
        }
    }
    self.typeSelectAction(model.title, model.type, model.subType);
    [self hide];
}

@end
