/*
 @header  AuthBuyerSelectPopV.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/22
 @description
 
 */

#import "AuthBuyerSelectPopV.h"

@implementation AuthBuyerSelectPopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;

    }
    return self;
}

- (void)show
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
    
    
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
    }];
    
    [self creatClickLayout];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}

-(void)creatClickLayout
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(284, 287));
    }];
    
    UIImageView *topV=[[UIImageView alloc]init];
    [self addSubview:topV];
    topV.image=[UIImage imageNamed:@"icon_auth"];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(bg.mas_top).offset(10);
    }];
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    NSArray *array = @[@{@"title":@"个人认证",@"desc":@"有权查看演员报价和下单，尾款最晚在拍摄前支付"},
                       @{@"title":@"企业认证",@"desc":@"有权查看演员报价和下单，尾款最晚在拍摄后10个工作日内支付"}];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        
        UIView *bgV=[[UIView alloc]init];
        bgV.userInteractionEnabled=YES;
        bgV.tag=100+i;
        bgV.layer.cornerRadius=3.0;
        bgV.layer.masksToBounds=YES;
        bgV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        [bg addSubview:bgV];
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bg).offset(15);
            make.centerX.mas_equalTo(bg);
            make.top.mas_equalTo(bg).offset(80+90*i);
            make.height.mas_equalTo(80);
        }];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = [UIFont boldSystemFontOfSize:15.0];
        titleLab.text=dic[@"title"];
        titleLab.textColor = Public_Text_Color;
        [bgV addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bgV).offset(13);
            make.top.mas_equalTo(bgV).offset(15);
        }];
        
        MLLabel *descLab = [[MLLabel alloc] init];
        descLab.font = [UIFont systemFontOfSize:12.0];
        descLab.numberOfLines=0;
        descLab.lineSpacing=3.0;
        descLab.text=dic[@"desc"];
        descLab.textColor = [UIColor colorWithHexString:@"#999999"];
        [bgV addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bgV).offset(13);
            make.right.mas_equalTo(bgV).offset(-55);
            make.top.mas_equalTo(titleLab.mas_bottom).offset(5);
        }];
        
        UIImageView *arrow=[[UIImageView alloc]init];
        [bgV addSubview:arrow];
        arrow.image=[UIImage imageNamed:@"home_more"];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bgV).offset(-12);
            make.centerY.mas_equalTo(bgV);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [bgV addGestureRecognizer:tap];
    }

}

-(void)tapAction:(UITapGestureRecognizer*)tap
{
    if (self.authTypeSelectBlock) {
        self.authTypeSelectBlock(tap.view.tag-100);
    }
    [self hide];
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
}


@end
