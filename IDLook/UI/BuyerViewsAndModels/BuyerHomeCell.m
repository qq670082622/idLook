//
//  BuyerHomeCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "BuyerHomeCell.h"
#import "WWSliderView.h"
@interface BuyerHomeCell()
{
    NSInteger tagLimit;
    NSInteger locationLimit;
    NSInteger platformLimit;
}
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn;
- (IBAction)tagAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *platView;
@property (weak, nonatomic) IBOutlet UILabel *platLabel;
@property (weak, nonatomic) IBOutlet UIButton *platBtn;
- (IBAction)platAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *regionView;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UIButton *regionBtn;
- (IBAction)regionAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UIView *ageView;
@property(nonatomic, strong)WWSliderView *rangeSlider;

@property(nonatomic,strong)NSArray *tags;
@property(nonatomic,strong)NSArray *plats;
@property(nonatomic,strong)NSArray *regions;
- (IBAction)searchAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

@implementation BuyerHomeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"BuyerHomeCell";
    BuyerHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BuyerHomeCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // cell.contentView.backgroundColor = [UIColor whiteColor];
    }
   
    return cell;
}
-(void)setModel:(BuyerConditionModel *)model
{
    _model = model;
    NSDictionary *config = [WriteFileManager readObject:@"homeConfig"];
    tagLimit = [config[@"tagLimit"] integerValue];
    locationLimit = [config[@"locationLimit"]integerValue];
    platformLimit = [config[@"platformLimit"]integerValue];
    NSArray *tags = config[@"tag"];//@[@"美妆",@"旅游",@"数码",@"汽车",@"时尚",@"母婴",@"食品",@"家具",@"服装"];
    self.tags = [NSArray arrayWithArray:tags];
    NSArray *plats = config[@"platform"];//@[@"抖音",@"微博",@"小红书"];
    self.plats = [NSArray arrayWithArray:plats];
    NSArray *regions = config[@"location"];//@[@"北京",@"上海",@"广州",@"深圳"];
    self.regions = [NSArray arrayWithArray:regions];
    NSArray *sexs = @[@"男",@"女",@"不限"];
    NSArray *ages = @[@"10岁以下",@"10-20岁",@"20-40岁",@"40-60岁",@"60-80岁",@"80岁以上"];
    
    CGFloat tagWid = (UI_SCREEN_WIDTH-30-27)/4;
    CGFloat wid = (UI_SCREEN_WIDTH-30-27)/3;
    
    CGFloat tagHei = 0;
     CGFloat platHei = 0;
     CGFloat regionHei = 0;
     CGFloat sexHei = 102;
     CGFloat ageHei = 200;
    
    //标签
    for(int i = 0;i<tags.count;i++){
        NSInteger row = i/4;
         NSInteger yu = i%4;
        
        CGFloat x = yu*(tagWid+9)+15;//余出*(宽+间隔)+第一个按钮x
        CGFloat y = row*(32+9)+40;//行数*(高+间隔)+第一个按钮y
        if (!_model.tagOpen && i==8) {
            break;
        }
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, tagWid, 32);
        NSString *title = tags[i][@"name"];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+100];
        if ([_model.tags containsObject:title]) {
            [btn setTitleColor:Public_Red_Color forState:0];
            btn.layer.borderColor = Public_Red_Color.CGColor;
        }
        [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tagView addSubview:btn];
        tagHei = btn.bottom+30;
    }
    if (_model.tagOpen) {//展开要关闭
      [self.tagBtn setImage:[UIImage imageNamed:@"talent_search_arrow_s"] forState:0];
    }else{//关闭要展开
      [self.tagBtn setImage:[UIImage imageNamed:@"talent_search_arrow_n"] forState:0];
    }
    self.tagLabel.text = [_model.tags componentsJoinedByString:@" "];
    self.tagView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, tagHei);
    
    //网络平台
    for(int i = 0;i<plats.count;i++){
        NSInteger row = i/3;
        NSInteger yu = i%3;
        if (!_model.platOpen && i==3) {
                   break;
               }
        CGFloat x = yu*(wid+9)+15;//余出*(宽+间隔)+第一个按钮x
        CGFloat y = row*(32+9)+40;//行数*(高+间隔)+第一个按钮y
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 32);
        NSString *title = plats[i][@"name"];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+200];
        if ([_model.platTypes containsObject:title]) {
            [btn setTitleColor:Public_Red_Color forState:0];
            btn.layer.borderColor = Public_Red_Color.CGColor;
        }
        [btn addTarget:self action:@selector(platBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.platView addSubview:btn];
        platHei = btn.bottom+30;
    }
    if (_model.platOpen) {//展开要关闭
        [self.platBtn setImage:[UIImage imageNamed:@"talent_search_arrow_s"] forState:0];
      }else{//关闭要展开
        [self.platBtn setImage:[UIImage imageNamed:@"talent_search_arrow_n"] forState:0];
      }
    self.platLabel.text = [_model.platTypes componentsJoinedByString:@" "];
     self.platView.frame = CGRectMake(0, tagHei, UI_SCREEN_WIDTH, platHei);
    
    //所在地
    for(int i = 0;i<regions.count;i++){
        NSInteger row = i/3;
        NSInteger yu = i%3;
        if (!_model.regionOpen && i==3) {
                   break;
               }
        CGFloat x = yu*(wid+9)+15;//余出*(宽+间隔)+第一个按钮x
        CGFloat y = row*(32+9)+40;//行数*(高+间隔)+第一个按钮y
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 32);
        NSString *title = regions[i][@"name"];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+300];
        if ([_model.regions containsObject:title]) {
            [btn setTitleColor:Public_Red_Color forState:0];
            btn.layer.borderColor = Public_Red_Color.CGColor;
        }
        [btn addTarget:self action:@selector(regionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.regionView addSubview:btn];
        regionHei = btn.bottom+30;
    }
    if (_model.regionOpen) {//展开要关闭
        [self.regionBtn setImage:[UIImage imageNamed:@"talent_search_arrow_s"] forState:0];
      }else{//关闭要展开
        [self.regionBtn setImage:[UIImage imageNamed:@"talent_search_arrow_n"] forState:0];
      }
    self.regionLabel.text = [_model.regions componentsJoinedByString:@" "];
     self.regionView.frame = CGRectMake(0, _platView.bottom, UI_SCREEN_WIDTH, regionHei);
    
    //性别
    for(int i = 0;i<sexs.count;i++){
        NSInteger row = i/3;
        NSInteger yu = i%3;
        
        CGFloat x = yu*(wid+9)+15;//余出*(宽+间隔)+第一个按钮x
        CGFloat y = row*(32+9)+40;//行数*(高+间隔)+第一个按钮y
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 32);
        NSString *title = sexs[i];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+400];
        if (_model.sex == i) {
            [btn setTitleColor:Public_Red_Color forState:0];
            btn.layer.borderColor = Public_Red_Color.CGColor;
//             NSString *sexStr = [sexs objectAtIndex:_model.sex];
              self.sexLabel.text = title;
        }
        [btn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.sexView addSubview:btn];
       
    }
   
 
     self.sexView.frame = CGRectMake(0, _regionView.bottom, UI_SCREEN_WIDTH, sexHei);
    
    //年龄
    CGRect sliderFrame = CGRectMake(-15, 40,UI_SCREEN_WIDTH+30, 50);
    UIColor *color1 = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    UIColor *color2 = [UIColor whiteColor];//[UIColor colorWithRed:22/255.0 green:145/255.0 blue:153/255.0 alpha:1];
    UIColor *color3 = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:87/255.0 alpha:1];
    UIColor *color4 = [UIColor whiteColor];//[UIColor colorWithRed:244/255.0 green:77/255.0 blue:84/255.0 alpha:1];
    UIColor *color5 = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:87/255.0 alpha:1];
    
    
    _rangeSlider = [[WWSliderView alloc] initWithFrame:sliderFrame
                                           sliderColor:color1
                                        leftSmallColor:color2
                                          leftBigColor:color3
                                       rightSmallColor:color4
                                         rightBigColor:color5];
    
    //1.先设置最左边数值、最右边数值（0-24）
    _rangeSlider.minimumValue = 0;
    _rangeSlider.maximumValue = 100;
    _rangeSlider.type = @"岁";
    if (model.age_min==0&&model.age_max==0) {
        model.age_min = 20;
        model.age_max = 40;
    }
    //2.再设置两个滑块位置
    [_rangeSlider resetLeftValue:model.age_min rightValue:model.age_max];
    [self.ageView addSubview:_rangeSlider];
    for(int i = 0;i<ages.count;i++){
        NSInteger row = i/3;
        NSInteger yu = i%3;
        
        CGFloat x = yu*(wid+9)+15;//余出*(宽+间隔)+第一个按钮x
        CGFloat y = row*(32+9)+100;//行数*(高+间隔)+第一个按钮y
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(x, y, wid, 32);
        NSString *title = ages[i];
        [btn setTitle:title forState:0];
        [btn setTitleColor:[UIColor colorWithHexString:@"464646"] forState:0];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn setTag:i+500];
      [btn addTarget:self action:@selector(ageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.ageView addSubview:btn];
        
    }
    self.ageView.frame = CGRectMake(0, _sexView.bottom, UI_SCREEN_WIDTH, ageHei);
    _searchBtn.frame = CGRectMake((UI_SCREEN_WIDTH-310)/2, _ageView.bottom, 310, 64);
    
    
    self.cellHei = _searchBtn.bottom;
    
    
}
//标签按钮被点击
-(void)tagBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
   if ([_model.tags containsObject:btn.titleLabel.text]) {//包含
        [_model.tags removeObject:btn.titleLabel.text];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        [btn setTitleColor:Public_Text_Color forState:0];
    }else{//不包含
        if (_model.tags.count==tagLimit) {
            NSString *removeTitle = [_model.tags objectAtIndex:0];
            [_model.tags removeObject:removeTitle];
            for (id any in _tagView.subviews) {
                if (![any isKindOfClass:[UIButton class]]) {
                    continue;
                }
                UIButton *tagBtn = (UIButton *)any;
                if ([tagBtn.titleLabel.text isEqualToString:removeTitle]) {
                    tagBtn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
                    [tagBtn setTitleColor:Public_Text_Color forState:0];
                    break;
                }
            }
        }
        [_model.tags addObject:btn.titleLabel.text];
        [btn setTitleColor:Public_Red_Color forState:0];
        btn.layer.borderColor = Public_Red_Color.CGColor;
    }
       self.tagLabel.text = [_model.tags componentsJoinedByString:@" "];
}
-(void)platBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([_model.platTypes containsObject:btn.titleLabel.text]) {//包含
        return;
//        [_model.platTypes removeObject:btn.titleLabel.text];
//        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
//        [btn setTitleColor:Public_Text_Color forState:0];
    }else{//不包含
        if (_model.platTypes.count==platformLimit) {
            NSString *removeTitle = [_model.platTypes objectAtIndex:0];
            [_model.platTypes removeObject:removeTitle];
            for (UIButton *any in _platView.subviews) {
                if (![any isKindOfClass:[UIButton class]]) {
                    continue;
                }
                UIButton *tagBtn = (UIButton *)any;
                if ([tagBtn.titleLabel.text isEqualToString:removeTitle]) {
                    tagBtn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
                    [tagBtn setTitleColor:Public_Text_Color forState:0];
                }
            }
         
        }

        [_model.platTypes addObject:btn.titleLabel.text];
        [btn setTitleColor:Public_Red_Color forState:0];
        btn.layer.borderColor = Public_Red_Color.CGColor;
         self.platLabel.text = [_model.platTypes componentsJoinedByString:@" "];
    }
    
}
-(void)regionBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([_model.regions containsObject:btn.titleLabel.text]) {//包含
        [_model.regions removeObject:btn.titleLabel.text];
        btn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        [btn setTitleColor:Public_Text_Color forState:0];
    }else{//不包含
        if (_model.regions.count==locationLimit) {
            NSString *removeTitle = [_model.regions objectAtIndex:0];
            [_model.regions removeObject:removeTitle];
            for (UIButton *any in _regionView.subviews) {
                if (![any isKindOfClass:[UIButton class]]) {
                    continue;
                }
                 UIButton *tagBtn = (UIButton *)any;
                if ([tagBtn.titleLabel.text isEqualToString:removeTitle]) {
                    tagBtn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
                    [tagBtn setTitleColor:Public_Text_Color forState:0];
                }
            }
        }
        [_model.regions addObject:btn.titleLabel.text];
        [btn setTitleColor:Public_Red_Color forState:0];
        btn.layer.borderColor = Public_Red_Color.CGColor;
    }
     self.regionLabel.text = [_model.regions componentsJoinedByString:@" "];
}
-(void)sexBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
   
        
        _model.sex = tag-400;
        UIButton *man = [self.sexView viewWithTag:400];
        man.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        [man setTitleColor:Public_Text_Color forState:0];
        UIButton *woman = [self.sexView viewWithTag:401];
        woman.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        [woman setTitleColor:Public_Text_Color forState:0];
        UIButton *any = [self.sexView viewWithTag:402];
        any.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        [any setTitleColor:Public_Text_Color forState:0];
        
      
        [btn setTitleColor:Public_Red_Color forState:0];
        btn.layer.borderColor = Public_Red_Color.CGColor;
    self.sexLabel.text = btn.titleLabel.text;
}
-(void)ageBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    NSArray *agetArr= @[@"0-10",@"10-20",@"20-40",@"40-60",@"60-80",@"80-100"];
    NSString *num = agetArr[tag-500];
    NSArray *numArr = [num componentsSeparatedByString:@"-"];
    _model.age_min = [numArr[0] integerValue];
    _model.age_max = [numArr[1] integerValue];
    [_rangeSlider resetLeftValue:_model.age_min rightValue:_model.age_max];
    [_rangeSlider resetLeftAndRightLabel];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)searchAction:(id)sender {
    _model.age_min = _rangeSlider.lowerValue;
    _model.age_max = _rangeSlider.upperValue;
    self.cellSelectCondition(_model);
}
- (IBAction)tagAction:(id)sender {
    if (_model.tagOpen) {//展开要关闭
        _model.tagOpen = NO;
       // [self.tagBtn setImage:[UIImage imageNamed:@"talent_search_arrow_n"] forState:0];
    }else{//关闭要展开
        _model.tagOpen = YES;
         //      [self.tagBtn setImage:[UIImage imageNamed:@"talent_search_arrow_s"] forState:0];
    }
   self.reloadCell(_model);
}
- (IBAction)platAction:(id)sender {
    if (_model.platOpen) {//展开要关闭
           _model.platOpen = NO;
//[self.platBtn setImage:[UIImage imageNamed:@"talent_search_arrow_n"] forState:0];
       }else{//关闭要展开
           _model.platOpen = YES;
           //       [self.platBtn setImage:[UIImage imageNamed:@"talent_search_arrow_s"] forState:0];
       }
     self.reloadCell(_model);
}
- (IBAction)regionAction:(id)sender {
    if (_model.regionOpen) {//展开要关闭
           _model.regionOpen = NO;
         //  [self.regionBtn setImage:[UIImage imageNamed:@"talent_search_arrow_n"] forState:0];
       }else{//关闭要展开
           _model.regionOpen = YES;
              //    [self.regionBtn setImage:[UIImage imageNamed:@"talent_search_arrow_s"] forState:0];
       }
     self.reloadCell(_model);
}
@end
