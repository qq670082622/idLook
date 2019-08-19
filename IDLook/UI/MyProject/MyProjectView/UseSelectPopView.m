//
//  UseSelectPopView.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "UseSelectPopView.h"
@interface UseSelectPopView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
- (IBAction)cancelAction:(id)sender;
- (IBAction)ensureAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property(nonatomic,assign)NSInteger selectRow;
@property (strong, nonatomic)  UIView *bg;

@end
@implementation UseSelectPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"UseSelectPopView" owner:nil options:nil] lastObject];
        }
   return self;
}
-(void)initSubviews
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
    
    if(!showWindow)return;
    //当window上有视图时移除
    for (UIView *view in showWindow.subviews) {
        if ([view isKindOfClass:[UseSelectPopView class]]) {
            return;
        }
    }
    UIView *bg = [[UIView alloc] initWithFrame:showWindow.frame];
    bg.backgroundColor = [UIColor blackColor];
    bg.alpha = 0;
    [showWindow addSubview:bg];
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 219);
    [showWindow addSubview:self];
   
    [UIView animateWithDuration:0.3 animations:^{
        bg.alpha = 0.45;
        self.y -=219;
    }];
UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [bg addGestureRecognizer:tap];
    self.bg = bg;
    self.titleLab.text = _title;
    [self.pickView reloadAllComponents];
    for(int i=0 ;i<_dataSource.count;i++){
        NSString *str = _dataSource[i];
        if ([str isEqualToString:_selectStr]) {
            [self.pickView selectRow:i inComponent:0 animated:YES];
        }
    }
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataSource.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _dataSource[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectRow = row;
}
- (IBAction)cancelAction:(id)sender {
    [self hide];
}

- (IBAction)ensureAction:(id)sender {
    self.selectID([_dataSource objectAtIndex:_selectRow]);
    [self hide];
}
-(void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
        self.bg.alpha = 0;
        self.y +=219;//高度是屏幕高+219 
    } completion:^(BOOL finished) {
        if(self.superview)
        {
            [self removeFromSuperview];
            [self.bg removeFromSuperview];
        }
    }];
}

@end
