//
//  OrderPickerPopV.m
//  IDLook
//
//  Created by HYH on 2018/6/22.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "OrderPickerPopV.h"
#define SelectV_Height 255.0

@interface OrderPickerPopV()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,strong)NSArray *dataS;
@property (nonatomic,strong)NSString *selectStr;
@property (nonatomic,assign)OrderCheckType type;
@property (nonatomic,assign)NSInteger row;
@end

@implementation OrderPickerPopV

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, SelectV_Height)];
    if(self){
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return self;
}

-(UIPickerView*)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, SelectV_Height-40+20)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
        [_pickerView reloadAllComponents];//刷新UIPickerView
    }
    return _pickerView;
}

- (void)showWithPickerType:(OrderCheckType)type withDesc:(NSString *)string
{
    self.type=type;
    self.dataS = [PublicManager getOrderCellType:type];
    self.selectStr =[NSString stringWithFormat:@"%@",[self.dataS firstObject]];
    
    NSString *value = [NSString stringWithFormat:@"%@",string];
    for (int i = 0; i<self.dataS.count; i++) {
        if ([value isEqualToString:self.dataS[i]]) {
            [self.pickerView selectRow:i inComponent:0 animated:NO];
            self.selectStr = self.dataS[i];
        }
    }
    
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
    
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    self.maskV=maskV;
    
    [showWindow addSubview:self];
    
    [self initUI];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-SelectV_Height, UI_SCREEN_WIDTH, SelectV_Height);
    
    [UIView commitAnimations];
}


- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, SelectV_Height);
    [UIView commitAnimations];
}

- (void)initUI
{
    [self pickerView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [btn addTarget:self action:@selector(confirmSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.right.equalTo(self).offset(-10);
    }];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.left.equalTo(self).offset(10);
    }];
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(40);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont boldSystemFontOfSize:16.0];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(btn);
    }];
    
    title.text = self.title;
}


- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}


- (void)confirmSelected
{
    self.didSelectBlock(self.selectStr,self.row);
    [self hide];
}


#pragma mark pickerview function
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataS.count;
}

//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return  UI_SCREEN_WIDTH;
}

//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str =[NSString stringWithFormat:@"%@",self.dataS[row]];
    return str;
}

//要修改picker滚动里每行文字的值及相关属性，分割线等在此方法里设置, 优先度高于上面的方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *genderLabel = (UILabel*)view;
    if (!genderLabel) {
        //设置文字的属性
        genderLabel = [[UILabel alloc]init];
        genderLabel.textAlignment = NSTextAlignmentCenter;
        genderLabel.font = [UIFont systemFontOfSize:23.0];
        genderLabel.textColor = [UIColor blackColor];
    }
    
    genderLabel.text = [NSString stringWithFormat:@"%@",self.dataS[row]];
    
    [self.pickerView.subviews objectAtIndex:1].backgroundColor = Public_LineGray_Color;
    [self.pickerView.subviews objectAtIndex:2].backgroundColor = Public_LineGray_Color;
    
    return genderLabel;
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectStr=self.dataS[row];
    self.row=row;
}

@end