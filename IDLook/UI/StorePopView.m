//
//  StorePopView.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "StorePopView.h"
@interface StorePopView()
@property (weak, nonatomic) IBOutlet UILabel *tip;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *contact;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
- (IBAction)apply:(id)sender;

@end
@implementation StorePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"StorePopView" owner:nil options:nil] lastObject];
      //  [self initSubViews];
    }
    return self;
}
-(void)initSubViewsWithProductName:(NSString *)productName num:(NSInteger)num andTotalSorce:(NSInteger)totalSorce
{
    self.applyBtn.layer.cornerRadius = 22;
    self.applyBtn.layer.masksToBounds = YES;
    self.name.text = [NSString stringWithFormat:@"姓名：%@",[UserInfoManager getUserRealName]];
    self.contact.text = [NSString stringWithFormat:@"联系方式：%@",[UserInfoManager getUserMobile]];
    
    NSString *redStr = [NSString stringWithFormat:@"%d张%@",num,productName];
    NSString *redStr2 = [NSString stringWithFormat:@"%d积分",totalSorce];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"将兑换%@，该商品一共花费您%@，请核对商品信息，脸探肖像平台会在2个工作日联系您。",redStr,redStr2]];
    
    [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color} range:NSMakeRange(3,redStr.length)];
     [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color} range:NSMakeRange(12+redStr.length,redStr2.length)];
   
    self.tip.attributedText=attStr;
    [self.tip sizeToFit];
}
- (IBAction)apply:(id)sender {
    self.apply();
}
@end
