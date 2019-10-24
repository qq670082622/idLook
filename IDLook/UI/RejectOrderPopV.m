//
//  RejectOrderPopV.m
//  IDLook
//
//  Created by HYH on 2018/7/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RejectOrderPopV.h"

@interface RejectOrderPopV()
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSArray *dataSource;
@end
@implementation RejectOrderPopV

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

-(void)showWithOrderType:(OrderType)type
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
    
    [self creatClickLayoutWithOrderType:type];
    
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

-(void)hidekeyboard
{
    [self endEditing:YES];
}

-(void)creatClickLayoutWithOrderType:(OrderType)type
{
    NSArray *array;
    CGFloat width = 270;
//    if (type==OrderTypeAudition) {
//        array=@[@"拍摄日无档期",@"没有时间试镜",@"脚本无法接受"];
//        width=270;
//    }
//    else if (OrderTypeShot)
//    {
//        array=@[@"拍摄日期更改，无档期",@"拍摄地点更改，报价不符，请重新下单",@"拍摄天数延长，报价不符，请重新下单"];
//        width=300;
//    }
    array=@[@"拍摄时间不符",@"拍摄地点不符",@"拍摄天数不符"];

    self.dataSource=array;
    
    UIView *bg=[[UIView alloc]init];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.masksToBounds=YES;
    bg.layer.cornerRadius=5.0;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(width, 370));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(bg).offset(15);
    }];
    titleLab.text =@"选择拒单理由";
    
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
    
    for (int i=0; i<array.count; i++) {
        RejectSelectV *subV=[[RejectSelectV alloc]init];
        [self addSubview:subV];
        subV.userInteractionEnabled=YES;
        subV.tag=100+i;
        [subV reloadUIWithTitle:array[i]];
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bg).offset(20);
            make.right.mas_equalTo(bg).offset(-20);
            make.top.mas_equalTo(bg).offset(70+54*i);
            make.height.mas_equalTo(44);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reasonSelect:)];
        [subV addGestureRecognizer:tap];
    }
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor=[Public_Red_Color colorWithAlphaComponent:0.1];
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius=5.0;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bg).offset(20);
        make.right.equalTo(bg).offset(-20);
        make.bottom.equalTo(bg).offset(-80);
        make.height.equalTo(@(44));
    }];
    
    textField.placeholder=@"其他原因请输入～";
    
    UIFont * font = [UIFont systemFontOfSize:14.0];
   // [textField setValue:font forKeyPath:@"_placeholderLabel.font"];
    
    UIColor * color = [UIColor colorWithHexString:@"#ECA3A8"];
   // [textField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    NSMutableAttributedString *fontString = [[NSMutableAttributedString alloc] initWithString:textField.text attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
    [textField setAttributedText:fontString];
    UIView *leftV=[[UIView alloc]initWithFrame:CGRectMake(0, 0,10, 0)];
    textField.leftView=leftV;
    textField.leftViewMode=UITextFieldViewModeAlways;
    
    self.textField=textField;
    
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
        make.left.equalTo(bg).offset(20);
        make.right.equalTo(bg).offset(-20);
        
    }];
}

-(void)reasonSelect:(UITapGestureRecognizer*)tap
{
    RejectSelectV *subV = (RejectSelectV*)tap.view;
    subV.isSelect=!subV.isSelect;
}

-(void)confrimAction
{
    NSMutableArray *contArr=[NSMutableArray new];
    for (int i =0; i<self.dataSource.count; i++) {
        RejectSelectV *subV=(RejectSelectV*)[self viewWithTag:100+i];
        if (subV.isSelect) {
            [contArr addObject:self.dataSource[i]];
        }
    }
    if (self.textField.text.length>0) {
        [contArr addObject:self.textField.text];
    }
    
    if (contArr.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择或输入拒单原因"];
        return;
    }
    
    NSString *reason = [contArr componentsJoinedByString:@";"];
    
    [self hide];
    self.rejectWithReason(reason);
}

@end


@interface RejectSelectV ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@end

@implementation RejectSelectV

-(id)init
{
    if (self=[super init]) {
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=5.0;
        self.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(10);
        }];
    }
    return _icon;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self addSubview:_titleLab];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.font=[UIFont systemFontOfSize:12.0];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(35);
        }];
        
    }
    return _titleLab;
}

-(void)reloadUIWithTitle:(NSString*)title
{
    self.icon.image=[UIImage imageNamed:@"order_click_n"];

    self.titleLab.text=title;
}

-(void)setIsSelect:(BOOL)isSelect
{
    _isSelect=isSelect;
    if (isSelect) {
        self.backgroundColor=[Public_Red_Color colorWithAlphaComponent:0.1];
        self.icon.image=[UIImage imageNamed:@"order_click_h"];
        self.titleLab.textColor=Public_Red_Color;
    }
    else
    {
        self.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        self.icon.image=[UIImage imageNamed:@"order_click_n"];
        self.titleLab.textColor=Public_Text_Color;
    }
}

@end
