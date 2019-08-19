//
//  AnnunSuccessVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunSuccessVC.h"
#import "AnnunciateListVC.h"
@interface AnnunSuccessVC ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)check:(id)sender;
@end

@implementation AnnunSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"通告"]];
    self.backBtn.layer.cornerRadius = 8;
    self.backBtn.layer.borderColor = Public_Red_Color.CGColor;
    self.backBtn.layer.borderWidth = 1;
    self.backBtn.layer.masksToBounds = YES;
    
    self.checkBtn.layer.cornerRadius = 8;
    self.checkBtn.layer.borderColor = Public_Red_Color.CGColor;
    self.checkBtn.layer.borderWidth = 1;
    self.checkBtn.layer.masksToBounds = YES;
    self.navigationItem.hidesBackButton = YES;
}
- (IBAction)back:(id)sender {
    NSInteger index=[[self.navigationController viewControllers]indexOfObject:self];
   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
}
- (IBAction)check:(id)sender {
 
    AnnunciateListVC *inVC = [AnnunciateListVC new];
    inVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:inVC animated:YES];
}

@end
