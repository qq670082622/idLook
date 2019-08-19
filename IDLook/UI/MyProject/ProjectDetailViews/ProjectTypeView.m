//
//  ProjectTypeView.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/2.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectTypeView.h"
@interface ProjectTypeView()
{
    CGFloat Vheight;   //视图高度
}
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)NSMutableArray *selectArr;
@end
@implementation ProjectTypeView
- (id)init
{
    if(self=[super init])
    {
        Vheight = 380;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }
    return self;
}
-(void)showTypeWithSelectTypes:(NSString *)types
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
    
    [self.selectArr addObjectsFromArray:[types componentsSeparatedByString:@"、"]];
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    [showWindow addSubview:maskV];
    [showWindow addSubview:self];
    self.maskV=maskV;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT-Vheight, UI_SCREEN_WIDTH,Vheight);
    [self initUI];
    [UIView commitAnimations];
}
- (void)initUI
{
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont boldSystemFontOfSize:14.0];
    titleLab.textColor = Public_Text_Color;
    [self addSubview:titleLab];
    titleLab.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 48);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text=@"角色类型";
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [cancleBtn setImage:[UIImage imageNamed:@"price_detail_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    cancleBtn.frame = CGRectMake(UI_SCREEN_WIDTH-48, 0, 48, 48);
    
    UIView *lineV=[[UIView alloc]init];
    lineV.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:lineV];
    lineV.frame = CGRectMake(0, 48, UI_SCREEN_WIDTH, 1);
    
    CGFloat width = (UI_SCREEN_WIDTH-30-20)/3;
    NSArray *dataS = [NSArray arrayWithObjects:@"阳光",@"文艺",@"动感",@"职场",@"温柔",@"甜美",@"性感",@"成熟",@"潮酷",@"可爱",@"慈祥",@"平凡",@"居家",@"帅气",@"搞笑",nil];
    CGFloat btnX = 15;
    CGFloat btnY = 82;
    for (int i =0; i<dataS.count; i++) {
        UIButton *btn = [UIButton buttonWithType:0];
        [btn setTitle:dataS[i] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:Public_Text_Color forState:0];
        [btn setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
        [btn setTag:i];
        if ([_selectArr containsObject:dataS[i]]) {
            [btn setTitleColor:Public_Red_Color forState:0];
            btn.layer.borderColor = Public_Red_Color.CGColor;
            btn.layer.borderWidth = 1;
            [btn setBackgroundColor:[UIColor colorWithHexString:@"fbedee"]];
        }
        if (i%3==1) {
            btnX = 15;
        }else if (i%3==2){
          btnX = 15+ width + 10;
        }else if (i%3==0){
            btnX = 15+width*2+20;
        }
        if (i/3==1) {
            btnY = 82;
        }else if (i/3==2){
            btnY = 82+33+30;
        }else if (i/3==0){
            btnY = 82+33+30+33+30;
        }
       
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(btnX, btnY, width, 33);
        [self addSubview:btn];
    }
    UIButton *ensure = [UIButton buttonWithType:0];
    [ensure setBackgroundColor:Public_Red_Color];
    [ensure setTitleColor:[UIColor whiteColor] forState:0];
    [ensure setTitle:@"确定" forState:0];
    ensure.frame = CGRectMake(15, 300, UI_SCREEN_WIDTH-30, 48);
    ensure.layer.cornerRadius = 8;
    ensure.layer.masksToBounds = YES;
    [ensure addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ensure];
}
-(void)click:(id)sender
{
    UIButton *btn = (UIButton *)sender;
     NSArray *dataS = [NSArray arrayWithObjects:@"阳光",@"文艺",@"动感",@"职场",@"温柔",@"甜美",@"性感",@"成熟",@"潮酷",@"可爱",@"慈祥",@"平凡",@"居家",@"帅气",@"搞笑",nil];
    NSString *str = dataS[btn.tag];
    if (![_selectArr containsObject:str]) {
        [_selectArr addObject:str];
        [btn setBackgroundColor:[UIColor colorWithHexString:@"fbedee"]];
        [btn setTitleColor:Public_Red_Color forState:0];
        btn.layer.borderColor = Public_Red_Color.CGColor;
        btn.layer.borderWidth = 1;
    }else{
        [_selectArr removeObject:str];
        [btn setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
        [btn setTitleColor:Public_Text_Color forState:0];
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        btn.layer.borderWidth = 1;
    }
    
}
-(void)ensure
{
    if (_selectArr.count==0) {
        [SVProgressHUD showErrorWithStatus:@"没有选择类型哦"];
        return;
    }
    for(int i =0;i<_selectArr.count;i++){
        NSString *type = _selectArr[i];
        if ([type isEqualToString:@""]) {
               [_selectArr removeObjectAtIndex:i];
        }
     
    }
    self.typeSelectAction([_selectArr componentsJoinedByString:@"、"]);
    [self hide];
}

- (void)clearSubV
{
    [self.maskV removeFromSuperview];
    [self removeFromSuperview];
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, Vheight);
    [UIView commitAnimations];
}
-(NSMutableArray *)selectArr
{
    if (!_selectArr) {
        _selectArr = [NSMutableArray new];
    }
    return _selectArr;
}
@end
