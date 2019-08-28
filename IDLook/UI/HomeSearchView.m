//
//  HomeSearchView.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "HomeSearchView.h"
@interface HomeSearchView()
@property (weak, nonatomic) IBOutlet UILabel *keyWord;
@property (weak, nonatomic) IBOutlet UIButton *keyWord_closeBtn;
- (IBAction)keyWord_close:(id)sender;
- (IBAction)keyWordSelect:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *hei_wei;
@property (weak, nonatomic) IBOutlet UIButton *hei_wei_closeBtn;
- (IBAction)hei_wei_close:(id)sender;
- (IBAction)hei_wei_select:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *sex_age;
@property (weak, nonatomic) IBOutlet UIButton *sex_age_closeBtn;
- (IBAction)sex_age_close:(id)sender;
- (IBAction)sex_age_select:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *low_price;
- (IBAction)low_price_select:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *high_price;
- (IBAction)high_price_select:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *shotType;
- (IBAction)shotType_select:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *type_closeBtn;
- (IBAction)type_close:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *region;
- (IBAction)region_select:(id)sender;

- (IBAction)serach:(id)sender;

@end
@implementation HomeSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HomeSearchView" owner:nil options:nil] lastObject];
    }
 
 
   
    return self;
}
//-(void)setModel:(ConditionModel *)model
//{
//    _model = model;
//    if (model.keyWord.length>0) {
//        self.keyWord.text = model.keyWord;
//        self.keyWord.textColor = [UIColor colorWithHexString:@"464646"];
//        self.keyWord_closeBtn.hidden = NO;
//        
//    }else if (model.keyWord.length==0){
//        self.keyWord.text = @"演员姓名/关键字";
//        self.keyWord.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//          self.keyWord_closeBtn.hidden = YES;
//    }
//    
//    self.hei_wei_closeBtn.hidden = NO;
//    if (model.hei_min>0) {
//        self.hei_wei.text = [NSString stringWithFormat:@"%ld-%ldcm",model.hei_min,model.hei_max];
//        if (model.hei_min>0&&model.wei_min>0) {
//                [NSString stringWithFormat:@"%ld-%ldcm/%ld-%ldkg",model.hei_min,model.hei_max,model.wei_min,model.wei_max];
//        }
//    
//          self.hei_wei.textColor = [UIColor colorWithHexString:@"464646"];
//    }else if (model.hei_min==0&&model.wei_min>0){
//         self.hei_wei.text = [NSString stringWithFormat:@"%ld-%ldkg",model.wei_min,model.wei_max];
//          self.hei_wei.textColor = [UIColor colorWithHexString:@"464646"];
//    }else if (model.hei_min==0&&model.wei_min==0){
//        self.hei_wei.text = @"身高/体重";
//        self.hei_wei.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//         self.hei_wei_closeBtn.hidden = YES;
//    }
//    
//    self.sex_age_closeBtn.hidden = NO;
//    if(model.sex>0){
//        self.sex_age.text = model.sex==1?@"男":@"女";
//        self.sex_age.textColor = [UIColor colorWithHexString:@"464646"];
//        if (model.age_min>0) {
//            self.sex_age.text = [NSString stringWithFormat:@"%@/%ld-%ld岁",model.sex==1?@"男":@"女",model.age_min,model.age_max];
//               self.sex_age.textColor = [UIColor colorWithHexString:@"464646"];
//        }
//    }else if (model.sex==0&&model.age_min>0){
//        self.sex_age.text = [NSString stringWithFormat:@"%ld-%ld岁",model.age_min,model.age_max];
//        self.sex_age.textColor = [UIColor colorWithHexString:@"464646"];
//    }else if (model.sex==0&&model.age_min==0){
//        self.sex_age.text = @"性别/年龄";
//        self.sex_age.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//         self.sex_age_closeBtn.hidden = YES;
//    }
//    
//    
//    if (model.price_min>0) {
//         self.low_price.textColor = [UIColor colorWithHexString:@"464646"];//3000-5000
//        NSString *minStr = [NSString stringWithFormat:@"%ld 最低价格",model.price_min];
//        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:minStr];
//        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19.0 weight:UIFontWeightMedium]} range:NSMakeRange(0,minStr.length-5)];
//        self.low_price.attributedText=attStr;
//    }else if (model.price_min==0){
//        self.low_price.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//        self.low_price.text = @"最低价格";
//    }
//    
//    if (model.price_max>0) {
//        self.high_price.textColor = [UIColor colorWithHexString:@"464646"];
//        NSString *highStr = [NSString stringWithFormat:@"%ld 最高价格",model.price_min];
//        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:highStr];
//        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19.0 weight:UIFontWeightMedium]} range:NSMakeRange(0,highStr.length-5)];
//        self.high_price.attributedText=attStr;
//    }else if (model.price_max==0){
//        self.high_price.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//        self.high_price.text = @"最高价格";
//    }
//    
//    self.type_closeBtn.hidden = NO;
//    if (model.shotType.length>0) {
//        self.shotType.text = model.shotType;
//        self.shotType.textColor = [UIColor colorWithHexString:@"464646"];
//    }else if(model.shotType.length==0 || !model.shotType.length){
//        self.shotType.text = @"拍摄类别";
//        self.shotType.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//          self.type_closeBtn.hidden = YES;
//    }
//    
//   if (model.region.length>0) {
//        self.region.text = model.region;
//        self.region.textColor = [UIColor colorWithHexString:@"464646"];
//    }else if(model.region.length==0 || !model.shotType.length){
//        self.region.text = @"演员所在地";
//        self.region.textColor = [UIColor colorWithHexString:@"bcbcbc"];
//        }
//    
//}
-(void)loadUIWithModel:(ConditionModel *)model
{
    if (model.keyWord.length>0) {
        self.keyWord.text = model.keyWord;
        self.keyWord.textColor = [UIColor colorWithHexString:@"464646"];
        self.keyWord_closeBtn.hidden = NO;
        
    }else if (model.keyWord.length==0){
        self.keyWord.text = @"演员姓名/关键字";
        self.keyWord.textColor = [UIColor colorWithHexString:@"bcbcbc"];
        self.keyWord_closeBtn.hidden = YES;
    }
    
    self.hei_wei_closeBtn.hidden = NO;
    if (model.hei_min>0) {
        self.hei_wei.text = [NSString stringWithFormat:@"%ld-%ldcm",model.hei_min,model.hei_max];
        if (model.hei_min>0&&model.wei_min>0) {
            [NSString stringWithFormat:@"%ld-%ldcm/%ld-%ldkg",model.hei_min,model.hei_max,model.wei_min,model.wei_max];
        }
        
        self.hei_wei.textColor = [UIColor colorWithHexString:@"464646"];
    }else if (model.hei_min==0&&model.wei_min>0){
        self.hei_wei.text = [NSString stringWithFormat:@"%ld-%ldkg",model.wei_min,model.wei_max];
        self.hei_wei.textColor = [UIColor colorWithHexString:@"464646"];
    }else if (model.hei_min==0&&model.wei_min==0){
        self.hei_wei.text = @"身高/体重";
        self.hei_wei.textColor = [UIColor colorWithHexString:@"bcbcbc"];
        self.hei_wei_closeBtn.hidden = YES;
    }
    
    self.sex_age_closeBtn.hidden = NO;
    if(model.sex>0){
        self.sex_age.text = model.sex==1?@"男":@"女";
        self.sex_age.textColor = [UIColor colorWithHexString:@"464646"];
        if (model.age_min>0) {
            self.sex_age.text = [NSString stringWithFormat:@"%@/%ld-%ld岁",model.sex==1?@"男":@"女",model.age_min,model.age_max];
            self.sex_age.textColor = [UIColor colorWithHexString:@"464646"];
        }
    }else if (model.sex==0&&model.age_min>0){
        self.sex_age.text = [NSString stringWithFormat:@"%ld-%ld岁",model.age_min,model.age_max];
        self.sex_age.textColor = [UIColor colorWithHexString:@"464646"];
    }else if (model.sex==0&&model.age_min==0){
        self.sex_age.text = @"性别/年龄";
        self.sex_age.textColor = [UIColor colorWithHexString:@"bcbcbc"];
        self.sex_age_closeBtn.hidden = YES;
    }
    
    
    if (model.price_min>0) {
        self.low_price.textColor = [UIColor colorWithHexString:@"464646"];//3000-5000
        NSString *minStr = [NSString stringWithFormat:@"%ld 最低价格",model.price_min];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:minStr];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19.0 weight:UIFontWeightMedium]} range:NSMakeRange(0,minStr.length-5)];
        self.low_price.attributedText=attStr;
    }else if (model.price_min==0){
        self.low_price.textColor = [UIColor colorWithHexString:@"bcbcbc"];
        self.low_price.text = @"最低价格";
    }
    
    if (model.price_max>0) {
        self.high_price.textColor = [UIColor colorWithHexString:@"464646"];
        NSString *highStr = [NSString stringWithFormat:@"%ld 最高价格",model.price_min];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:highStr];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19.0 weight:UIFontWeightMedium]} range:NSMakeRange(0,highStr.length-5)];
        self.high_price.attributedText=attStr;
    }else if (model.price_max==0){
        self.high_price.textColor = [UIColor colorWithHexString:@"bcbcbc"];
        self.high_price.text = @"最高价格";
    }
    
    self.type_closeBtn.hidden = NO;
    if (model.shotType.length>0) {
        self.shotType.text = model.shotType;
        self.shotType.textColor = [UIColor colorWithHexString:@"464646"];
    }else if(model.shotType.length==0 || !model.shotType.length){
        self.shotType.text = @"拍摄类别";
        self.shotType.textColor = [UIColor colorWithHexString:@"bcbcbc"];
        self.type_closeBtn.hidden = YES;
    }
    
    if (model.region.length>0) {
        self.region.text = model.region;
        self.region.textColor = [UIColor colorWithHexString:@"464646"];
    }else if(model.region.length==0 || !model.shotType.length){
        self.region.text = @"演员所在地";
        self.region.textColor = [UIColor colorWithHexString:@"bcbcbc"];
    }
}
- (IBAction)region_select:(id)sender {
    self.conditionSelectType(conditionTypeRegion_select);
}
- (IBAction)keyWordSelect:(id)sender {
     self.conditionSelectType(conditionTypeKeyWord_select);
}
- (IBAction)hei_wei_select:(id)sender {
     self.conditionSelectType(conditionTypeHeiWei_select);
}
- (IBAction)sex_age_select:(id)sender {
     self.conditionSelectType(conditionTypeSexAge_select);
}
- (IBAction)low_price_select:(id)sender {
     self.conditionSelectType(conditionTypePriceMin_select);
}
- (IBAction)high_price_select:(id)sender {
     self.conditionSelectType(conditionTypePirceMax_select);
}
- (IBAction)shotType_select:(id)sender {
        self.conditionSelectType(conditionTypeShotType_select);
}

- (IBAction)type_close:(id)sender {
      self.conditionSelectType(conditionTypeShotType_clear);
}
- (IBAction)sex_age_close:(id)sender {
    self.conditionSelectType(conditionTypeSexAge_clear);
}
- (IBAction)hei_wei_close:(id)sender {
    self.conditionSelectType(conditionTypeHeiWei_clear);
}
- (IBAction)keyWord_close:(id)sender {
      self.conditionSelectType(conditionTypeKeyWord_clear);
}
- (IBAction)serach:(id)sender {
      self.conditionSelectType(conditionTypeSearch);
}
@end
