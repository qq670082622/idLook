//
//  AssetsSelectV.m
//  IDLook
//
//  Created by HYH on 2018/5/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AssetsSelectV.h"

@implementation AssetsSelectV

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.layer.borderColor=Public_LineGray_Color.CGColor;
        self.layer.borderWidth=0.5;
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    NSArray *array = @[@"近三个月",@"全部分类"];
    NSInteger count = array.count;
    CGFloat width = UI_SCREEN_WIDTH/count;
    for (int i=0 ; i<count; i++) {
        UIButton *conditionBtn=[[UIButton alloc]init];
        conditionBtn.frame=CGRectMake(width*i,0,width,50);
        [self addSubview:conditionBtn];
        conditionBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [conditionBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [conditionBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [conditionBtn setImage:[UIImage imageNamed:@"icon_down_arrow"] forState:UIControlStateNormal];
        [conditionBtn setImage:[UIImage imageNamed:@"icon_up_arrow"] forState:UIControlStateSelected];
        [conditionBtn setTitle:array[i] forState:UIControlStateNormal];
        
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
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(width*i-0.5,18,0.5,13)];
        [self addSubview:lineV];
        lineV.backgroundColor=Public_LineGray_Color;
    }
}

-(void)condition:(UIButton*)sender
{
    
    NSArray *array = @[@"近三个月",@"全部分类"];
    for (int i =0 ; i<array.count; i++) {
        UIButton * button = (UIButton*)[self viewWithTag:1000+i];
        if (i==sender.tag-1000) {
            sender.selected=!sender.selected;
        }
        else
        {
            button.selected=NO;
        }
    }
    
    self.AssetsSelectVClick(sender.tag-1000,sender.selected);
}

-(void)reloadConditWithContent:(NSString *)string withSearchConditionType:(NSInteger)type
{
    if (string.length==0) {
        return;
    }
    
    NSArray *array = @[@"近三个月",@"全部分类"];

    for (int i =0 ; i<array.count; i++) {
        if (i==type&&string.length>0) {
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

-(void)setNormalButtonWithType:(NSInteger)type
{
    UIButton * button = (UIButton*)[self viewWithTag:1000+type];
    button.selected=NO;
}

-(NSString*)getSelectButtonTitle:(NSInteger)type
{
    UIButton * button = (UIButton*)[self viewWithTag:1000+type];
    return button.titleLabel.text;
}

@end
