//
//  SearchHeadView.m
//  IDLook
//
//  Created by HYH on 2018/5/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SearchHeadView.h"

@interface SearchHeadView ()
@property (nonatomic,strong)NSArray *typeArray;
@property (nonatomic,strong)SearchStrucM *scm;
@property (nonatomic,assign)ArtistType artType;


@end

@implementation SearchHeadView

-(id)initUIWithArtistType:(ArtistType)type withSCM:(SearchStrucM *)scm
{
    if (self=[super init]) {
        
        self.scm=scm;
        
        self.artType=type;
    
        self.typeArray= [scm getArtistArrayWithType:type];
        
        CGFloat height  = [scm heightOfHeadViewWithType:type];
        
        self.frame=CGRectMake(0,0, UI_SCREEN_WIDTH, height);
        
        [self initType];
        
        [self initCondition];

    }
    return self;
}

-(void)initType
{
    NSArray *array = [self.scm getArtistArrayWithType:self.artType];
    CGFloat width = (UI_SCREEN_WIDTH-30-12*3)/4;

    for (int i =0; i<array.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [self addSubview:button];
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=3.0;
        button.layer.borderColor=[UIColor colorWithHexString:@"#CCCCCC"].CGColor;
        button.layer.borderWidth=0.5;
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15+(width+12)*(i%4));
            make.top.mas_equalTo(self).offset(12+(i/4)*44);
            make.size.mas_equalTo(CGSizeMake(width, 32));
        }];
        
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0,self.bounds.size.height-46 ,UI_SCREEN_WIDTH,0.5)];
    [self addSubview:lineV];
    lineV.backgroundColor=Public_LineGray_Color;
}


-(void)initCondition
{
    NSArray *array = [self.scm getConditionArrayWithType:self.artType];
    NSInteger count = array.count;
    CGFloat width = UI_SCREEN_WIDTH/count;
    for (int i=0 ; i<count; i++) {
        NSDictionary *dic = array[i];
        UIButton *conditionBtn=[[UIButton alloc]init];
        conditionBtn.frame=CGRectMake(width*i,self.bounds.size.height-45,width,45);
        [self addSubview:conditionBtn];
        conditionBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [conditionBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [conditionBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [conditionBtn setImage:[UIImage imageNamed:@"icon_down_arrow"] forState:UIControlStateNormal];
        [conditionBtn setImage:[UIImage imageNamed:@"icon_up_arrow"] forState:UIControlStateSelected];
        [conditionBtn setTitle:dic[@"title"] forState:UIControlStateNormal];

        conditionBtn.titleLabel.backgroundColor = conditionBtn.backgroundColor;
        conditionBtn.imageView.backgroundColor = conditionBtn.backgroundColor;
        //在使用一次titleLabel和imageView后才能正确获取titleSize
        CGSize titleSize = conditionBtn.titleLabel.bounds.size;
        CGSize imageSize = conditionBtn.imageView.bounds.size;
        CGFloat interval = 1.0;
        conditionBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        conditionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
        
        conditionBtn.backgroundColor=[UIColor whiteColor];
        conditionBtn.tag=i+1000;
        [conditionBtn addTarget:self action:@selector(condition:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(width*i-0.5,self.bounds.size.height-45 +16 ,0.5,13)];
        [self addSubview:lineV];
        lineV.backgroundColor=Public_LineGray_Color;
    
    }
}

-(void)condition:(UIButton*)sender
{
    
    NSArray *array = [self.scm getConditionArrayWithType:self.artType];
    for (int i =0 ; i<array.count; i++) {
        UIButton * button = (UIButton*)[self viewWithTag:1000+i];
        if (i==sender.tag-1000) {
            sender.selected=!sender.selected;
//            button.selected=YES;
        }
        else
        {
            button.selected=NO;
        }
    }
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchWithConditionWithDic:withSelect:)]) {
        [self.delegate searchWithConditionWithDic:array[sender.tag-1000] withSelect:sender.selected];
    }
}

-(void)clickType:(UIButton*)sender
{
    NSArray *array = [self.scm getArtistArrayWithType:self.artType];

    for (int i = 0; i<array.count; i++) {
        UIButton * button = (UIButton*)[self viewWithTag:100+i];
        if (i==sender.tag-100) {
            [button setBackgroundColor:Public_Red_Color];
            button.selected=YES;
        }
        else
        {
            [button setBackgroundColor:[UIColor whiteColor]];
            button.selected=NO;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchWithCategory:)]) {
        [self.delegate searchWithCategory:array[sender.tag-100]];
    }
}

-(void)reloadConditWithContent:(NSString *)string withSearchConditionType:(SearchConditionType)type
{
    NSArray *array = [self.scm getConditionArrayWithType:self.artType];

    for (int i =0 ; i<array.count; i++) {
        NSDictionary *dic = array[i];
        if ([dic[@"type"]integerValue]==type) {
            UIButton * button = (UIButton*)[self viewWithTag:1000+i];
            [button setTitle:string forState:UIControlStateNormal];
            
            //重新设置图片偏移
            button.titleLabel.backgroundColor = button.backgroundColor;
            button.imageView.backgroundColor = button.backgroundColor;
            //在使用一次titleLabel和imageView后才能正确获取titleSize
            CGSize titleSize = button.titleLabel.bounds.size;
            CGSize imageSize = button.imageView.bounds.size;
            CGFloat interval = 1.0;
            button.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
        }
    }
}

@end
