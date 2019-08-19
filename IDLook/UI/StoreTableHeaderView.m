//
//  StoreTableHeaderView.m
//  IDLook
//
//  Created by 吴铭 on 2019/3/19.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "StoreTableHeaderView.h"
@interface StoreTableHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *sore;
- (IBAction)soreDetailAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sorceBtn;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UIButton *shadowBtn;

@end
@implementation StoreTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"StoreTableHeaderView" owner:nil options:nil] lastObject];
        [self initSubViews];
    }
    return self;
}
-(void)initSubViews
{
    self.shadowBtn.layer.shadowOffset = CGSizeMake(0, -8);
    self.shadowBtn.layer.shadowOpacity = 1.0;
    self.shadowBtn.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
 self.sorceBtn.layer.cornerRadius = 13.5;
    self.sorceBtn.layer.masksToBounds = YES;
    
    self.line.layer.cornerRadius = 6;
    self.line.layer.masksToBounds = YES;
}
- (void)setIntegral:(NSInteger)integral
{
    _integral = integral;
    self.sore.text = [NSString stringWithFormat:@"%ld",(long)integral];
    
}
- (IBAction)soreDetailAction:(id)sender {
    self.soreDetail();
}
@end
