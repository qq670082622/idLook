//
//  VideoListTopV.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoListTopV.h"

@interface VideoListTopV ()
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation VideoListTopV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        self.dataSource =[NSMutableArray new];
        
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    NSArray *array = @[@{@"title":@"综合排序",@"title1":@"综合排序",@"title2":@"综合排序"},
                       @{@"title":@"报价",@"title1":@"报价高→低",@"title2":@"报价低→高"},
                       @{@"title":@"筛选",@"title1":@"筛选",@"title2":@"筛选",@"url":@"search_icon_small"}];
    
    [self.dataSource removeAllObjects];
    for (int i=0; i<array.count; i++) {
        ButtonModel *model = [[ButtonModel alloc]initWithDic:array[i]];
        [self.dataSource addObject:model];
        if (i==0) {
            model.state=1;
        }
    }
    
    CGFloat width = UI_SCREEN_WIDTH/3;
    for (int i =0; i<self.dataSource.count; i++) {
        ButtonModel *model = self.dataSource[i];
        UIButton *button=[[UIButton alloc]init];
        [self addSubview:button];
        button.tag=1000+i;
        button.layer.borderWidth=0.5;
        button.layer.borderColor=Public_LineGray_Color.CGColor;
        button.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [button setTitleColor:Public_Text_Color forState:UIControlStateSelected];

        [button setImage:[UIImage imageNamed:model.url] forState:UIControlStateNormal];
        [button setTitle:model.title forState:UIControlStateNormal];
        button.frame=CGRectMake(width*i, 0, width,48);
        [button addTarget:self action:@selector(buttionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.titleLabel.backgroundColor = button.backgroundColor;
        button.imageView.backgroundColor = button.backgroundColor;
        //在使用一次titleLabel和imageView后才能正确获取titleSize
        CGSize titleSize = button.titleLabel.bounds.size;
        CGSize imageSize = button.imageView.bounds.size;
        CGFloat interval = 1.0;
        button.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
    
    }
    [self fixButtonImageWithTag:0];
}

-(void)buttionClick:(UIButton*)sender
{
    if (sender.tag<1002)
    {
        for (int i=0; i<self.dataSource.count-1; i++)
        {
            ButtonModel *model = self.dataSource[i];
            if (i==sender.tag-1000) {
                if (model.state==0) {
                    model.state=1;
                }
                else if (model.state==1)
                {
                    model.state=2;
                }
                else if (model.state==2)
                {
                    model.state=1;
                }
            }
            else
            {
                model.state=0;
            }
            [self fixButtonImageWithTag:i];
        }
        if (self.selectWithType) {
            self.selectWithType(sender.tag-1000);
        }
    }
    else
    {
        if (self.screenAction) {
            self.screenAction();
        }
    }


}

//改变按钮的图片
-(void)fixButtonImageWithTag:(NSInteger)tag
{
    for (int i =0; i<self.dataSource.count-1; i++) {
        UIButton *btn = (UIButton*)[self viewWithTag:1000+i];
        ButtonModel *model = self.dataSource[i];
        if (model.state==0) {
            [btn setTitle:model.title forState:UIControlStateNormal];
            [btn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
            [btn setTitleColor:Public_Text_Color forState:UIControlStateSelected];
        }
        else if (model.state==1)
        {
            [btn setTitle:model.title1 forState:UIControlStateNormal];
            [btn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
            [btn setTitleColor:Public_Red_Color forState:UIControlStateSelected];

        }
        else if (model.state==2)
        {
            [btn setTitle:model.title2 forState:UIControlStateNormal];
            [btn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
            [btn setTitleColor:Public_Red_Color forState:UIControlStateSelected];

        }
    }
}

-(void)reloadFirstConditionWithSelect:(NSInteger)select
{
    UIButton *button = (UIButton*)[self viewWithTag:1000];
    if (select==0) {
        [button setTitle:@"综合" forState:UIControlStateNormal];
    }
    else if (select==1)
    {
        [button setTitle:@"竞争力" forState:UIControlStateNormal];
    }
    else if (select==2)
    {
        [button setTitle:@"颜值" forState:UIControlStateNormal];
    }
    
    button.titleLabel.backgroundColor = button.backgroundColor;
    button.imageView.backgroundColor = button.backgroundColor;
    //在使用一次titleLabel和imageView后才能正确获取titleSize
    CGSize titleSize = button.titleLabel.bounds.size;
    CGSize imageSize = button.imageView.bounds.size;
    CGFloat interval = 1.0;
    button.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
}

@end

@implementation ButtonModel

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.title = (NSString *)safeObjectForKey(dic, @"title");
        self.url = (NSString *)safeObjectForKey(dic, @"url");
        self.title1 = (NSString *)safeObjectForKey(dic, @"title1");
        self.title2 = (NSString *)safeObjectForKey(dic, @"title2");
    }
    return self;
}

@end