//
//  InsuranceOrderDetailVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/12.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsuranceOrderDetailVC.h"
#import "InsuranceCompensateVC.h"
#import "AskPriceView.h"
@interface InsuranceOrderDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *planeType;
@property (weak, nonatomic) IBOutlet UILabel *insuranceNum;


@property (weak, nonatomic) IBOutlet UILabel *name_jib;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *card_num;



@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)compensateAction:(id)sender;

@end

@implementation InsuranceOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (_type==1) {
//        self.btn.hidden = YES;
         [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"订单详情"]];
//    }else{
//          [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"申请理赔"]];
//    }
   
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    // Do any additional setup after loading the view from its nib.
    self.btn.layer.cornerRadius = 8;
    self.btn.layer.borderColor = Public_Red_Color.CGColor;
    self.btn.layer.borderWidth = 1;
    self.btn.layer.masksToBounds = YES;
    
    NSDictionary *userDic = [_model.userList objectAtIndex:0];
    NSString *name = userDic[@"policyUserName"];
    NSInteger occupation = [userDic[@"occupation"]integerValue];
        NSArray *jobs =  @[@"制作经理",@"制片",@"制作助理",@"导演",@"Free制片",@"采购人员",@"其他"];
    NSString *job = jobs[occupation];
    self.name_jib.text = [NSString stringWithFormat:@"%@·%@",name,job];
    NSString *phone = userDic[@"mobile"];
    self.phone.text = phone;
   self.price.text = [NSString stringWithFormat:@"%ld元",_model.amount];
    self.insuranceNum.text = [NSString stringWithFormat:@"保单号：%@",_model.policyNum.length==0?@"生成中":_model.policyNum];
    self.time.text = [NSString stringWithFormat:@"%@至%@",_model.effectiveTime,_model.expireTime];
    
  
self.card_num.text = [NSString stringWithFormat:@"身份证·%@",userDic[@"policyUserCertNo"]];
//    if (model.status==13) {
//        self.statuesLabel.text = @"进行中";
//    }else{
//        self.statuesLabel.text = @"已完成 ";
//    }
    
    if (_model.planType==0) {
        self.planeType.text = @"平安意外伤害保险 - 20万版";
    }else{
        self.planeType.text = @"平安意外伤害保险 - 30万版";
    }
    
    
}



- (IBAction)compensateAction:(id)sender {
//    InsuranceCompensateVC *cmVC = [InsuranceCompensateVC new];
//    cmVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:cmVC animated:YES];
    AskPriceView *ap  = [[AskPriceView alloc] init];
    [ap showWithTitle:@"申请理赔" desc:@"请拨打平安业务部门报案电话：021-20662618，沟通理赔相关注意事项及理赔所需材料" leftBtn:@"" rightBtn:@"" phoneNum:@"02120662618"];
    

}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
