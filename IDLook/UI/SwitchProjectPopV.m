//
//  SwitchProjectPopV.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "SwitchProjectPopV.h"

#define SelectV_Height 265.0

@interface SwitchProjectPopV ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,strong)NSArray *dataS;
@property (nonatomic,strong)NSString *selectStr;
@end

@implementation SwitchProjectPopV

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
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 48, UI_SCREEN_WIDTH, SelectV_Height-48+20)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
        [_pickerView reloadAllComponents];//刷新UIPickerView
    }
    return _pickerView;
}

- (void)showWithArray:(NSArray *)list withProjectId:(nonnull NSString *)projectId
{
    self.dataS = list;
    
    
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
    
    for (int i=0; i<list.count; i++) {
        NSDictionary *dic = list[i];
        if ([dic[@"projectId"] isEqualToString:projectId]) {
            [self.pickerView selectRow:i inComponent:0 animated:NO];
        }
    }
    
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
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(confirmSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(48, 48));
        make.right.equalTo(self).offset(-5);
    }];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(48, 48));
        make.left.equalTo(self).offset(5);
    }];
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(48);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = Public_Text_Color;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(btn);
    }];
    title.text = @"切换项目";
}


- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}


- (void)confirmSelected
{
    NSDictionary *dic = self.dataS[[self.pickerView selectedRowInComponent:0]];
    if (self.switchProjectWithIdBlock) {
        self.switchProjectWithIdBlock(dic[@"projectId"]);
    }
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
    return 48;
}

//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return  UI_SCREEN_WIDTH;
}

//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *dic = self.dataS[row];
    NSString *str =[NSString stringWithFormat:@"%@(%ld人)",dic[@"projectName"],[dic[@"orderNumber"]integerValue]];
    return str;
}

//要修改picker滚动里每行文字的值及相关属性，分割线等在此方法里设置, 优先度高于上面的方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *genderLabel = (UILabel*)view;
    if (!genderLabel) {
        //设置文字的属性
        genderLabel = [[UILabel alloc]init];
        genderLabel.textAlignment = NSTextAlignmentCenter;
        genderLabel.font = [UIFont systemFontOfSize:17];
        genderLabel.textColor = [UIColor blackColor];
    }
    NSDictionary *dic = self.dataS[row];
    NSString *str =[NSString stringWithFormat:@"%@(%ld人)",dic[@"projectName"],[dic[@"orderNumber"]integerValue]];
    genderLabel.text = str;
    
    [self.pickerView.subviews objectAtIndex:1].backgroundColor = Public_LineGray_Color;
    [self.pickerView.subviews objectAtIndex:2].backgroundColor = Public_LineGray_Color;
    
    return genderLabel;
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

}


@end
