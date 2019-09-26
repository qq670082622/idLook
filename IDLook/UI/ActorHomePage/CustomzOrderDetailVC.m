//
//  CustomzOrderDetailVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CustomzOrderDetailVC.h"

@interface CustomzOrderDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *darenView;
@property (weak, nonatomic) IBOutlet UILabel *servType;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *planName;
@property (weak, nonatomic) IBOutlet UILabel *budget;
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *contactPosition;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;

@end

@implementation CustomzOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"订单详情"]];
    self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 683);
    NSDictionary *arg = @{
                          @"orderId":_orderId_,
                          @"userId":@([[UserInfoManager getUserUID] integerValue])
                          };
    [AFWebAPI_JAVA checkDetailCustomOrderWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *body = object[@"body"];
            //艺人
            NSArray *experts = body[@"experts"];
            CGFloat mergin = (UI_SCREEN_WIDTH-40-44*6)/5;
            for(int i =0;i<experts.count;i++){
                NSDictionary *actorDic = experts[i];
                UIImageView *icon = [UIImageView new];
                [icon sd_setImageWithUrlStr:actorDic[@"headPorUrl"] placeholderImage:[UIImage imageNamed:@"default_home"]];
                icon.layer.cornerRadius = 22;
                icon.layer.masksToBounds = YES;
                
                UILabel *name = [UILabel new];
                name.text = actorDic[@"nikeName"];
                name.textColor = Public_Text_Color;
                name.font = [UIFont systemFontOfSize:12];
                name.textAlignment = NSTextAlignmentCenter;
                
                if (i<6) {
                    icon.frame = CGRectMake(20+i*(mergin+44), 51, 44, 44);
                    name.frame = CGRectMake(20+i*(mergin+44)-(mergin/2), 99, 44+mergin, 24);
                }else{
                    if (i==12) {
                        break;
                    }
                    icon.frame = CGRectMake(20+(i-6)*(mergin+44), 127, 44, 44);
                    name.frame = CGRectMake(20+(i-6)*(mergin+44)-(mergin/2), 176, 44+mergin, 24);
                }
                [self.darenView addSubview:icon];
                [self.darenView addSubview:name];
            }
            //企划信息
            self.servType.text = body[@"serviceType"];
            self.companyName.text = body[@"companyName"];
            self.planName.text = body[@"projectName"];
            self.budget.text = [NSString stringWithFormat:@"%ld",[body[@"budget"]integerValue]];
            //联系信息
            self.contactName.text = body[@"linkmanName"];
             self.contactPosition.text = body[@"linkmanPosition"];
             self.phoneNum.text = body[@"linkmanContact"];
            //订单信息
            self.orderId.text = body[@"orderId"];
            self.orderTime.text = body[@"createTime"];
        }
    }];
}

- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
