//
//  InsuranceBuySuccessVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsuranceBuySuccessVC.h"
#import "InsuranceOrderDetailVC.h"
#import "MyInsuranceVC.h"
@interface InsuranceBuySuccessVC ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)check:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *faildTip;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation InsuranceBuySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"购买结果"]];
    self.backBtn.layer.cornerRadius = 8;
    self.backBtn.layer.borderColor = Public_Red_Color.CGColor;
    self.backBtn.layer.borderWidth = 1;
    self.backBtn.layer.masksToBounds = YES;
    
    self.checkBtn.layer.cornerRadius = 8;
    self.checkBtn.layer.borderColor = Public_Red_Color.CGColor;
    self.checkBtn.layer.borderWidth = 1;
    self.checkBtn.layer.masksToBounds = YES;
    
    if (_isSuccess) {
        [_img setImage:[UIImage imageNamed:@"insurance_order_compensate_def_s"]];
        self.faildTip.hidden = YES;
    }else{
         [_img setImage:[UIImage imageNamed:@"insurance_order_compensate_def_f"]];
        self.faildTip.hidden = NO;
    }
    self.navigationItem.hidesBackButton = YES;
    
}


- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)check:(id)sender {
//    InsuranceOrderDetailVC *detail = [InsuranceOrderDetailVC new];
//    detail.type = 2;
//    detail.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detail animated:YES];
    MyInsuranceVC *inVC = [MyInsuranceVC new];
    inVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:inVC animated:YES];
}
@end
