//
//  UnAuthLookCountView.m
//  IDLook
//
//  Created by 吴铭 on 2019/8/30.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "UnAuthLookCountView.h"
@interface UnAuthLookCountView()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *authAction;
- (IBAction)lookPrice:(id)sender;

@end
@implementation UnAuthLookCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"UnAuthLookCountView" owner:nil options:nil] lastObject];
    }
    [self initUI];
    return self;
}
-(void)initUI
{
    
}
- (IBAction)lookPrice:(id)sender {
}
@end
