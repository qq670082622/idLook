//
//  CouponExplainVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/18.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CouponExplainVC.h"

@interface CouponExplainVC ()<UIScrollViewDelegate>

@end

@implementation CouponExplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"优惠券说明"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self initUI];

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0.5, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    scrollView.backgroundColor=[UIColor whiteColor];
    scrollView.scrollEnabled = YES;//设置是否支持滚动
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator = NO;//设置是否显示水平滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];

    NSString *title1= @"返现码兑换说明";
    NSArray *array1 = @[@"在脸探肖像APP-我的-优惠券页面，输入返现码兑换「下单20%返现券」。",
                        @"返现码也可多次转赠他人使用，则您返5%，下单人返20%。",
                        @"每个返现码仅可被同一账号兑换一次，但同一返现码可被多个账号兑换。",
                        @"当返现码兑换出的返现券被使用(即订单尾款支付完 成)，两个工作日内，返现金额将统一返至由您手机号注册为买家身份的脸探肖像APP账户内，可随时提现。",
                        @"兑换有效期为2019-07-31前，过期将无法兑换。"];
    
    NSString *title2= @"返现券使用说明";
    NSArray *array2 = @[@"此券会在下单后自动使用，无需在下单页面勾选。 ",
                        @"默认优先使用兑换码手机和返现券券手机一致的那张。如果没有一致的，则优先使用最先兑换的。另外您可随时在本页面手动调整优先使用的返现券。",
                        @"使用优惠券的订单不再赠送积分。 ",
                        @"在您支付完尾款后，两个工作日内，返现金额将打到 您的脸探肖像APP账户内，可随时提现。 ",
                        @"优惠券使用中，想更换对应订单，可联系脸探客服 400-833-6969申请将返现券恢复为未使用状态。",
                        @"优惠券有90天有效期，过期将失效。"];
    
    CGFloat totalHeight=60;
    
    UILabel *titleLab1 = [[UILabel alloc]init];
    titleLab1.text=title1;
    titleLab1.textColor=Public_Text_Color;
    titleLab1.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:titleLab1];
    [titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.top.mas_equalTo(self.view).offset(25);
    }];
    
    for (int i=0; i<array1.count; i++) {
        UILabel *numberLab = [[UILabel alloc]init];
        numberLab.text=[NSString stringWithFormat:@"%d.",i+1];
        numberLab.textColor=Public_Text_Color;
        numberLab.font=[UIFont systemFontOfSize:14];
        [self.view addSubview:numberLab];
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(15);
            make.top.mas_equalTo(self.view).offset(totalHeight);
        }];
        
        MLLabel *descLab = [[MLLabel alloc]init];
        descLab.font=[UIFont systemFontOfSize:14];
        descLab.numberOfLines=0;
        descLab.lineSpacing=3;
        descLab.textAlignment=NSTextAlignmentLeft;
        descLab.textColor=Public_Text_Color;
        descLab.text=array1[i];
        [self.view addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(27);
            make.right.mas_equalTo(self.view).offset(-15);
            make.top.mas_equalTo(self.view).offset(totalHeight);
        }];
        
        //高度计算
        totalHeight=totalHeight+[self heighOfString:array1[i] font:[UIFont systemFontOfSize:14] width:UI_SCREEN_WIDTH-40]+7;
    }
    
    UILabel *titleLab2 = [[UILabel alloc]init];
    titleLab2.text=title2;
    titleLab2.textColor=Public_Text_Color;
    titleLab2.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:titleLab2];
    [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.top.mas_equalTo(self.view).offset(totalHeight+20);
    }];
    
    totalHeight=totalHeight+50;
    
    
    
    for (int i=0; i<array2.count; i++) {
        MLLabel *numberLab = [[MLLabel alloc]init];
        numberLab.text=[NSString stringWithFormat:@"%d.",i+1];
        numberLab.textColor=Public_Text_Color;
        numberLab.lineSpacing=3;
        numberLab.font=[UIFont systemFontOfSize:14];
        [self.view addSubview:numberLab];
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(15);
            make.top.mas_equalTo(self.view).offset(totalHeight);
        }];
        
        MLLabel *descLab = [[MLLabel alloc]init];
        descLab.font=[UIFont systemFontOfSize:14];
        descLab.numberOfLines=0;
        descLab.lineSpacing=3;
        descLab.textAlignment=NSTextAlignmentLeft;
        descLab.textColor=Public_Text_Color;
        descLab.text=array2[i];
        [self.view addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(27);
            make.right.mas_equalTo(self.view).offset(-15);
            make.top.mas_equalTo(self.view).offset(totalHeight);
        }];
        
        //高度计算
        totalHeight=totalHeight+[self heighOfString:array2[i] font:[UIFont systemFontOfSize:14] width:UI_SCREEN_WIDTH-40]+7;
    }
}


//文字高度
-(CGFloat)heighOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    MLLabel *contentLab = [[MLLabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.lineSpacing = 3;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(width, 0)];
    size.width = fmin(size.width, width);
    
    return ceilf(size.height)<20?20:ceilf(size.height);
}

@end
