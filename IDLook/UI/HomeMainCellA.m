//
//  HomeMainCellA.m
//  IDLook
//
//  Created by HYH on 2018/7/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeMainCellA.h"
#import "UIImage+GIF.h"

@interface HomeMainCellA ()
@property(nonatomic,strong)UIImageView *entryV;
@property(nonatomic,strong)UIImageView *titleV;
@end

@implementation HomeMainCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
#if 0
    NSArray *array1 = @[@{@"title":@"微代言",@"image":@"home_endor"},
                       @{@"title":@"微出镜",@"image":@"home_mirr"},
                       @{@"title":@"招商项目",@"image":@"home_project"}];
    CGFloat width1= (UI_SCREEN_WIDTH-30-2*9)/3;
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:100+i];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:button];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15+(width1+9)*i);
            make.top.mas_equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(width1, 48));
        }];
        [button addTarget:self action:@selector(buttionClick1:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    NSArray *array2 = @[@{@"title":@"视频演员",@"image":@"home_01"},
                        @{@"title":@"平面演员",@"image":@"home_02"},
                        @{@"title":@"活动模特",@"image":@"home_03"},
//                        @{@"title":@"舞蹈特技",@"image":@"home_icon_04"},
//                        @{@"title":@"明星",@"image":@"home_icon_05"},
//                        @{@"title":@"网红",@"image":@"home_icon_06"},
//                        @{@"title":@"运动腕",@"image":@"home_icon_07"},
//                        @{@"title":@"社会特型",@"image":@"home_icon_09"}
                        ];
    CGFloat width2= UI_SCREEN_WIDTH/3;
    CGFloat spec =(UI_SCREEN_WIDTH - 95*3)/4;  //button间距
    
    for (int i=0; i<array2.count; i++) {
        NSDictionary *dic = array2[i];
        UIButton *button=[[UIButton alloc]init];
        [self.contentView addSubview:button];
        button.tag=1000+i;
        button.titleLabel.font=[UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor colorWithHexString:@"#2E0909"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset( spec*(i+1)+i%3*95);
            make.top.mas_equalTo(self.contentView).offset(5+i/3*95);
            make.size.mas_equalTo(CGSizeMake(95, 95));
        }];
        button.titleEdgeInsets=UIEdgeInsetsMake(40, 0,-40, 0);
//        button.backgroundColor=[UIColor redColor];
        
        [button addTarget:self action:@selector(buttionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
#endif

    UIImageView *entryV=[[UIImageView alloc]init];
    [self.contentView addSubview:entryV];
    entryV.userInteractionEnabled=YES;
//    entryV.contentMode=UIViewContentModeScaleAspectFill;
    [entryV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(25);
        make.centerX.mas_equalTo(self.contentView).offset(0);
        make.size.mas_equalTo(CGSizeMake((UI_SCREEN_WIDTH-40), (UI_SCREEN_WIDTH-40)*13.0/68.0));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(entryMoreRecommend)];
    [entryV addGestureRecognizer:tap];

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"home_tab_switch_icon" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];    
    entryV.image = image;
    self.entryV=entryV;

    
    UIImageView *titleV=[[UIImageView alloc]init];
    [self.contentView addSubview:titleV];
    titleV.image=[UIImage imageNamed:@"home_actor_banner"];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentMode).offset(-15);
        make.centerX.mas_equalTo(self.contentView).offset(0);
    }];
    self.titleV =titleV;
    
}


-(void)reloadUI
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"home_tab_switch_icon" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
    self.entryV.image=image;
    self.titleV.image=[UIImage imageNamed:@"home_actor_banner"];
}

-(void)buttionClick1:(UIButton*)sender
{
    self.clickType1Block(sender.tag-100);
}

-(void)buttionClick:(UIButton*)sender
{
    self.clickType2Block(sender.tag-1000);
}

-(void)entryMoreRecommend
{
    self.EntryMoreRecommendBlock();
}


@end
