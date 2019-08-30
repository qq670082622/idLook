//
//  VideoListPopV.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/12.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoListPopV.h"

@interface VideoListPopV ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView *maskV;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITextField *minTextF;
@property (nonatomic,strong)UITextField *maxTextF;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,assign)CGFloat viewHeight;  //高度
@property (nonatomic,assign)ScreenCellType type;
@property (nonatomic,strong)NSDictionary *selectDic;
@end

@implementation VideoListPopV

- (id)init
{
    if(self=[super init])
    {
        
    }
    return self;
}

-(NSMutableArray*)selectArray
{
    if (!_selectArray) {
        _selectArray=[NSMutableArray new];
    }
    return _selectArray;
}


- (void)showWithLoad:(BOOL)isLoading withMasteryType:(NSInteger)mastery withType:(ScreenCellType)type withVideoType:(NSInteger)videoType withOffY:(CGFloat)offY withSelectDic:(NSDictionary *)dic
{
    self.type=type;
    self.selectDic=dic;
    [self getDataWithType:type withMastey:mastery withVideoType:videoType];
    [self getSelectWithDic:dic];
    
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
    
    //当window上有视图时移除
    for (UIView *view in showWindow.subviews) {
        if ([view isKindOfClass:[VideoListPopV class]]) {
            VideoListPopV *popV = (VideoListPopV*)view;
            [popV hide];
        }
    }
    
    if (isLoading==NO) {
        return;
    }
    
    CGFloat frameY ;
    if (offY<48) {
        frameY = 96 - offY;
    }
    else
    {
        frameY = 48;
    }
    
    self.frame=CGRectMake(0,SafeAreaTopHeight+frameY, showWindow.bounds.size.width, showWindow.bounds.size.height-SafeAreaTopHeight-frameY);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    
    UIView *maskV = [[UIView alloc] initWithFrame:CGRectMake(0,-self.viewHeight,UI_SCREEN_WIDTH, self.viewHeight)];
    maskV.backgroundColor = [UIColor whiteColor];
    maskV.userInteractionEnabled=YES;
    maskV.alpha = 0.f;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    tap1.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    [showWindow addSubview:self];
    [self addSubview:maskV];
    self.clipsToBounds=YES;
    self.maskV=maskV;
    
    [self initUIWithSelect:type];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    maskV.alpha = 1.f;
    
    self.maskV.frame = CGRectMake(0,0, UI_SCREEN_WIDTH,self.viewHeight);
    
    [UIView commitAnimations];
}

-(void)hideAction
{
    if (self.hideBlock) {
        self.hideBlock();
    }
    [self hide];
}

-(void)endEdit
{
    [self endEditing:YES];
}

- (void)clearSubV
{
    [self removeFromSuperview];
    [self.maskV removeFromSuperview];
}

- (void)hide
{
    [self endEditing:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.alpha = 0.f;
    
    self.maskV.frame = CGRectMake(0,-self.viewHeight,UI_SCREEN_WIDTH,self.viewHeight);
    
    [UIView commitAnimations];
}

-(void)initUIWithSelect:(ScreenCellType)type
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.maskV addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV);
        make.right.mas_equalTo(self.maskV);
        make.top.mas_equalTo(self.maskV);
        if (type==ScreenCellTypeSex || type==ScreenCellTypeNationality) {
            make.bottom.mas_equalTo(self.maskV).offset(-48);
        }
        else
        {
            make.bottom.mas_equalTo(self.maskV).offset(-105);

        }
    }];
    scrollView.contentSize=CGSizeMake(0,42*(self.dataSource.count+1)/2);
    self.scrollView=scrollView;
    
    CGFloat width  = (UI_SCREEN_WIDTH-45)/2;
    for (int i=0; i<self.dataSource.count; i++) {
        NSDictionary *dic = self.dataSource[i];
        UIButton *button=[[UIButton alloc]init];
        [self.scrollView addSubview:button];
        button.tag=1000+i;
        button.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#353535"] forState:UIControlStateNormal];
        [button setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [button setImage:[[UIImage alloc]init] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"auth_choose"] forState:UIControlStateSelected];
        [button setTitle:dic[@"attrname"] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.scrollView).offset(15+(width+15)*(i%2));
            make.top.mas_equalTo(self.scrollView).offset(24+(i/2)*40);
            make.size.mas_equalTo(CGSizeMake(width, 28));
        }];
        button.imageEdgeInsets=UIEdgeInsetsMake(0,-3, 0, 3);
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.selectArray containsObject:dic]) {
            button.selected=YES;
        }
    }
    
    CGFloat textFWidth = (UI_SCREEN_WIDTH-60)/2;
    UITextField *textField1 = [[UITextField alloc] init];
    textField1.backgroundColor=Public_Background_Color;
    textField1.layer.masksToBounds=YES;
    textField1.layer.cornerRadius=4.0;
    textField1.placeholder=@"最低价";
    textField1.delegate=self;
    textField1.font=[UIFont systemFontOfSize:14];
    textField1.keyboardType=UIKeyboardTypeDecimalPad;
    textField1.textAlignment=NSTextAlignmentCenter;
    [self.maskV addSubview:textField1];
    [textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.maskV.mas_centerX).offset(-15);
        make.bottom.equalTo(self.maskV).offset(-77);
        make.height.equalTo(@(28));
        make.width.equalTo(@(textFWidth));
    }];
    self.minTextF=textField1;
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = [UIColor colorWithHexString:@"#353535"];
    [self.maskV addSubview: lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(textField1);
        make.centerX.mas_equalTo(self.maskV);
        make.size.mas_equalTo(CGSizeMake(9, 1));
    }];
    
    UITextField *textField2 = [[UITextField alloc] init];
    textField2.backgroundColor=Public_Background_Color;
    textField2.layer.masksToBounds=YES;
    textField2.layer.cornerRadius=4.0;
    textField2.placeholder=@"最高价";
    textField2.delegate=self;
    textField2.font=[UIFont systemFontOfSize:14];
    textField2.keyboardType=UIKeyboardTypeDecimalPad;
    textField2.textAlignment=NSTextAlignmentCenter;
    [self.maskV addSubview:textField2];
    [textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.maskV.mas_centerX).offset(15);
        make.bottom.equalTo(self.maskV).offset(-77);
        make.height.equalTo(@(28));
        make.width.equalTo(@(textFWidth));
    }];
    self.maxTextF=textField2;
    
    UIButton *resetBtn=[[UIButton alloc]init];
    [self.maskV addSubview:resetBtn];
    resetBtn.layer.borderColor=Public_LineGray_Color.CGColor;
    resetBtn.layer.borderWidth=0.5;
    resetBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [resetBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskV);
        make.bottom.mas_equalTo(self.maskV);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH/2, 48));
    }];
    [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmBtn=[[UIButton alloc]init];
    [self.maskV addSubview:confirmBtn];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.backgroundColor=Public_Red_Color;
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.maskV);
        make.size.mas_equalTo(CGSizeMake(UI_SCREEN_WIDTH/2, 48));
    }];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (type==ScreenCellTypeSex || type==ScreenCellTypeNationality) {
        self.minTextF.hidden=YES;
        self.maxTextF.hidden=YES;
        lineV.hidden=YES;
    }
    else
    {
        if (type==ScreenCellTypePrice) {
            self.minTextF.placeholder=@"最低价";
            self.maxTextF.placeholder=@"最高价";
            self.minTextF.text=self.selectDic[@"pricestart"];
            self.maxTextF.text=self.selectDic[@"priceend"];
        }
        else if (type==ScreenCellTypeAge)
        {
            self.minTextF.placeholder=@"最低年龄";
            self.maxTextF.placeholder=@"最高年龄";
            
            self.minTextF.text=self.selectDic[@"agestart"];
            self.maxTextF.text=self.selectDic[@"ageend"];
        }
        else if (self.type==ScreenCellTypeHeight)   //身高
        {
            self.minTextF.placeholder=@"最低身高";
            self.maxTextF.placeholder=@"最高身高";
            self.minTextF.text=self.selectDic[@"heightstart"];
            self.maxTextF.text=self.selectDic[@"heightend"];
        }
    }
}

-(void)clickType:(UIButton*)sender
{
    [self endEditing:YES];
    self.minTextF.text=@"";
    self.maxTextF.text=@"";
    
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        if (![self.selectArray containsObject:self.dataSource[sender.tag-1000]]) {
            [self.selectArray addObject:self.dataSource[sender.tag-1000]];
        }
    }
    else
    {
        if ([self.selectArray containsObject:self.dataSource[sender.tag-1000]]) {
            [self.selectArray removeObject:self.dataSource[sender.tag-1000]];
        }
    }
}

//重置
-(void)resetAction
{
    for (int i=0; i<self.dataSource.count; i++) {
        UIButton *button = [self.maskV viewWithTag:1000+i];
        button.selected=NO;
    }
    [self.selectArray removeAllObjects];
    self.minTextF.text=@"";
    self.maxTextF.text=@"";
}

//确定
-(void)confirmAction
{
    NSMutableArray *sec = [NSMutableArray new];
    for (int i=0; i<self.selectArray.count; i++)
    {
        NSDictionary *dic = self.selectArray[i];
        [sec addObject:dic[@"attrname"]];
    }
    NSString *tempString = [sec componentsJoinedByString:@","];//分隔符逗号
    
    //当没有选中，手动输入时
    if (sec.count==0) {
        NSString *string1 =@"";
        if (self.type==ScreenCellTypeAge)          //年龄
        {
            string1=@"岁";
        }
        else if (self.type==ScreenCellTypePrice)   //价格
        {
            string1=@"元";
        }
        else if (self.type==ScreenCellTypeHeight)   //身高
        {
            string1=@"cm";
        }
        
        
        if (self.minTextF.text.length>0&&self.maxTextF.text.length>0) {
            tempString = [NSString stringWithFormat:@"%@-%@%@",self.minTextF.text,self.maxTextF.text,string1];
            if ([self.minTextF.text integerValue]>[self.maxTextF.text integerValue]) {
                tempString = [NSString stringWithFormat:@"%@-%@%@",self.maxTextF.text,self.minTextF.text,string1];
            }
        }
        else if (self.minTextF.text.length>0&&self.maxTextF.text.length==0)
        {
            tempString = [NSString stringWithFormat:@"%@%@以上",self.minTextF.text,string1];

        }
        else if (self.minTextF.text.length==0&&self.maxTextF.text.length>0)
        {
            tempString = [NSString stringWithFormat:@"%@%@以下",self.maxTextF.text,string1];
        }
    }
    
    
    if (self.compClickBlock) {
        self.compClickBlock([self getSelectData], tempString);
    }
    [self hide];
}

-(void)getDataWithType:(ScreenCellType)type withMastey:(NSInteger)mastery withVideoType:(NSInteger)videType
{
    NSDictionary *dic=[UserInfoManager getPublicConfig];
    BOOL isShowTextField = YES;
    
    if (type==ScreenCellTypePrice)
    {
        if (mastery==1) {
            self.dataSource  = (NSArray*)safeObjectForKey(dic, @"priceGroup");
        }
        else if (mastery==2)
        {
            self.dataSource  = (NSArray*)safeObjectForKey(dic, @"filmActorPriceGroup");
        }
        else if (mastery==3)
        {
            self.dataSource  = (NSArray*)safeObjectForKey(dic, @"foreignModelPriceGroup");
        }
        else if (mastery==4)
        {
            self.dataSource  = (NSArray*)safeObjectForKey(dic, @"filmActorPriceGroup");
        }
//        else if (mastery==5) //价格
//        {
//          
//            self.dataSource =
//        }
    }
    else if (type==ScreenCellTypeAge)
    {
        if (mastery==1) {
            NSArray *array =dic [@"categoryType"];
            NSDictionary *dicA ;
            for (int i=0; i<array.count; i++) {
                NSDictionary *dicB = array[i];
                if ([dicB[@"cateid"]integerValue]==videType)
                {
                    dicA = dicB[@"attribute"];
                }
            }
            NSDictionary *dicC= dicA[@"ageGroupType"];
            NSArray *array2 = dicC[@"ageRange"];
            self.dataSource = array2;
        }else if (mastery==5)//年龄
        {
          
        }
        else
        {
            self.dataSource  = (NSArray*)safeObjectForKey(dic, @"filmActorAgeGroup");
        }
    }
    else if (type==ScreenCellTypeHeight)
    {
        self.dataSource  = (NSArray*)safeObjectForKey(dic, @"heightType");
    }
    else if (type==ScreenCellTypeSex)
    {
        self.dataSource = @[@{@"attrid":@(1),@"attrname":@"男"},
                            @{@"attrid":@(2),@"attrname":@"女"}];
        if (mastery==5) {
            self.dataSource = @[@{@"attrid":@(1),@"attrname":@"男"},
                                @{@"attrid":@(2),@"attrname":@"女"},
                                @{@"attrid":@(3),@"attrname":@"不限"}
                                ];
        }
    }
    else if (type==ScreenCellTypeNationality)
    {
        self.dataSource  = (NSArray*)safeObjectForKey(dic, @"searchCountry");
    }
    
    if (type==ScreenCellTypeSex || type==ScreenCellTypeNationality) {
        isShowTextField=NO;
    }
    
    CGFloat dataHeight = ((self.dataSource.count-1)/2 + 1) * 42;
    if (dataHeight>200) {
        dataHeight=200;
    }
    
    self.viewHeight = 48  + dataHeight + 30+(isShowTextField==YES?60:0);
}

-(NSDictionary*)getSelectData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<self.selectArray.count; i++)
    {
        NSDictionary *dic = self.selectArray[i];
        if (self.type==ScreenCellTypeNationality) {  //国籍传字符串
            [array addObject:dic[@"attrname"]];
        }
        else  //其他传id
        {
            [array addObject:dic[@"attrid"]];
        }
    }
    NSString *tempString = [array componentsJoinedByString:@","];//分隔符逗号
    if (self.type==ScreenCellTypeAge)          //年龄
    {
        [dic setObject:tempString forKey:@"age"];
        if (([self.minTextF.text integerValue]>[self.maxTextF.text integerValue])&&[self.maxTextF.text integerValue]>0) {
            [dic setObject:self.maxTextF.text forKey:@"agestart"];
            [dic setObject:self.minTextF.text forKey:@"ageend"];
        }
        else
        {
            [dic setObject:self.minTextF.text forKey:@"agestart"];
            [dic setObject:self.maxTextF.text forKey:@"ageend"];
        }
    }
    else if (self.type==ScreenCellTypePrice)   //价格
    {
        [dic setObject:tempString forKey:@"price"];

        if (([self.minTextF.text integerValue]>[self.maxTextF.text integerValue])&&[self.maxTextF.text integerValue]>0) {
            [dic setObject:self.maxTextF.text forKey:@"pricestart"];
            [dic setObject:self.minTextF.text forKey:@"priceend"];
        }
        else
        {
            [dic setObject:self.minTextF.text forKey:@"pricestart"];
            [dic setObject:self.maxTextF.text forKey:@"priceend"];
        }
    }
    else if (self.type==ScreenCellTypeHeight)   //身高
    {
        [dic setObject:tempString forKey:@"height"];
        if (([self.minTextF.text integerValue]>[self.maxTextF.text integerValue])&&[self.maxTextF.text integerValue]>0) {
            [dic setObject:self.maxTextF.text forKey:@"heightstart"];
            [dic setObject:self.minTextF.text forKey:@"heightend"];
        }
        else
        {
            [dic setObject:self.minTextF.text forKey:@"heightstart"];
            [dic setObject:self.maxTextF.text forKey:@"heightend"];
        }
    }
    else if (self.type==ScreenCellTypeSex)  //性别
    {
        [dic setObject:tempString forKey:@"sex"];

    }
    else if (self.type==ScreenCellTypeNationality)  //国籍
    {
        [dic setObject:tempString forKey:@"nat"];
    }
    return dic;
}

-(void)getSelectWithDic:(NSDictionary*)dic
{
    NSString *tempStr = @"";
    if (self.type==ScreenCellTypeAge)          //年龄
    {
        tempStr = dic[@"age"];
    }
    else if (self.type==ScreenCellTypePrice)   //价格
    {
        tempStr = dic[@"price"];
    }
    else if (self.type==ScreenCellTypeHeight)   //身高
    {
        tempStr = dic[@"height"];
    }
    else if (self.type==ScreenCellTypeSex)  //性别
    {
        tempStr = dic[@"sex"];
    }
    else if (self.type==ScreenCellTypeNationality)  //国籍
    {
        tempStr = dic[@"nat"];
    }
    
    NSArray *selectArr = [tempStr componentsSeparatedByString:@","];
    
    for (int i=0; i<self.dataSource.count; i++) {
        NSDictionary *dicA = self.dataSource[i];
        if (self.type==ScreenCellTypeNationality) {  //国籍匹配attrname
            NSString *attrname =(NSString *)safeObjectForKey(dicA, @"attrname");
            if ([selectArr containsObject:attrname]) {
                [self.selectArray addObject:dicA];
            }
        }
        else
        {
            NSString *attrid =[NSString stringWithFormat:@"%ld",(long)[(NSNumber *)safeObjectForKey(dicA, @"attrid") integerValue]];
            if ([selectArr containsObject:attrid]) {
                [self.selectArray addObject:dicA];
            }
        }

    }
    
}

//开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    for (int i=0; i<self.dataSource.count; i++) {
        UIButton *button = [self.maskV viewWithTag:1000+i];
        button.selected=NO;
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
    else if (self.type==ScreenCellTypePrice)   //价格
    {
        maxLenght=6;
    }
    else if (self.type==ScreenCellTypeHeight)   //身高
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
