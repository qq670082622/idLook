//
//  SinglePricePopV.m
//  IDLook
//
//  Created by HYH on 2018/7/17.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SinglePricePopV.h"

@interface SinglePricePopV()<UITextFieldDelegate>

@property(nonatomic,assign)NSInteger minPrice;  //最小价格
@property(nonatomic,assign)NSInteger maxPrice; //最大价格
@property(nonatomic,assign)EditPricePopType type;
@end

@implementation SinglePricePopV

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.hidden = YES;
        self.alpha = 0.0;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidekeyboard)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)showWithPrice:(NSString *)price withMinPrice:(CGFloat)price1 withMaxPrice:(CGFloat)price2 withEditType:(EditPricePopType)type
{
    self.minPrice=price1;
    self.maxPrice=price2;
    self.type=type;
    
    NSEnumerator *frontToBackWindows=[[[UIApplication sharedApplication]windows]reverseObjectEnumerator];UIWindow *showWindow = nil;
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            
            showWindow = window;
            break;
        }
    }
    [showWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(showWindow).insets(UIEdgeInsetsZero);
       
    }];
    
    [self creatClickLayoutWithText:price];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
    
}

- (void)hide
{
    [self.textField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
        }
    }];
}

-(void)hidekeyboard
{
    [self endEditing:YES];
}

-(void)creatClickLayoutWithText:(NSString*)text
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(270, 280));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(15);
    }];
    
    if (self.type==EditPricePopTypeSingle) {
        titleLab.text =@"单项报价";
    }
    else
    {
        titleLab.text =@"修改报价";
    }
    
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(45);
        make.height.mas_equalTo(0.5);
    }];
    
    
    CustomTextField *textField = [[CustomTextField alloc] init];
    textField.isNumber=YES;
    textField.backgroundColor=[Public_Red_Color colorWithAlphaComponent:0.1];
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius=5.0;
    textField.keyboardType=UIKeyboardTypeNumberPad;  //纯数字键盘
//    textField.delegate=self;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg).offset(30);
        make.right.equalTo(bg).offset(-30);
        make.top.equalTo(bg).offset(65);
        make.height.equalTo(@(44));
    }];
    textField.placeholder=@"请输入报价";
    textField.text=[text integerValue]==0?@"":[NSString stringWithFormat:@"%ld", [text integerValue]];
    
    UIFont * font = [UIFont systemFontOfSize:14.0];
    [textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    UIColor * color = [UIColor colorWithHexString:@"#ECA3A8"];
    [textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
    UIView *leftV=[[UIView alloc]initWithFrame:CGRectMake(0, 0,10, 0)];
    textField.leftView=leftV;
    textField.leftViewMode=UITextFieldViewModeAlways;
    
    UILabel *rightLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,20,44)];
    rightLab.text=@"元";
    rightLab.textColor=[UIColor redColor];
    rightLab.font=[UIFont systemFontOfSize:14.0];
    textField.rightView=rightLab;
    textField.rightViewMode=UITextFieldViewModeAlways;
    
    self.textField=textField;
    
    
    MLLabel *descLab = [[MLLabel alloc] init];
    descLab.font = [UIFont systemFontOfSize:12.0];
    descLab.numberOfLines=0;
    descLab.lineSpacing=5.0;
//    descLab.textAlignment=NSTextAlignmentCenter;
    descLab.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    [self addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg).offset(30);
        make.right.equalTo(bg).offset(-30);
        make.top.mas_equalTo(textField.mas_bottom).offset(20);
    }];
    NSString *priceText = [NSString stringWithFormat:@"%ld-%ld",self.minPrice,self.maxPrice];
    NSString *content = [NSString stringWithFormat:@"*请在%@元范围内合理设置报价，如需设置超出范围内的报价，请拨打400 833 6969 ，联系我们。",priceText];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:content];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FF8853"]} range:NSMakeRange(3,priceText.length)];
    [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Text_Color} range:NSMakeRange(content.length-19,12)];
    descLab.attributedText=attStr;
    
    UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confrimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confrimBtn setTitle:@"确认" forState:UIControlStateNormal];
    confrimBtn.layer.masksToBounds=YES;
    confrimBtn.layer.cornerRadius=22.0;
    confrimBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    confrimBtn.backgroundColor=Public_Red_Color;
    [confrimBtn addTarget:self action:@selector(confrimAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confrimBtn];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bg).offset(-20);
        make.height.mas_equalTo(44);
        make.left.equalTo(bg).offset(30);
        make.right.equalTo(bg).offset(-30);
    }];
}

-(void)confrimAction
{
    if (self.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请输入单项报价!"];
        return;
    }
    
    CGFloat price = [self.textField.text floatValue];
    if (price<self.minPrice||price>self.maxPrice) {
        [SVProgressHUD showImage:nil status:@"请输入范围内的报价！"];
        return;
    }
    
    if (self.confirmBlock) {
        self.confirmBlock(self.textField.text);
    }
    [self hide];
}

@end
