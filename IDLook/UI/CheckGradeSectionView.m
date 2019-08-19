//
//  CheckGradeSectionView.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "CheckGradeSectionView.h"
@interface CheckGradeSectionView()
@property (weak, nonatomic) IBOutlet UIImageView *typeIcon;
@property (weak, nonatomic) IBOutlet UILabel *projectName;

@end
@implementation CheckGradeSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CheckGradeSectionView" owner:nil options:nil] lastObject];
    }
    return self;
}
-(void)setType:(NSInteger)type
{
    if (type==1) {
        self.typeIcon.image = [UIImage imageNamed:@"icon_screen"];
    }else if (type==2){
        self.typeIcon.image = [UIImage imageNamed:@"icon_audition"];
    }
    
}
-(void)setPjName:(NSString *)pjName
{
    self.projectName.text = pjName;
}
@end
