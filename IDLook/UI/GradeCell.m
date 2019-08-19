//
//  GradeCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/21.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "GradeCell.h"
#import "LHRatingView.h"

@interface GradeCell()<ratingViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *actorIcon;
@property (weak, nonatomic) IBOutlet UILabel *actorName;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *region;


@property (weak, nonatomic) IBOutlet UIButton *anonymityBtn;
- (IBAction)anonymityAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *badBtn;
- (IBAction)badAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *normalBtn;
- (IBAction)normalAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
- (IBAction)goodAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *selectView;// height=267
@property (weak, nonatomic) IBOutlet UILabel *badLabel;
@property (weak, nonatomic) IBOutlet UILabel *normalLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;

@property (weak, nonatomic) IBOutlet UIView *tipBtnSuperView;
@property (weak, nonatomic) IBOutlet UIView *tipBtnSuperView2;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricePowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *actLabel;
@property (weak, nonatomic) IBOutlet UILabel *actPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelLabel;
@property (weak, nonatomic) IBOutlet UILabel *fellingLabel;
@property(nonatomic,strong)NSArray *badArr;
@property(nonatomic,strong)NSArray *normalArr;
@property(nonatomic,strong)NSArray *goodArr;

@property (weak, nonatomic) IBOutlet UIView *textGradeView;





@end
@implementation GradeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"GradeCell";
    GradeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GradeCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.actorIcon.layer.cornerRadius = 16;
        cell.actorIcon.layer.masksToBounds = YES;
    }
    
    
   return cell;
}
-(void)setModel:(GradeModel *)model
{
    _model = model;
    //default_photo
    [self.actorIcon sd_setImageWithUrlStr:model.actorUrl placeholderImage:[UIImage imageNamed:@"default_photo"]];
    self.actorName.text = model.actorName;
    self.textView.text = model.gradeText;
    if (model.sex==1) {//男
        self.sexImg.image = [UIImage imageNamed:@"icon_male"];
    }else{
        self.sexImg.image = [UIImage imageNamed:@"icon_female"];
    }
    self.region.text = [NSString stringWithFormat:@"• %@",model.city];
    self.actorName.width = 18*model.actorName.length;
    self.sexImg.x = self.actorName.x + self.actorName.width +7;
    self.region.x = self.sexImg.x+23;
    
    if (model.gradeText.length>0) {
        self.textTip.hidden = YES;
    }else{
         self.textTip.hidden = NO;
    }
    self.badArr = [model.gradeAllStrings valueForKey:@"bad"];
    self.normalArr = [model.gradeAllStrings valueForKey:@"normal"];
    self.goodArr = [model.gradeAllStrings valueForKey:@"good"];
    if (model.anonymity) {
        [self.anonymityBtn setSelected:YES];
    }else{
        [self.anonymityBtn setSelected:NO];
    }
    //标签 y=42
    //根据选择的好坏来判断有多少个标签,以及初始化标签并frames
    if (model.gradeLevel>0) {//说明用户选择了 差 一般 好
        NSArray *tipsStrings;
        if (model.gradeLevel==1) {//好
            tipsStrings = [NSArray arrayWithArray:[model.gradeAllStrings objectAtIndex:0]];
        }else  if (model.gradeLevel==2) {//一般
            tipsStrings = [NSArray arrayWithArray:[model.gradeAllStrings objectAtIndex:1]];
        }else if (model.gradeLevel==3) {//坏
            tipsStrings = [NSArray arrayWithArray:[model.gradeAllStrings objectAtIndex:2]];
        }
    // tipsStrings  = [model.gradeAllStrings objectAtIndex:model.gradeLevel-1];
        CGFloat buttonX = 0;//按钮x
        CGFloat buttonAllWids = 0;
        CGRect lastFrame;
        
        CGFloat buttonX2 = 0;//按钮x
        CGFloat buttonAllWids2 = 0;
        CGRect lastFrame2;
        for(int i =0;i<tipsStrings.count;i++){
            if (i<3) {//第一列
                UIButton *tipsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [tipsBtn setTag:10+i];
                NSDictionary *titleDic = tipsStrings[i];
                NSString *btnTitle = titleDic[@"attrname"];
                if (![model.gradeStrings containsObject:btnTitle]) {//说明选中
                    [self setTipButtonWithUnselectStatue:tipsBtn];
                }else{
                    [self setTipButtonWithSelectStatue:tipsBtn];
                }
                [tipsBtn setTitle:btnTitle forState:0];
                tipsBtn.titleLabel.font = [UIFont systemFontOfSize:11];
                //   [self setTipButtonWithUnselectStatue:tipsBtn];
                [tipsBtn addTarget:self action:@selector(tipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                //设置frame
                tipsBtn.width = btnTitle.length*10+20;
                tipsBtn.y = 0;
                tipsBtn.x = buttonX;
                tipsBtn.height = 26;
                buttonX+=(tipsBtn.width+10);//1 :0  2:110 3:220
                [self.tipBtnSuperView addSubview:tipsBtn];
                buttonAllWids = tipsBtn.x+tipsBtn.width;
                lastFrame = tipsBtn.frame;
            }else{//第二列
                UIButton *tipsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [tipsBtn setTag:10+i];
                NSDictionary *titleDic = tipsStrings[i];
                NSString *btnTitle = titleDic[@"attrname"];
                if (![model.gradeStrings containsObject:btnTitle]) {//说明选中
                    [self setTipButtonWithUnselectStatue:tipsBtn];
                }else{
                    [self setTipButtonWithSelectStatue:tipsBtn];
                }
                [tipsBtn setTitle:btnTitle forState:0];
                tipsBtn.titleLabel.font = [UIFont systemFontOfSize:11];
                //   [self setTipButtonWithUnselectStatue:tipsBtn];
                [tipsBtn addTarget:self action:@selector(tipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                //设置frame
                tipsBtn.width = btnTitle.length*10+20;
                tipsBtn.y = 0;
                tipsBtn.x = buttonX2;
                tipsBtn.height = 26;
                buttonX2+=(tipsBtn.width+10);//1 :0  2:110 3:220
                [self.tipBtnSuperView2 addSubview:tipsBtn];
                buttonAllWids2 = tipsBtn.x+tipsBtn.width;
                lastFrame2 = tipsBtn.frame;
            }
          
        }
//确定中心
        self.tipBtnSuperView.frame = CGRectMake((UI_SCREEN_WIDTH-buttonAllWids)/2, 42, buttonAllWids, 26);
        //右部顶住m屏幕
        self.tipBtnSuperView.width+=500;
        self.tipBtnSuperView2.frame = CGRectMake((UI_SCREEN_WIDTH-buttonAllWids)/2, 73, buttonAllWids, 26);
        //右部顶住m屏幕
        self.tipBtnSuperView2.width+=500;

          self.textCount.text = [NSString stringWithFormat:@"%ld/500",_textView.text.length];
}
 
    
    if (model.gradeLevel==0) {//不展开
        self.selectView.hidden = YES;//height = 267
       // self.height = 120;
        self.textGradeView.y = 135;
    }else if (model.gradeLevel==1){//好，换按钮状态(各种颜色)， 换标签
        [self setBtnNO];
        [self.goodBtn setSelected:YES];
        self.goodLabel.hidden = NO;
        self.textGradeView.y = _selectView.bottom;
    }else if (model.gradeLevel==2){//一般，换标签
         [self setBtnNO];
         [self.normalBtn setSelected:YES];
        self.normalLabel.hidden = NO;
         self.textGradeView.y = _selectView.bottom;
    }else if (model.gradeLevel==3){//坏， 换标签
         [self setBtnNO];
         [self.badBtn setSelected:YES];
        self.badLabel.hidden = NO;
         self.textGradeView.y = _selectView.bottom;
    }

    //根据屏幕适配左右label的x
    //算上和左右的间距，星星选择总占209 titlewid=46 titlevalue=43
    //间距1+titlewid+星星+titlevalue+间距2 = screenwid         间距1+46 + 星星一半(105) = screenwid/2
    CGFloat titleX = (UI_SCREEN_WIDTH/2) - 105 -46;
   CGFloat valueX = titleX + 293;
    self.priceLabel.x = titleX;
    self.actLabel.x = titleX;
    self.matchLabel.x = titleX;
    self.feelLabel.x = titleX;
    self.pricePowerLabel.x = valueX;
    self.actPowerLabel.x = valueX;
    self.matchPowerLabel.x = valueX;
    self.fellingLabel.x = valueX;
    //星星
    LHRatingView * pricePowerRating = [[LHRatingView alloc]initWithFrame:CGRectMake(titleX+46+18, _pricePowerLabel.y, 173, 21)];
   pricePowerRating.ratingType = INTEGER_TYPE;//整颗星
    pricePowerRating.type = price_starType;
    [pricePowerRating setScore:model.pricePower];
    pricePowerRating.delegate = self;
    [self.selectView addSubview:pricePowerRating];
    
    LHRatingView * actPowerRating = [[LHRatingView alloc]initWithFrame:CGRectMake(titleX+46+18, _actPowerLabel.y, 173, 21)];
    actPowerRating.ratingType = INTEGER_TYPE;//整颗星
    actPowerRating.type = act_starType;
    [actPowerRating setScore:model.actPower];
    actPowerRating.delegate = self;
    [self.selectView addSubview:actPowerRating];
    LHRatingView * matchPowerRating = [[LHRatingView alloc]initWithFrame:CGRectMake(titleX+46+18, _matchPowerLabel.y, 173, 21)];
    matchPowerRating.ratingType = INTEGER_TYPE;//整颗星
    matchPowerRating.type = match_starType;
    [matchPowerRating setScore:model.matchPower];
    matchPowerRating.delegate = self;
    [self.selectView addSubview:matchPowerRating];
    LHRatingView * fellingRating = [[LHRatingView alloc]initWithFrame:CGRectMake(titleX+46+18, _fellingLabel.y, 173, 21)];
    fellingRating.ratingType = INTEGER_TYPE;//整颗星
    fellingRating.type = feeling_starType;
    [fellingRating setScore:model.feeling];
   fellingRating.delegate = self;
    [self.selectView addSubview:fellingRating];
    //每项对应的 差一般好b描述
    self.pricePowerLabel.text = [self stringWithSorce:_model.pricePower];
    self.actPowerLabel.text = [self stringWithSorce:_model.actPower];
    self.matchPowerLabel.text = [self stringWithSorce:_model.matchPower];
    self.fellingLabel.text = [self stringWithSorce:_model.feeling];
}
- (IBAction)anonymityAction:(id)sender {
    if (_anonymityBtn.selected) {
        [_anonymityBtn setSelected:NO];
        _model.anonymity = NO;
        [self.delegate cellAnonymity:NO withIndexPath:_model.indexPath];
    }else{
         [_anonymityBtn setSelected:YES];
         _model.anonymity = YES;
        [self.delegate cellAnonymity:YES withIndexPath:_model.indexPath];
    }
}
- (IBAction)badAction:(id)sender {
   //更新标签UI
    [self.delegate cellGrade:3 withIndexPath:_model.indexPath];
}
- (IBAction)normalAction:(id)sender {
  [self.delegate cellGrade:2 withIndexPath:_model.indexPath];
}
- (IBAction)goodAction:(id)sender {
    [self.delegate cellGrade:1 withIndexPath:_model.indexPath];
}
-(void)tipBtnClick:(id)sender
{
    UIButton *tipBtn = sender;
    NSString *title = tipBtn.titleLabel.text;
    if ([_model.gradeStrings containsObject:title]) {//有了，取消选中
          [self.delegate cellClickTip:tipBtn.titleLabel.text withSelect:NO withIndexPath:_model.indexPath];
    }else{
         [self.delegate cellClickTip:tipBtn.titleLabel.text withSelect:YES withIndexPath:_model.indexPath];
    }
}


- (void)ratingView:(LHRatingView *)view score:(CGFloat)score andType:(starType)type
{
    if(type==price_starType){
       [self.delegate cellSroce:score withType:price_starType withIndexPath:_model.indexPath];
    }else if (type==act_starType){
        [self.delegate cellSroce:score withType:act_starType withIndexPath:_model.indexPath];
    }else if (type==match_starType){
        [self.delegate cellSroce:score withType:match_starType withIndexPath:_model.indexPath];
    }else if (type==feeling_starType){
       [self.delegate cellSroce:score withType:feeling_starType withIndexPath:_model.indexPath];
    }
    
}
-(void)setBtnNO
{
    [self.badBtn setSelected:NO];
    [self.normalBtn setSelected:NO];
    [self.goodBtn setSelected:NO];
    self.goodLabel.hidden = YES;
    self.normalLabel.hidden = YES;
    self.badLabel.hidden = YES;
}
-(void)setTipButtonWithUnselectStatue:(UIButton *)tipBtn
{
    tipBtn.layer.cornerRadius=3.0;
    tipBtn.layer.masksToBounds=YES;
    tipBtn.layer.borderWidth=0.5;
    tipBtn.layer.borderColor = [UIColor colorWithHexString:@"d8d8d8"].CGColor;
    [tipBtn setTitleColor:[UIColor colorWithHexString:@"d8d8d8"] forState:0];
    tipBtn.backgroundColor = [UIColor whiteColor];
}
-(void)setTipButtonWithSelectStatue:(UIButton *)tipBtn
{
    tipBtn.layer.cornerRadius=3.0;
    tipBtn.layer.masksToBounds=YES;
    tipBtn.layer.borderWidth=0.5;
    tipBtn.layer.borderColor = [UIColor colorWithHexString:@"ff4a57"].CGColor;
    [tipBtn setTitleColor:[UIColor colorWithHexString:@"ff4a57"] forState:0];
    tipBtn.backgroundColor = [UIColor colorWithHexString:@"fbedee"];
}
-(NSString *)stringWithSorce:(CGFloat)score
{
      NSInteger score_int = ceilf(score);
    if (score_int==1||score_int==2) {
        return @"有待提高";
    }else if (score_int==3){
        return @"一般";
    }else if(score_int==4||score_int==5){
        return @"好";
    }else{
        return @"";
    }
}
//-(void)textViewDidChange:(UITextView *)textView
//{
//    if([textView.text length]>0)
//    {
//        self.textTip.hidden=YES;
//    }
//    else
//    {
//        self.textTip.hidden=NO;
//    }
//    self.textCount.text = [NSString stringWithFormat:@"%ld/500",textView.text.length];
//}
//
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (textView.text.length>499) {
//        if (text.length==0) {//在删除
//            return YES;
//        }else if (text.length>0) //还想加字，不允许
//        {
//            return NO;
//        }
//    }
//    if ([text isEqualToString:@"\n"]) {
//
//        [textView resignFirstResponder];
//
//        return NO;
//    }
//
//    return YES;
//
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
