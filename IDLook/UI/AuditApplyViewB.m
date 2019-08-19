//
//  AuditApplyViewB.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AuditApplyViewB.h"

@interface AuditApplyViewB ()<UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UIButton *addBtn;  //加
@property(nonatomic,strong)UIButton *subtractBtn;  //减
@property(nonatomic,strong)CustomTextField *dayTextField;  //天数
@property (nonatomic,assign)NSInteger count; //人数
@property (nonatomic,strong)UILabel *tip;
@property(nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UILabel *numLab;;

@end

@implementation AuditApplyViewB

-(id)init
{
    if (self=[super init]) {
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    UIView *bgV=[[UIView alloc]init];
    bgV.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgV];
    bgV.layer.masksToBounds=YES;
    bgV.layer.cornerRadius=6.0;
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(12);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self);
    }];
    
    UILabel *titleLab=[[UILabel alloc]init];
    titleLab.font=[UIFont boldSystemFontOfSize:16.0];
    titleLab.textColor=Public_Text_Color;
    titleLab.text=@"选角信息";
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgV).offset(15);
        make.top.mas_equalTo(bgV).offset(12);
    }];
    
    UILabel *dayTitleLab=[[UILabel alloc]init];
    dayTitleLab.font=[UIFont systemFontOfSize:15.0];
    dayTitleLab.textColor=Public_DetailTextLabelColor;
    dayTitleLab.text=@"演员人数";
    [self addSubview:dayTitleLab];
    [dayTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgV).offset(15);
        make.top.mas_equalTo(bgV).offset(50);
    }];
    
    //加
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:UIControlStateDisabled];
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dayTitleLab).offset(0);
        make.right.equalTo(bgV).offset(-15);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    [addBtn setImageEdgeInsets:UIEdgeInsetsMake(7,7,7,7)];//调整图片大小
    self.addBtn=addBtn;
    
    //天数
    CustomTextField *dayTextField = [[CustomTextField alloc] init];
    dayTextField.isNumber=YES;
    dayTextField.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
    dayTextField.layer.masksToBounds=YES;
    dayTextField.layer.cornerRadius=1;
    dayTextField.delegate=self;
    dayTextField.font=[UIFont systemFontOfSize:15];
    dayTextField.keyboardType=UIKeyboardTypeNumberPad;
    dayTextField.textAlignment=NSTextAlignmentCenter;
    [self addSubview:dayTextField];
    [dayTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(addBtn.mas_left).offset(-5);
        make.centerY.mas_equalTo(dayTitleLab);
        make.size.mas_equalTo(CGSizeMake(38, 22));
    }];
    [dayTextField addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged];
    dayTextField.text=[NSString stringWithFormat:@"0"];
    self.dayTextField=dayTextField;
    
    //减
    UIButton *subtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subtractBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:UIControlStateNormal];
    [subtractBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:UIControlStateDisabled];
    [subtractBtn addTarget:self action:@selector(subtractAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:subtractBtn];
    [subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dayTitleLab).offset(0);
        make.right.equalTo(dayTextField.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [subtractBtn setImageEdgeInsets:UIEdgeInsetsMake(7,7,7,7)];//调整图片大小
    subtractBtn.enabled=NO;
    self.subtractBtn=subtractBtn;
    
#if 0
    UILabel *dayDescLab=[[UILabel alloc]init];
    dayDescLab.font=[UIFont systemFontOfSize:11];
    dayDescLab.textColor=[UIColor colorWithHexString:@"#BCBCBC"];
    dayDescLab.text=@"为保证试镜质量，建议每天试镜人数不超过20人，最少半天起购";
    [self addSubview:dayDescLab];
    [dayDescLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgV).offset(15);
        make.top.mas_equalTo(dayTitleLab.mas_bottom).offset(8);
    }];
#endif
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=Public_Background_Color;
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgV).offset(15);
        make.centerX.mas_equalTo(bgV);
        make.top.mas_equalTo(bgV).offset(85);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *lab1=[[UILabel alloc]init];
    lab1.numberOfLines=0;
    lab1.font=[UIFont systemFontOfSize:16];
    lab1.textColor=Public_DetailTextLabelColor;
    lab1.text=@"备注";
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgV).offset(15);
        make.top.mas_equalTo(lineV).offset(15);
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.font=[UIFont systemFontOfSize:15.0];
    textView.delegate=self;
    [self addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgV).offset(12);
        make.right.equalTo(bgV).offset(-15);
        make.bottom.mas_equalTo(bgV).offset(-30);
        make.top.mas_equalTo(lineV).offset(40);
    }];
    self.textView=textView;
    
    UILabel *tip = [[UILabel alloc] init];
    tip.text = @"选填，如：希望脸探平台何时联系您，对选角角色的一些具体要求等等…";
    tip.numberOfLines=0;
    tip.font = [UIFont systemFontOfSize:15];
    tip.textColor = [UIColor colorWithHexString:@"#BCBCBC"];
    [self addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgV).offset(14);
        make.right.equalTo(bgV).offset(-15);
        make.top.mas_equalTo(lineV).offset(45);
    }];
    self.tip=tip;
    
    UILabel *numLab = [[UILabel alloc] init];
    numLab.text = @"0/500";
    numLab.numberOfLines=0;
    numLab.font = [UIFont systemFontOfSize:12];
    numLab.textColor = [UIColor colorWithHexString:@"#BCBCBC"];
    [self addSubview:numLab];
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgV).offset(-15);
        make.bottom.mas_equalTo(bgV).offset(-12);
    }];
    self.numLab=numLab;
}

//加
-(void)addAction:(UIButton*)sender
{
    self.count+=1;
    [self fitDay];

}

//减
-(void)subtractAction:(UIButton*)sender
{
    self.count-=1;
    [self fitDay];
}


//根据天数，按钮的显示状态改变
-(void)fitDay
{
    if (self.count<=0) {
        self.addBtn.enabled=YES;
        self.subtractBtn.enabled=NO;
    }
    else if (self.count>=99)
    {
        self.addBtn.enabled=NO;
        self.subtractBtn.enabled=YES;
    }
    else
    {
        self.addBtn.enabled=YES;
        self.subtractBtn.enabled=YES;
    }
    self.dayTextField.text=[NSString stringWithFormat:@"%ld",self.count];
    if (self.countsChangeBlock) {
        self.countsChangeBlock(self.count);
    }
}

#pragma mark--UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]>0)
        self.tip.hidden=YES;
    else{
        self.tip.hidden=NO;
    }
    if (textView.text.length > 500) {
        textView.text = [textView.text substringToIndex:500];
    }
    self.numLab.text = [NSString stringWithFormat:@"%ld/500",textView.text.length];
    
    if (self.textViewChangeBlock) {
        self.textViewChangeBlock(textView.text);
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.textViewBeginEditBlock) {
        self.textViewBeginEditBlock();
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.textViewEndEditBlock) {
        self.textViewEndEditBlock();
    }
}

#pragma mark--
- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text integerValue]>99||[textField.text integerValue]<=0) {
        if (textField.text.length>=2) {
            textField.text = [textField.text substringToIndex:2];
        }
        else
        {
            textField.text = @"";
        }
    }
    self.count = [textField.text integerValue];
    [self fitDay];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.textViewBeginEditBlock) {
        self.textViewBeginEditBlock();
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.textViewEndEditBlock) {
        self.textViewEndEditBlock();
    }
}

@end
