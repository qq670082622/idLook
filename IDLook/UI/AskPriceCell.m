//
//  AskPriceCell.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/8.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "AskPriceCell.h"
//#import "PriceModel_java.h"
#import "AskCalendarPriceModel.h"
@interface AskPriceCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UIImageView *sex_icon;
@property (weak, nonatomic) IBOutlet UILabel *normalPrice;
@property (weak, nonatomic) IBOutlet UIView *vipPriceView;
@property (weak, nonatomic) IBOutlet UILabel *vipPrice;
@property (weak, nonatomic) IBOutlet UILabel *vipView_normalPrice;
@property (weak, nonatomic) IBOutlet UIView *offLine;

@property (weak, nonatomic) IBOutlet UIView *vipApplyView;
@property (weak, nonatomic) IBOutlet UIButton *vipBtn;
- (IBAction)vipAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

- (IBAction)typeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *typeTip;
@property (weak, nonatomic) IBOutlet UIImageView *typeArrow;


@end
@implementation AskPriceCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"AskPriceCell";
    AskPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AskPriceCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.backView.layer.cornerRadius = 8;
    cell.backView.layer.masksToBounds = YES;
    cell.vipBtn.layer.cornerRadius=3;
    cell.vipBtn.layer.masksToBounds = YES;
    return cell;
}
-(void)setInfo:(UserDetialInfoM *)info
{
    _info = info;
   
    [self.icon sd_setImageWithUrlStr:info.avatar placeholderImage:[UIImage imageNamed:@"default_home"]];
    _icon.layer.cornerRadius =16;
    _icon.layer.masksToBounds = YES;
    if (info.sex==1) {//男
        self.sex_icon.image = [UIImage imageNamed:@"icon_male"];
    }else{
        self.sex_icon.image = [UIImage imageNamed:@"icon_female"];
    }
    self.name.text = info.nickName;
    self.city.text = [NSString stringWithFormat:@"• %@",info.region];
    [self.name sizeToFit];
    [self.city sizeToFit];
    
    self.name.frame = CGRectMake(54, 50, _name.width, 23);
    self.sex_icon.x = _name.right+8;
    self.city.frame = CGRectMake(_sex_icon.right+8, 50, _city.width, 23);
    
//    NSDictionary *priceInfo = info.priceInfo;
//    NSInteger startPrice = [priceInfo[@"startPrice"]integerValue];
//     NSInteger vipStartPrice = [priceInfo[@"startPriceVip"]integerValue];
//    self.normalPrice.text =  [NSString stringWithFormat:@"¥ %ld",startPrice];
//    self.vipView_normalPrice.text =  [NSString stringWithFormat:@"¥ %ld",startPrice];
//     self.vipPrice.text =  [NSString stringWithFormat:@"¥ %ld",vipStartPrice];
}
-(void)setVip_price:(NSInteger)vipPrice andNormalPrice:(NSInteger)normalPrice
{
    self.normalPrice.text =  [NSString stringWithFormat:@"¥ %ld",normalPrice];
    self.vipView_normalPrice.text =  [NSString stringWithFormat:@"¥ %ld",normalPrice];
    self.vipPrice.text =  [NSString stringWithFormat:@"¥ %ld",vipPrice];
}
-(CGFloat)reloadUIWithArray:(NSArray *)priceModelArray
//NormalPrice:(NSInteger)totalPrice photoDic:(NSDictionary *)photoDic videoDic:(NSDictionary *)videoDic groupDic:(NSDictionary *)groupDic
{
    NSInteger status = [UserInfoManager getUserStatus];
    NSMutableString *muStr = [NSMutableString new];
    NSMutableArray *muArr = [NSMutableArray new];
    NSMutableString *muStr_vip = [NSMutableString new];
 //   NSMutableArray *muArr_vip = [NSMutableArray new];
  //  NSInteger total_vip = 0;
 //   NSInteger total = 0;
    
//    id model = [priceModelArray firstObject];
//    if ([model isKindOfClass:[AskCalendarPriceModel class]]) {
//        NSMutableArray *newModels = [NSMutableArray new];
//          for (int i = 0;i<priceModelArray.count;i++){
//              AskCalendarPriceModel *akModel = priceModelArray[i];
//              PriceModel_java *pm = [PriceModel_java new];
//              pm.advertType = akModel.type;
//              pm.days = akModel.day;
//              pm.singlePrice = akModel.price;
//              [newModels addObject:pm];
//          }
//        priceModelArray = [newModels copy];
//    }
   
    for (int i = 0;i<priceModelArray.count;i++){
        AskCalendarPriceModel *pm = priceModelArray[i];
    //    total_vip+=pm.salePrice_vip;
     //   total+=pm.salePrice;
//        if (pm.advertType==1) {//视频
//             [muArr addObject:[NSString stringWithFormat:@"视频： ¥%d/%d天",pm.singlePrice,pm.days]];
//             [muArr_vip addObject:[NSString stringWithFormat:@"视频： ¥%d/%d天",pm.singlePrice_vip,pm.days]];
//        }else if (pm.advertType==2) {//平面
//            [muArr addObject:[NSString stringWithFormat:@"平面： ¥%d/%d天",pm.singlePrice,pm.days]];
//            [muArr_vip addObject:[NSString stringWithFormat:@"平面： ¥%d/%d天",pm.singlePrice_vip,pm.days]];
//        }else if (pm.advertType==4) {//套拍
//            [muArr addObject:[NSString stringWithFormat:@"套拍： ¥%d/%d天",pm.singlePrice,pm.days]];
//            [muArr_vip addObject:[NSString stringWithFormat:@"套拍： ¥%d/%d天",pm.singlePrice_vip,pm.days]];
//        }
        if (pm.type==11) {
            [muArr addObject:[NSString stringWithFormat:@"Video宣传片: %ld天",pm.day]];
        }else if (pm.type==12){
            [muArr addObject:[NSString stringWithFormat:@"TVC影视广告: %ld天",pm.day]];
        }else if (pm.type==21){
            [muArr addObject:[NSString stringWithFormat:@"平面: %ld天",pm.day]];
        }else if (pm.type==41){
            [muArr addObject:[NSString stringWithFormat:@"Video宣传片+平面: %ld天",pm.day]];
        }else if (pm.type==42){
            [muArr addObject:[NSString stringWithFormat:@"TVC影视广告+平面: %ld天",pm.day]];
        }
    }
    for(int i=0;i<muArr.count;i++){
        NSString *str = [NSString stringWithFormat:@"%@\n",muArr[i]];
        if (i!=muArr.count-1) {
            [muStr appendString:str];
        }else{
            [muStr appendString:muArr[i]];
        }
    }
//    for(int i=0;i<muArr_vip.count;i++){
//        NSString *str = [NSString stringWithFormat:@"%@\n",muArr_vip[i]];
//        if (i!=muArr_vip.count-1) {
//            [muStr_vip appendString:str];
//        }else{
//            [muStr_vip appendString:muArr_vip[i]];
//        }
//    }
    if (status>200) {
      self.vipPriceView.hidden = NO;
       // self.vipPrice.text = [NSString stringWithFormat:@"¥ %ld",total_vip];;
       // self.vipView_normalPrice.text = [NSString stringWithFormat:@"¥ %ld",total];
      [self.vipPrice sizeToFit];
        [self.vipView_normalPrice sizeToFit];
    
        self.vipPrice.frame = CGRectMake(33, 0, _vipPrice.width, 29);
        self.vipView_normalPrice.frame =  CGRectMake(_vipPrice.right+6,0,_vipView_normalPrice.width,29);
        self.offLine.x = _vipView_normalPrice.x-3;
        self.offLine.width = _vipView_normalPrice.width+6;
        self.vipApplyView.hidden = YES;
      //  self.vipArrow.hidden = YES;
        self.line.y=88;
        self.typeTip.y = _line.bottom+14;
        self.typeBtn.y = _line.bottom+14;
        self.typeArrow.y = _line.bottom+12;
        self.typeLabel.text = muStr;//muStr_vip;
      
     //   self.totalPrice = total_vip;
    }else{
        //   self.normalPrice.text = [NSString stringWithFormat:@"¥ %ld",total];
        self.typeLabel.text = muStr;
        self.vipPriceView.hidden = YES;
      
      //  [self.vipBtn setTitle:[NSString stringWithFormat:@"     申请VIP账户，立享95折，本单可再省￥%d",total-total_vip] forState:0];
   //     self.totalPrice = total;
    }
  
    if (priceModelArray.count>1) {
    self.typeBtn.height = 21*priceModelArray.count;
      }
   
    
    self.typeLabel.frame = _typeBtn.frame;
    self.contentView.height = _typeBtn.bottom+27;
    return _typeBtn.bottom+27;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)vipAction:(id)sender {
    self.vipAction();
}
- (IBAction)typeAction:(id)sender {
    self.typeAction();
}
@end
