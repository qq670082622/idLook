//
//  AskPriceListView.m
//  IDLook
//
//  Created by 吴铭 on 2019/6/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AskPriceListView.h"

@implementation AskPriceListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AskPriceListView" owner:nil options:nil] lastObject];
    }
    [self initUI];
    return self;
}
-(void)initUI
{
   NSInteger status = [UserInfoManager getUserStatus];
    if (status>200) {//vip
        [self addVipIconWithPriceLabel:self.priceLabel needChangeFrame:NO];
    }
}
-(void)setType:(NSInteger)type
{
    _type = type;
    if (type==11) {
        self.priceTitle.text = @"Video宣传片";
    }else if (type==12){
         self.priceTitle.text = @"TVC影视广告";
    }else if (type==21){
         self.priceTitle.text = @"平面";
    }else if (type==41){
         self.priceTitle.text = @"Video宣传片+平面";
    }else if (type==42){
         self.priceTitle.text = @"TVC影视广告+平面";
    }
}

-(void)setPriceList:(NSArray *)priceList
{
    _priceList = priceList;
}
-(void)setStartPrice:(NSInteger)startPrice
{
    _startPrice = startPrice;
     self.priceLabel.text = [NSString stringWithFormat:@"￥%ld/天(不含税)",startPrice];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} range:NSMakeRange(self.priceLabel.text.length-7,7)];
    self.priceLabel.attributedText=attStr;
}
- (IBAction)minus:(id)sender
{
    NSInteger day = [_day.text integerValue];
    if (day>0) {
        day--;
        [self.addBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:0];
        self.addBtn.userInteractionEnabled = YES;
    }
    self.day.text = [NSString stringWithFormat:@"%ld",day];
    if (day==0) {
        [self.minusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
        self.minusBtn.userInteractionEnabled = NO;
        self.priceViewBackImg.image = [UIImage imageNamed:@"btn_unclick_price"];
        _isSelect = NO;
    }
    [self.delegate selectType:_type withDay:[_day.text integerValue] andSinglePrice:_startPrice isDelete:day==0?YES:NO];
}

- (IBAction)addAction:(id)sender
{
    NSInteger day = [_day.text integerValue];
    if (day<5) {
         day++;
        [self.minusBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:0];
        self.minusBtn.userInteractionEnabled = YES;
    }
   self.day.text = [NSString stringWithFormat:@"%ld",day];
    if (day==5) {
        [self.addBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
        self.addBtn.userInteractionEnabled = NO;
    }
    if (day==1) {
        self.priceViewBackImg.image = [UIImage imageNamed:@"btn_click_price"];
        _isSelect = YES;
    }
      [self.delegate selectType:_type withDay:[_day.text integerValue] andSinglePrice:_startPrice isDelete:day==0?YES:NO];
}

- (IBAction)select:(id)sender {
    if (_isSelect) {
        self.priceViewBackImg.image = [UIImage imageNamed:@"btn_unclick_price"];
        _isSelect = NO;
        self.day.text = @"0";
        [self.addBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:0];
        self.addBtn.userInteractionEnabled = YES;
        [self.minusBtn setImage:[UIImage imageNamed:@"dayMinusUnable"] forState:0];
        self.minusBtn.userInteractionEnabled = NO;
    }else{
        self.priceViewBackImg.image = [UIImage imageNamed:@"btn_click_price"];
        _isSelect = YES;
    }
}
-(void)reloadWithDay:(NSInteger)day
{
    self.day.text = [NSString stringWithFormat:@"%ld",day];
    if (day==5) {
        [self.addBtn setImage:[UIImage imageNamed:@"dayAddUnable"] forState:0];
        self.addBtn.userInteractionEnabled = NO;
        [self.minusBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:0];
        self.minusBtn.userInteractionEnabled = YES;
    }else{
        [self.addBtn setImage:[UIImage imageNamed:@"dayAddEnable"] forState:0];
        self.addBtn.userInteractionEnabled = YES;
        [self.minusBtn setImage:[UIImage imageNamed:@"dayMinusAnable"] forState:0];
        self.minusBtn.userInteractionEnabled = YES;
    }
    self.priceViewBackImg.image = [UIImage imageNamed:@"btn_click_price"];
    _isSelect = YES;
}
//给label带上vip图标
-(void)addVipIconWithPriceLabel:(UILabel *)label needChangeFrame:(BOOL)need
{
    if (need) {
        label.x -=25;
    }
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_vipPrice"]];
    [label sizeToFit];
    label.frame = CGRectMake(label.x, 14, label.width-20, 20);
    img.frame = CGRectMake(label.right+3, label.y+5, 25, 10);
    [label.superview addSubview:img];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = CGRectMake(0, _topY, UI_SCREEN_WIDTH, 58);
}
-(void)setTopY:(CGFloat)topY
{
    _topY = topY;
}
@end
