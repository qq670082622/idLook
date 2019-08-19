//
//  SearchMainTopV.m
//  IDLook
//
//  Created by HYH on 2018/6/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SearchMainTopV.h"
#import "ScreenSliderA.h"
#import "ScreenSliderB.h"

@interface SearchMainTopV ()
@property (nonatomic,strong)ScreenSliderA *sliderA;
@property (nonatomic,strong)ScreenSliderB *sliderB;
@end

@implementation SearchMainTopV

-(id)init
{
    if (self=[super init]) {
        
        self.frame=CGRectMake(0,0, UI_SCREEN_WIDTH, 45);
        
        self.clipsToBounds=YES;
        
        [self initType];
        
        UIView *lineV1 = [[UIView alloc]initWithFrame:CGRectMake(0,0 ,UI_SCREEN_WIDTH,0.5)];
        [self addSubview:lineV1];
        lineV1.backgroundColor=Public_LineGray_Color;
        
        UIView *lineV2 = [[UIView alloc]initWithFrame:CGRectMake(0,45,UI_SCREEN_WIDTH,0.5)];
        [self addSubview:lineV2];
        lineV2.backgroundColor=Public_LineGray_Color;

    }
    return self;
}


-(void)initType
{
    UIButton *screenBtn=[[UIButton alloc]init];
    [self addSubview:screenBtn];
    screenBtn.tag=101;
    screenBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14.0];
    [screenBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
    [screenBtn setBackgroundColor:[UIColor whiteColor]];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-5);
        make.top.mas_equalTo(self).offset(2);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(90);
    }];
    [screenBtn addTarget:self action:@selector(screenAction) forControlEvents:UIControlEventTouchUpInside];
    
    screenBtn.selected=YES;
    screenBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
    
    [screenBtn setImage:[UIImage imageNamed:@"search_icon_small"] forState:UIControlStateNormal];
    [screenBtn setImage:[UIImage imageNamed:@"search_icon_small"] forState:UIControlStateSelected];
    screenBtn.titleLabel.backgroundColor = screenBtn.backgroundColor;
    screenBtn.imageView.backgroundColor = screenBtn.backgroundColor;
    //在使用一次titleLabel和imageView后才能正确获取titleSize
    CGSize titleSize = screenBtn.titleLabel.bounds.size;
    CGSize imageSize = screenBtn.imageView.bounds.size;
    CGFloat interval = 1.0;
    screenBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    screenBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH-90,16,1,13)];
    [self addSubview:lineV];
    lineV.backgroundColor=Public_LineGray_Color;

    NSDictionary *dic =[UserInfoManager getPublicConfig];
    NSArray *array1 = dic[@"categoryType"];
    
    NSMutableArray *typeArray = [NSMutableArray new];
    [typeArray addObject:@"全部"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dicA =array1[i];
        [typeArray addObject:dicA[@"catename"]];
    }
    
    NSMutableArray *subTypeArray = [NSMutableArray new];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dicA =array1[i];
        NSDictionary *dicB=dicA[@"attribute"];
        NSArray *arr = dicB[@"performingType"];
        NSMutableArray *SubArr = [NSMutableArray new];
        for (int j=0; j<arr.count; j++) {
            NSDictionary *dicD = arr[j];
            [SubArr addObject:dicD[@"attrname"]];
        }
        [subTypeArray addObject:SubArr];
    }
    
    ScreenSliderA *sliderA =[[ScreenSliderA alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH-90, 45)];
    sliderA.typeViewArray=typeArray;
    [self addSubview:sliderA];
    WeakSelf(self);
    sliderA.ScreeSliderAClick = ^(NSInteger index) {
        if (index==0) {
            self.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, 45);
            weakself.sliderB.hidden=YES;
        }
        else
        {
            self.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, 45+50);
            weakself.sliderB.hidden=NO;
            weakself.sliderB.typeViewArray = subTypeArray[index-1];
        }
        if (self.SearchMainTopAgeTypeClick) {
            self.SearchMainTopAgeTypeClick(index);
        }
    };
    self.sliderA=sliderA;
    
    ScreenSliderB *sliderB =[[ScreenSliderB alloc]initWithFrame:CGRectMake(0,45, UI_SCREEN_WIDTH, 50)];
    sliderB.typeViewArray=typeArray;
    [self addSubview:sliderB];
    sliderB.ScreeSliderBClick = ^(NSString *content) {
        if (self.SearchMainTopImageTypeClick) {
            self.SearchMainTopImageTypeClick(content);
        }
    };
    sliderB.hidden=YES;
    self.sliderB=sliderB;
}

//筛选
-(void)screenAction
{
    if (self.SearchMainTopVBlock) {
        self.SearchMainTopVBlock();
    }
}

@end
