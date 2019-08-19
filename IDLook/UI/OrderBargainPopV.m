//
//  OrderBargainPopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/13.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "OrderBargainPopV.h"

@interface OrderBargainPopV ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView *bgV;
@property (nonatomic,strong)UIButton *acceptBtn;
@property (nonatomic,strong)UIButton *rejectBtn;
@property(nonatomic,strong)CustomTextField *textField;

@end

@implementation OrderBargainPopV

-(id)init
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

-(void)hidekeyboard
{
    [self endEditing:YES];
}

- (void)showPopVWithInfo:(ProjectOrderInfoM *)info
{
    
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
    
    [self initUIWithInfo:info];
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
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

-(void)initUIWithInfo:(ProjectOrderInfoM*)info
{
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(280,370));
    }];
    self.bgV=bg;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    titleLab.textColor = Public_Text_Color;
    [self.bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(15);
    }];
    titleLab.text=@"确认档期";
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self.bgV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg);
        make.right.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(45);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *shotLab1 = [[UILabel alloc] init];
    shotLab1.font = [UIFont systemFontOfSize:14];
    shotLab1.numberOfLines=0;
    shotLab1.textAlignment=NSTextAlignmentCenter;
    shotLab1.textColor = [UIColor colorWithHexString:@"#FF6E0C"];
    [self.bgV addSubview:shotLab1];
    [shotLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bg);
        make.top.mas_equalTo(bg).offset(65);
    }];
    shotLab1.text=[NSString stringWithFormat:@"拍摄日期\n%@至%@",info.shotStart,info.shotEnd];
    
    NSString *priceStr = [NSString stringWithFormat:@"￥%ld",info.totalPrice];
    MLLabel *descLab = [[MLLabel alloc] init];
    descLab.numberOfLines=0;
    descLab.lineSpacing=5.0;
    descLab.font=[UIFont systemFontOfSize:14.0];
    descLab.textColor=Public_Text_Color;
    [self.bgV addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg).offset(-18);
        make.left.mas_equalTo(bg).offset(18);
        make.top.mas_equalTo(bg).offset(113);
    }];
    NSString *str=[NSString stringWithFormat:@"该购买方已经申请议价，买家预算为%@，您是否接受该价格，如若不接受，请填写一个您的心理价。",priceStr];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FF6E0C"],} range:NSMakeRange(16,priceStr.length)];
    descLab.attributedText=attStr;
    

    
    UILabel *acceptLab = [[UILabel alloc] init];
    acceptLab.font = [UIFont systemFontOfSize:15];
    acceptLab.text=@"接受";
    acceptLab.textColor = Public_Text_Color;
    [self.bgV addSubview:acceptLab];
    [acceptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(30);
        make.top.mas_equalTo(descLab.mas_bottom).offset(18);
    }];
    
    UILabel *pointLab1 = [[UILabel alloc] init];
    pointLab1.font = [UIFont systemFontOfSize:15];
    pointLab1.text=@"•";
    pointLab1.textColor = [UIColor colorWithHexString:@"#C9C9C9"];
    [self.bgV addSubview:pointLab1];
    [pointLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(acceptLab.mas_left).offset(-3);
        make.centerY.mas_equalTo(acceptLab);
    }];
    
    UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [acceptBtn setBackgroundImage:[UIImage imageNamed:@"orderbargain_unclick"] forState:UIControlStateNormal];
    [acceptBtn setBackgroundImage:[UIImage imageNamed:@"orderbargain_click"] forState:UIControlStateSelected];
    [acceptBtn addTarget:self action:@selector(acceptAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgV addSubview:acceptBtn];
    [acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg).offset(-20);
        make.centerY.mas_equalTo(acceptLab);
    }];
    self.acceptBtn=acceptBtn;
    
    UIView *lineV2 = [[UIView alloc]init];
    lineV2.backgroundColor=[UIColor colorWithHexString:@"#E7E7E7"];
    [self.bgV addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(20);
        make.right.mas_equalTo(bg).offset(-20);
        make.top.mas_equalTo(acceptBtn.mas_bottom).offset(15);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *rejectLab = [[UILabel alloc] init];
    rejectLab.font = [UIFont systemFontOfSize:15];
    rejectLab.text=@"不接受";
    rejectLab.textColor = Public_Text_Color;
    [self.bgV addSubview:rejectLab];
    [rejectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg).offset(30);
        make.top.mas_equalTo(lineV2.mas_bottom).offset(15);
    }];
    
    UILabel *pointLab2 = [[UILabel alloc] init];
    pointLab2.font = [UIFont systemFontOfSize:15];
    pointLab2.text=@"•";
    pointLab2.textColor = [UIColor colorWithHexString:@"#C9C9C9"];
    [self.bgV addSubview:pointLab2];
    [pointLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rejectLab.mas_left).offset(-3);
        make.centerY.mas_equalTo(rejectLab);
    }];

    
    UIButton *rejectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rejectBtn setBackgroundImage:[UIImage imageNamed:@"orderbargain_unclick"] forState:UIControlStateNormal];
    [rejectBtn setBackgroundImage:[UIImage imageNamed:@"orderbargain_click"] forState:UIControlStateSelected];
    [rejectBtn addTarget:self action:@selector(rejectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgV addSubview:rejectBtn];
    [rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg).offset(-20);
        make.centerY.mas_equalTo(rejectLab);
    }];
    self.rejectBtn=rejectBtn;
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.layer.masksToBounds=YES;
    cancleBtn.layer.cornerRadius=4;
    cancleBtn.backgroundColor=[UIColor whiteColor];
    cancleBtn.layer.borderColor=Public_Red_Color.CGColor;
    cancleBtn.layer.borderWidth=1.0;
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [cancleBtn setTitleColor:Public_Red_Color forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.bgV addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg.mas_centerX).offset(-5);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    
    
    UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confrimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confrimBtn setTitle:@"确定" forState:UIControlStateNormal];
    confrimBtn.layer.masksToBounds=YES;
    confrimBtn.layer.cornerRadius=4;
    confrimBtn.backgroundColor=Public_Red_Color;
    confrimBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [confrimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confrimBtn addTarget:self action:@selector(confrimAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgV addSubview:confrimBtn];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_centerX).offset(5);
        make.bottom.mas_equalTo(bg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(110, 44));
    }];
    
    
    CustomTextField *textField = [[CustomTextField alloc] init];
    textField.backgroundColor=[UIColor colorWithHexString:@"#F6F6F6"];
    textField.layer.masksToBounds=YES;
    textField.isNumber=YES;
    textField.delegate=self;
    textField.layer.cornerRadius=4;
    textField.keyboardType=UIKeyboardTypeNumberPad;
    [self.bgV addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg).offset(20);
        make.right.equalTo(bg).offset(-20);
        make.bottom.equalTo(bg).offset(-100);
        make.height.equalTo(@(44));
    }];
    
    textField.placeholder=@"请填写您的心理价";
    
    UIView *leftV=[[UIView alloc]initWithFrame:CGRectMake(0, 0,10,20)];
    textField.leftView=leftV;
    textField.leftViewMode=UITextFieldViewModeAlways;
    
    UILabel *rightV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,45,44)];
    textField.rightView=rightV;
    rightV.textAlignment=NSTextAlignmentCenter;
    rightV.text=@"元";
    textField.rightViewMode=UITextFieldViewModeAlways;
    textField.hidden=YES;
    self.textField=textField;
    
    UIButton *closeBtm = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtm addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtm];
    [closeBtm setBackgroundImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg);
        make.top.equalTo(bg.mas_bottom).offset(25);
    }];
}

//确定
-(void)confrimAction
{
    if (self.acceptBtn.selected==NO&&self.rejectBtn.selected==NO) {
        [SVProgressHUD showImage:nil status:@"请选择是否接受报价"];
        return;
    }
    if (self.rejectBtn.selected==YES &&self.textField.text.length==0) {
        [SVProgressHUD showImage:nil status:@"请填写心里价"];
        return;
    }
    
    [self hide];

    NSInteger type = 0;
    if (self.rejectBtn.selected==YES) {
        type=1;
    }
    
    if (self.bargainBlock) {
        self.bargainBlock(type, [self.textField.text integerValue]);
    }
}

//接受
-(void)acceptAction
{
    if (self.acceptBtn.selected==YES) {
        return;
    }
    self.acceptBtn.selected=YES;
    self.rejectBtn.selected=NO;
    self.textField.hidden=YES;
    [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280,370));
    }];
}

//拒绝
-(void)rejectAction
{
    if (self.rejectBtn.selected==YES) {
        return;
    }
    self.acceptBtn.selected=NO;
    self.rejectBtn.selected=YES;
    self.textField.hidden=NO;
    [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280,437));
    }];
}

//开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).offset(-100);
    }];
}

//接受编辑
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.bgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).offset(-20);
    }];
}

@end
