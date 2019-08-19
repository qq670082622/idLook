//
//  CitiesView.m
//  IDLook
//
//  Created by 吴铭 on 2019/7/26.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CitiesView.h"
#import "CityModelNew.h"
@interface CitiesView()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (weak, nonatomic) IBOutlet UIView *hotCityView;
@property (weak, nonatomic) IBOutlet UIView *indexesView;

@property(nonatomic,strong)NSMutableArray *selectArr;
@end
@implementation CitiesView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CitiesView" owner:nil options:nil] lastObject];
        //  [self initSubViews];
    }
    return self;
}

-(void)reloadUIWithSelectCities:(NSArray *)cities
{
    self.selectArr = [NSMutableArray arrayWithArray:cities];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ShotCity" ofType:@"plist"];
    NSArray *array =  [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSMutableArray *allCity = [NSMutableArray new];
    for (NSDictionary *cityDic in array) {
        NSArray *cities = cityDic[@"Cities"];
        if (cities.count==0) {//直辖市
            NSString *singleCity = cityDic[@"State"];
            [allCity addObject:singleCity];
        }else if (cities.count>0){//一般省辖市
            for (NSDictionary *subCityDic in cities) {
                NSString *cityName = subCityDic[@"city"];
                [allCity addObject:cityName];
            }
        }
    }
    NSArray *cityModels = [self createModelWithityNameAndArr:allCity];
    NSMutableArray *azArr = [NSMutableArray new];
    for(int i='A';i<='Z';i++){
        NSString *str1 = [NSString stringWithFormat:@"%c",i];
        if ([str1 isEqualToString:@"I"]||[str1 isEqualToString:@"O"]||[str1 isEqualToString:@"U"]||[str1 isEqualToString:@"V"]) {
            continue;
        }
        NSMutableArray *rulesArray = [[NSMutableArray alloc] init];
        for(int j=0;j<cityModels.count;j++){
            CityModelNew *cm = cityModels[j];
            NSString *firstChar = cm.firstChar;
            if ([firstChar isEqualToString:str1]) {
                [rulesArray addObject:cm];
            }
        }
        [azArr addObject:rulesArray];//[[model,model.model],[model,model,model],[model,model,model],[model,model,model],[model,model,model,model]]
    }
    //当前选择
    CGFloat wid = (self.selectedView.width-27)/3;
    for(int i=0;i<_selectArr.count;i++){
        CGFloat x = i*9+i*wid;
        CGFloat y = 33;
        NSString *cityName = _selectArr[i];
        UIButton *cityBtn = [self createRedBtnWithTitle:cityName];
        cityBtn.frame = CGRectMake(x,y,wid,36);
        [self.selectedView addSubview:cityBtn];
    }
    self.selectedView.height = 81;
    //热门城市
    NSArray *hotCities = @[@"北京",@"上海",@"杭州",@"苏州",@"广州",@"深圳",@"重庆",@"天津"];
    for(int i=0;i<hotCities.count;i++){
        if (i>3) {
            i-=4;
        }
        CGFloat x = i*9+i*wid;
        CGFloat y = 33;
        NSString *cityName = _selectArr[i];
        UIButton *cityBtn = [self createRedBtnWithTitle:cityName];
        cityBtn.frame = CGRectMake(x,y,wid,36);
        [self.hotCityView addSubview:cityBtn];
    }
    self.hotCityView.frame = CGRectMake(0, _selectedView.bottom, UI_SCREEN_WIDTH-30, 133);
    //索引
    NSArray *chars = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
    CGFloat charWid = (self.selectedView.width-56)/8;
    for(int i=0;i<chars.count;i++){
       CGFloat y = 33;
        if (i>7) {
            i-=8;
            y = 77;
        }else if (i>15){
            i-=16;
            y = 121;
        }
        CGFloat x = i*8+i*wid;
        NSString *charName = chars[i];
        UIButton *charBtn = [self createRedBtnWithTitle:charName];
        charBtn.frame = CGRectMake(x,y,charWid,charWid);
        [self.indexesView addSubview:charBtn];
    }
    //所有城市
    CGFloat charY = 200;
    for (int i = 0; i<chars.count; i++) {
        NSString *charString = chars[i];
        UILabel *charLabel = [UILabel new];
        charLabel.text = charString;
        charLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        charLabel.textColor = [UIColor colorWithHexString:@"464646"];
        charLabel.frame = CGRectMake(15, charY, 22, 22);
        [self.indexesView addSubview:charLabel];
      
        CGFloat cityY = charLabel.bottom+12;
        NSArray *charCities = azArr[i];
        for(int j = 0; j<charCities.count;j++){
            CityModelNew *cm = charCities[j];
            UIButton *cityBtn = [self createRedBtnWithTitle:cm.name];
            NSInteger row = (j+1)/4;
            NSInteger beyond = (j+1)%4;
            cityY = cityY+44*row;
            CGFloat cityX = beyond*9+beyond*wid;
            cityBtn.frame = CGRectMake(cityX, cityY, wid, 36);
            [self.indexesView addSubview:cityBtn];
            charY = cityBtn.bottom+20;
        }
    }
    self.indexesView.frame = CGRectMake(0, self.hotCityView.bottom, UI_SCREEN_WIDTH, charY);
    self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, _indexesView.bottom);
    NSLog(@"所有市:%@",allCity);
}
-(NSArray *)createModelWithityNameAndArr:(NSArray *)cities
{
    NSMutableArray *cityModels = [NSMutableArray new];
    for (NSString *cityName in cities) {
        NSMutableString *ms = [[NSMutableString alloc]initWithString:cityName];
        //带声仄 //不能注释掉
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformMandarinLatin, NO)) {
            //                        NSLog(@"pinyin: ---- %@", ms);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics, NO)) {
            NSString *bigStr = [ms uppercaseString]; // bigStr 是转换成功后的拼音
            NSString *cha = [bigStr substringToIndex:1];
            CityModelNew *model = [CityModelNew new];
            model.name = cityName;
            model.firstChar = cha;// cha 是汉字的首字母
            [cityModels addObject:model];
            NSLog(@"pinyin: %@ ======== %@ ====== %@",cityName,model,cha);
        }
    }
    //第二步 根据第一步获取到的 拼音首字母 对汉字进行排序
    return [cityModels copy];
}


-(UIButton *)createRedBtnWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setTitle:title forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
    btn.layer.borderWidth = 0.5;
    [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
    if ([_selectArr containsObject:title]) {
         btn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
         [btn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
    }
    [btn addTarget:self action:@selector(CityBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(void)CityBtnAction:(id)sender
{
    UIButton *cityBtn = (UIButton *)sender;
    NSString *cityName = cityBtn.titleLabel.text;
    if (cityName.length==1) {//说明是字母索引
        for (id any in self.indexesView.subviews) {
            if ([any isKindOfClass:[UILabel class]]) {
                UILabel *charIndex = (UILabel *)any;
                if ([charIndex.text isEqualToString:cityName]) {
                    self.scrollView.contentOffset = CGPointMake(0, self.indexesView.y + charIndex.y);
                }
            }
        }
        return;
    }
    //说明是选择城市
    if ([_selectArr containsObject:cityName]) {
        cityBtn.layer.borderColor = [UIColor colorWithHexString:@"464646"].CGColor;
        [cityBtn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        [_selectArr removeObject:cityName];
    }else{
        cityBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
        [cityBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
        [_selectArr addObject:cityName];
    }
    
   
    //清楚按钮重新添加
    for (id any in self.selectedView.subviews) {
        if ([any isKindOfClass:[UIButton class]]) {
            [any removeFromSuperview];
        }
    }
     CGFloat wid = (self.selectedView.width-27)/3;
    for(int i=0;i<_selectArr.count;i++){
        CGFloat x = i*9+i*wid;
        CGFloat y = 33;
        NSString *cityName = _selectArr[i];
        UIButton *cityBtn = [self createRedBtnWithTitle:cityName];
        cityBtn.frame = CGRectMake(x,y,wid,36);
        [self.selectedView addSubview:cityBtn];
    }
}
- (IBAction)close:(id)sender {
    self.close();
}
@end
