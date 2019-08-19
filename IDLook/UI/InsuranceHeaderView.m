//
//  InsuranceHeaderView.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/11.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsuranceHeaderView.h"
@interface InsuranceHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *label1;

@end
@implementation InsuranceHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"InsuranceHeaderView" owner:nil options:nil] lastObject];
    }
    [self initUI];
    return self;
}
-(void)initUI
{
    self.label1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.label1.layer.cornerRadius = 3;
    self.label1.layer.masksToBounds = YES;
    self.label1.layer.borderWidth = 1;
    CGFloat statusBarheight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (statusBarheight==44) {
        self.img.height+=28;
        self.img.y-=28;
    }

}
@end
