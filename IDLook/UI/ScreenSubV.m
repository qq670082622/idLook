//
//  ScreenSubV.m
//  IDLook
//
//  Created by HYH on 2018/6/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ScreenSubV.h"

@interface ScreenSubV ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)NSArray *dataS;
@property(nonatomic,assign)NSInteger type;

@end

@implementation ScreenSubV

-(NSMutableArray*)selectArray
{
    if (!_selectArray) {
        _selectArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _selectArray;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self addSubview:_titleLab];
        _titleLab.font=[UIFont boldSystemFontOfSize:17.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self).offset(10);
        }];
        
    }
    return _titleLab;
}

-(void)reloadUIWithDic:(NSDictionary *)dic withSelect:(NSString *)select
{
    NSString *title = [dic objectForKey:kScreenPopVCMCellTitle];
    NSArray *array = [dic objectForKey:kScreenPopVCMCellData];
    ScreenCellType type = [[dic objectForKey:kScreenPopVCMCellType] integerValue];
    
    self.titleLab.text = title;
    self.dataS=array;
    self.type=type;
    
    if (type!=ScreenCellTypeAdv)
    {
        NSArray *selectArr = [select componentsSeparatedByString:@","];
        for (int i =0; i<selectArr.count; i++) {
            NSInteger index = [selectArr[i] integerValue];
            if (index!=0) {
                [self.selectArray addObject:@(index)];
            }
        }
        [self initPart1];
    }
    else
    {
        NSArray *selectArr = [select componentsSeparatedByString:@","];
        
        for (int i =0; i<selectArr.count; i++) {
            NSInteger index = [selectArr[i] integerValue];            
            if (index!=0) {
                [self.selectArray addObject:@(index)];
            }
        }
        
       // [self initParrt2];
    }
}

//除广告类型外，其他类型加载这个视图
-(void)initPart1
{
    for (UIView *view in self.subviews) {
        if (view.tag>=100) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat width = 0.f;
    NSInteger count = 0;
    width = (UI_SCREEN_WIDTH*0.8 - 45)/2;
    count = 2 ;
    
    for (int i =0; i<self.dataS.count; i++) {
        NSDictionary *dic = self.dataS[i];
        UIButton *button=[[UIButton alloc]init];
        [self addSubview:button];
        button.layer.cornerRadius=3.0;
        button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
        button.layer.borderWidth=0.5;
        button.tag=1000+i;
        button.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [button setTitle:dic[@"attrname"] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15+(width+15)*(i%count));
            make.top.mas_equalTo(self).offset(40+(i/count)*44);
            make.size.mas_equalTo(CGSizeMake(width, 32));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.selectArray containsObject:dic[@"attrid"]]) {
            [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
            button.layer.borderColor=Public_Red_Color.CGColor;
            button.selected=YES;
        }
    }
    //此处加一个拍摄类型UI
    if (self.type==ScreenCellTypeHeight || self.type==ScreenCellTypeWeight ||self.type==ScreenCellTypeAge) {
        CGFloat textFWidth = (UI_SCREEN_WIDTH*0.8-60)/2;
        UITextField *textField1 = [[UITextField alloc] init];
        textField1.backgroundColor=Public_Background_Color;
        textField1.layer.masksToBounds=YES;
        textField1.layer.cornerRadius=4.0;
        textField1.delegate=self;
        textField1.font=[UIFont systemFontOfSize:14];
        textField1.keyboardType=UIKeyboardTypeDecimalPad;
        textField1.textAlignment=NSTextAlignmentCenter;
        [self addSubview:textField1];
        [textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).offset(-15);
            make.bottom.equalTo(self).offset(-10);
            make.height.equalTo(@(32));
            make.width.equalTo(@(textFWidth));
        }];
        self.minTextF=textField1;
        
        UIView *lineV = [[UIView alloc] init];
        lineV.backgroundColor = [UIColor colorWithHexString:@"#353535"];
        [self addSubview: lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textField1);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(7, 1));
        }];
        
        UITextField *textField2 = [[UITextField alloc] init];
        textField2.backgroundColor=Public_Background_Color;
        textField2.layer.masksToBounds=YES;
        textField2.layer.cornerRadius=4.0;
        textField2.delegate=self;
        textField2.font=[UIFont systemFontOfSize:14];
        textField2.keyboardType=UIKeyboardTypeDecimalPad;
        textField2.textAlignment=NSTextAlignmentCenter;
        [self addSubview:textField2];
        [textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(15);
            make.bottom.equalTo(self).offset(-10);
            make.height.equalTo(@(32));
            make.width.equalTo(@(textFWidth));
        }];
        self.maxTextF=textField2;

        if (self.type==ScreenCellTypeAge)
        {
            self.minTextF.placeholder=@"最低年龄";
            self.maxTextF.placeholder=@"最高年龄";
        }
        else if (self.type==ScreenCellTypeHeight)   //身高
        {
            self.minTextF.placeholder=@"最低身高";
            self.maxTextF.placeholder=@"最高身高";
        }
        else if (self.type==ScreenCellTypeWeight)  //体重
        {
            self.minTextF.placeholder=@"最低体重";
            self.maxTextF.placeholder=@"最高体重";
        }
    }
}

-(void)clickType:(UIButton*)sender
{
    //选中输入框置空
    [self endEditing:YES];
    self.minTextF.text=@"";
    self.maxTextF.text=@"";
    
    //单选
    if (self.type==ScreenCellTypeCity) {
        for (int i = 0; i<self.dataS.count; i++) {
            UIButton * button = (UIButton*)[self viewWithTag:1000+i];
            if (i==sender.tag-1000) {
                [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
                button.layer.borderColor=Public_Red_Color.CGColor;
                button.selected=YES;
            }
            else
            {
                [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
                button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
                button.selected=NO;

            }
        }
        [self.selectArray removeAllObjects];
        if (sender.selected) {
            [self.selectArray addObject:sender.titleLabel.text];
        }
    }
    else     //多选
    {
        sender.selected=!sender.selected;
        if (sender.selected==YES) {
            sender.layer.borderColor=Public_Red_Color.CGColor;
            [sender setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
            
            if (![self.selectArray containsObject:@(sender.tag-1000+1)]) {
                [self.selectArray addObject:@(sender.tag-1000+1)];
            }
        }
        else
        {
            [sender setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            sender.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
            
            if ([self.selectArray containsObject:@(sender.tag-1000+1)]) {
                [self.selectArray removeObject:@(sender.tag-1000+1)];
            }
        }
    }
}

//广告类型加载这个视图
-(void)initParrt2
{
    for (UIView *view in self.subviews) {
        if (view.tag>=100) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat width = (UI_SCREEN_WIDTH*0.8 - 30 -10)/2;
    CGFloat Vheight = 0;
    NSArray *titleArr = @[@"视频广告",@"平面广告"];
    for (int i =0; i<self.dataS.count; i++) {
        NSArray *array = self.dataS[i][@"data"];
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor=[UIColor redColor];
        [self addSubview:view];
        CGFloat height = ((array.count-1)/2+1)*44 + 40;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(Vheight);
            make.height.mas_equalTo(height);
        }];
        
        Vheight = Vheight + height;

        UILabel *title=[[UILabel alloc]init];
        [view addSubview:title];
        title.font=[UIFont boldSystemFontOfSize:17.0];
        title.textColor=Public_Text_Color;
        title.text=titleArr[i];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(view).offset(10);
        }];

        for (int j =0; j<array.count; j++) {
            NSDictionary *dic = array[j];
            UIButton *button=[[UIButton alloc]init];
            [self addSubview:button];
            button.layer.cornerRadius=3.0;
            button.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
            button.layer.borderWidth=0.5;
            button.tag=1000+[dic[@"attrid"]integerValue];
            button.titleLabel.font=[UIFont systemFontOfSize:15.0];
            [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
            [button setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            [button setTitle:dic[@"attrname"] forState:UIControlStateNormal];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(15+(width+10)*(j%2));
                make.top.mas_equalTo(title.mas_bottom).offset(10+(j/2)*44);
                make.size.mas_equalTo(CGSizeMake(width, 32));
            }];
            [button addTarget:self action:@selector(clickType3:) forControlEvents:UIControlEventTouchUpInside];
            
            if ([self.selectArray containsObject:dic[@"attrid"]]) {
                [button setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
                button.layer.borderColor=Public_Red_Color.CGColor;
                button.selected=YES;
            }
        }
    }
    
  
}

-(void)clickType3:(UIButton*)sender
{
    //多选
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        sender.layer.borderColor=Public_Red_Color.CGColor;
        [sender setBackgroundColor:[Public_Red_Color colorWithAlphaComponent:0.1]];
    }
    else
    {
        [sender setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        sender.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
    }
    
    if (sender.selected) {
        if (![self.selectArray containsObject:@(sender.tag-1000)]) {
            [self.selectArray addObject:@(sender.tag-1000)];
        }
    }
    else
    {
        if ([self.selectArray containsObject:@(sender.tag-1000)]) {
            [self.selectArray removeObject:@(sender.tag-1000)];
        }
    }

}

-(void)allcCancleSelect
{
    self.minTextF.text=@"";
    self.maxTextF.text=@"";
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)obj;
            btn.selected=NO;
            [btn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            btn.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
        }
    }
    [self.selectArray removeAllObjects];
}

//开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)obj;
            btn.selected=NO;
            [btn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            btn.layer.borderColor=[UIColor colorWithHexString:@"#F5F5F5"].CGColor;
        }
    }
    [self.selectArray removeAllObjects];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger maxLenght=0;  //位数
    if (self.type==ScreenCellTypeAge)          //年龄
    {
        maxLenght=2;
    }
    else if (self.type==ScreenCellTypeHeight||self.type==ScreenCellTypeWeight)   //身高,体重
    {
        maxLenght=3;
    }
    
    if (textField.text.length == maxLenght) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        else {
            return NO;
        }
    }
    return [self validateNumber:string];
}

//输入框只能是数字
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


@end
