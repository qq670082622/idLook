//
//  TypeSelectVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/12.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "TypeSelectVC.h"

@interface TypeSelectVC ()//户自定义类型 0=未选择 1=电商 2=制片 3=演员
@property (weak, nonatomic) IBOutlet UIView *sbView;
@property (weak, nonatomic) IBOutlet UIButton *actorBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhizuoBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyerBtn;
- (IBAction)actorAction:(id)sender;
- (IBAction)zhizuoAction:(id)sender;
- (IBAction)buyerAction:(id)sender;

- (IBAction)ensure:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;

@property(nonatomic,assign) NSInteger type;
@end

@implementation TypeSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sbView.layer.cornerRadius = 3;
    self.sbView.layer.masksToBounds = YES;
   
    UserType type = [UserInfoManager getUserType];
    if (type!=0) {//说明是买家
        _actorBtn.hidden = YES;
    }

}



- (IBAction)actorAction:(id)sender {
    _type = 3;
    [self.actorBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_click"] forState:0];//选中
    [self.zhizuoBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_unclick"] forState:0];
    [self.buyerBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_unclick"] forState:0];
}

- (IBAction)zhizuoAction:(id)sender {
    _type = 2;
    [self.actorBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_unclick"] forState:0];
    [self.zhizuoBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_click"] forState:0];//选中
    [self.buyerBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_unclick"] forState:0];
}

- (IBAction)buyerAction:(id)sender {
    _type = 1;
    [self.actorBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_unclick"] forState:0];
    [self.zhizuoBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_unclick"] forState:0];
    [self.buyerBtn setBackgroundImage:[UIImage imageNamed:@"identity_bg_click"] forState:0];//选中
}

- (IBAction)ensure:(id)sender {
    self.selectType(_type);
}
@end
