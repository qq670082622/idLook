//
//  CustomNavVC.m
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CustomNavVC.h"

@interface CustomNavVC ()<UINavigationControllerDelegate,
UIGestureRecognizerDelegate>

@end

@implementation CustomNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[UINavigationBar appearance]  setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
//    [UINavigationBar appearance].barTintColor=[UIColor whiteColor];
    
//    UIImage *image = [UIImage imageNamed:@"top_pressed"];  //nav_black_bg
//    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
//    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//
//    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"tabbar_empty"]];
//
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//
//
//    self.delegate=self;
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = self;
//    }
    
    self.delegate = self;
    
    UIImage *image = [UIImage imageNamed:@"top_pressed"];  
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"tabbar_empty"]];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }

}


//黑色标题
+(UILabel *)setDefaultNavgationItemTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    label.numberOfLines = 0;
    label.textColor = Public_Text_Color;
    label.text = title;
    label.font = [UIFont systemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

//富文本标题
+(UILabel *)setAttributeNavgationItemTitle1:(NSString *)title1 withTitle2:(NSString*)title2
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithHexString:@"#000000"];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    
    NSString *str=[NSString stringWithFormat:@"%@%@",title1,title2];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} range:NSMakeRange(title1.length,title2.length)];
    label.attributedText=attStr;
    
    return label;
}


//白色标题
+(UILabel*)setWhiteNavgationItemTitle:(NSString*)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

//黑色返回键
+ (UIButton *)getLeftDefaultButtonWithTarget:(id)target
                                      action:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 60, 48);
    [button setImage:[UIImage imageNamed:@"btn_public_back_n"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"btn_public_back_n"] forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateHighlighted];
    [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [button setTitleColor:Public_Text_Color forState:UIControlStateHighlighted];
    button.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [button setImageEdgeInsets:UIEdgeInsetsMake(1, -13, -1, 13)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-13, 0,13)];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor=[UIColor redColor];
    
    //粗体
    if (IsBoldSize()) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0,-7,0,7);
    }
    
    return button;
}


//白色返回键
+ (UIButton *)getLeftDefaultWhiteButtonWithTarget:(id)target
                                           action:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 60, 48);
    [button setImage:[UIImage imageNamed:@"u_info_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"u_info_back_white"] forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [button setImageEdgeInsets:UIEdgeInsetsMake(1, -13, -1, 13)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-13, 0,13)];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    //    button.backgroundColor=[UIColor redColor];
    
    //粗体
    if (IsBoldSize()) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0,-7,0,7);
    }
    
    return button;
}

//白色返回键(有背景圈)
+ (UIButton *)getLeftWhiteButtonWithTarget:(id)target
                                    action:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35,35);
    button.layer.masksToBounds=YES;
    button.layer.cornerRadius=17.5;
    button.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
    [button setImage:[UIImage imageNamed:@"u_info_back_white"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"u_info_back_white"] forState:UIControlStateHighlighted];
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(1, 16, -1, -16)];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

//右边文字按钮
+ (UIButton *)getRightDefaultButtionWithTitle:(NSString *)title
                                       Target:(id)target
                                       action:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 48, 48);
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [button setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//首页搜索栏
+(UIView*)getHomeSearchButtonWithTarget:(id)target
                                   action:(SEL)sel
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH-30, 30)];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=4.0;
    bg.userInteractionEnabled=YES;
    bg.backgroundColor=Public_LineGray_Color;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:sel];
    [bg addGestureRecognizer:tap];
    
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(10,7, 16, 16)];
    imageV.image=[UIImage imageNamed:@"icon_search"];
    [bg addSubview:imageV];


    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(32,0,120,30)];
    label.textColor = [UIColor colorWithHexString:@"#BCBCBC"];
    label.text = @"搜索姓名/关键字";
    label.font = [UIFont systemFontOfSize:14.0];
    [bg addSubview:label];
    
    return bg;
}

//搜索视图
+(UIView*)getSearchCustomViewWithTarget:(id)target
                        textfieldAction:(SEL)sel1
                          ButtionAction:(SEL)sel2;
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,UI_SCREEN_WIDTH,SafeAreaTopHeight)];
    
    UITextField *textField=[[UITextField alloc]init];
    textField.frame=CGRectMake(10,6,UI_SCREEN_WIDTH-75, 32);
    textField.backgroundColor=Public_LineGray_Color;
    textField.layer.cornerRadius=4.0;
    textField.layer.masksToBounds=YES;
    textField.placeholder=@"搜索姓名/关键字";
    textField.font=[UIFont systemFontOfSize:14.0];
    textField.returnKeyType=UIReturnKeySearch;
    textField.delegate=target;
    textField.tag=100;
    [view addSubview:textField];

    [textField addTarget:target
                   action:sel1
         forControlEvents:UIControlEventEditingChanged];
    
    UIView *leftV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    UIImageView *imageV=[[UIImageView alloc]init];
    imageV.image=[UIImage imageNamed:@"icon_search"];
    [leftV addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(leftV);
    }];
    textField.leftView=leftV;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame=CGRectMake(UI_SCREEN_WIDTH-60, 7, 40,30);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [cancleBtn addTarget:target action:sel2 forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancleBtn];

    return view;
}


//right buttonItem
+(UIButton *)getRightBarButtonItemWithTarget:(id)target
                                             action:(SEL)sel
                                          normalImg:(NSString *)imageN
                                         hilightImg:(NSString *)imageH
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 35);
    button.layer.masksToBounds=YES;
    button.layer.cornerRadius=17.5;
    button.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
    [button setImage:[UIImage imageNamed:imageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageH] forState:UIControlStateSelected];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(1, 16, -1, -16)];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

//right buttonItem2
+(UIButton *)getRightBarButtonItem2WithTarget:(id)target
                                              action:(SEL)sel
                                           normalImg:(NSString *)imageN
                                          hilightImg:(NSString *)imageH
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
//    button.layer.masksToBounds=YES;
//    button.layer.cornerRadius=15;
//    button.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
    [button setImage:[UIImage imageNamed:imageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageH] forState:UIControlStateSelected];
    //    [button setImageEdgeInsets:UIEdgeInsetsMake(1, 16, -1, -16)];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
