//
//  AnnunHeader.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunHeader.h"
@interface AnnunHeader()
@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *city;
@property (weak, nonatomic) IBOutlet UIButton *desc;
@property (weak, nonatomic) IBOutlet UILabel *roleNum;
@property (weak, nonatomic) IBOutlet UIView *bttomView;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@end
@implementation AnnunHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AnnunHeader" owner:nil options:nil] lastObject];
    }
    [self initUI];
    return self;
}
-(void)initUI
{
    self.bttomView.layer.cornerRadius = 15;
    self.bttomView.layer.masksToBounds = YES;
    CGFloat statusBarheight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (statusBarheight==44) {
        self.backImg.height+=28;
        self.backImg.y-=28;
    }
    
//    CGFloat statusBarheight = [UIApplication sharedApplication].statusBarFrame.size.height;
//    if (statusBarheight==44) {
//        self.img.height+=28;
//        self.img.y-=28;
//    }
    
}
-(void)setModel:(AnnunciateModel *)model
{
    _model = model;
    _title.text = model.title;
    [self.time setTitle:[NSString stringWithFormat:@"   %@至%@",model.shotStartDate,model.shotEndDate] forState:0];
    [self.city setTitle:[NSString stringWithFormat:@"   %@",model.shotCity] forState:0];
    [self.desc setTitle:[NSString stringWithFormat:@"   肖像周期：%ld年        肖像范围：%@",model.shotCycle,model.shotRegion] forState:0];
    self.roleNum.text = [NSString stringWithFormat:@"%ld",model.roleList.count];
  
    [self.lookBtn setTitle:[NSString stringWithFormat:@"  %ld次",model.browseCount] forState:0];
    [self.applyBtn setTitle:[NSString stringWithFormat:@"  %ld人",model.applyCount] forState:0];
    [self.lookBtn sizeToFit];
    [self.applyBtn sizeToFit];
    
    self.applyBtn.frame = CGRectMake(self.width-15-_applyBtn.width, 133, _applyBtn.width, 17);
    self.lookBtn.frame = CGRectMake(_applyBtn.x-_lookBtn.width-5, 133, _lookBtn.width, 17);
}

@end
