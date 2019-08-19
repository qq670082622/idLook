//
//  RoleServiceApplyVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "RoleServiceApplyVC.h"
#import "AuditApplyBottomV.h"
#import "RoleServiceApplyFinishVC.h"
#import "AuditApplyViewA.h"
#import "AuditApplyViewB.h"
#import "AuditAppleViewC.h"

@interface RoleServiceApplyVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)AuditApplyBottomV *bottomV;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)NSInteger auditionType;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,assign)NSInteger count;

@end

@implementation RoleServiceApplyVC

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=Public_Background_Color;
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.auditionType=2;
    [self initUI];
    [self bottomV];
    
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
//    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController setNavigationBarHidden:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //如果不想让其他页面的导航栏变为透明 需要重置
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController setNavigationBarHidden:NO];

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tapAction
{
    [self.view endEditing:YES];
}

-(void)initUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,-UI_STATUS_BAR_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-98+UI_STATUS_BAR_HEIGHT)];
    scrollView.backgroundColor=Public_Background_Color;
    scrollView.scrollEnabled = YES;//设置是否支持滚动
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator = NO;//设置是否显示水平滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    scrollView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [scrollView addGestureRecognizer:tap];
    self.scrollView=scrollView;

    UIImage *image =[UIImage imageNamed:@"roleService_bg"];
    UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH,image.size.height)];
    [scrollView addSubview:bg];
//    bg.contentMode=UIViewContentModeScaleAspectFill;
    bg.image=image;
    scrollView.contentSize=CGSizeMake(UI_SCREEN_WIDTH, 415+285+image.size.height-20+UI_STATUS_BAR_HEIGHT);
    
    AuditAppleViewC *viewA = [[AuditAppleViewC alloc]init];
    [scrollView addSubview:viewA];
    [viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(bg.mas_bottom).offset(-30);
        make.height.mas_equalTo(415);
    }];
    WeakSelf(self);


    AuditApplyViewB *viewB = [[AuditApplyViewB alloc]init];
    [scrollView addSubview:viewB];
    [viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(viewA.mas_bottom).offset(10);
        make.height.mas_equalTo(285);
    }];
    viewB.textViewChangeBlock = ^(NSString * _Nonnull text) {
        weakself.remark=text;
    };
    viewB.textViewBeginEditBlock = ^{  //开始编辑
        [weakself.scrollView setContentOffset:CGPointMake(0, 415+285+image.size.height-20-UI_SCREEN_HEIGHT+275+SafeAreaTabBarHeight_IphoneX+UI_STATUS_BAR_HEIGHT) animated:YES];
    };
    viewB.textViewEndEditBlock = ^{  //结束编辑
        [weakself.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    };
    viewB.countsChangeBlock = ^(NSInteger count) {
        weakself.count=count;
        [weakself refreshTotalPrice];
    };
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backBtn];
    backBtn.frame = CGRectMake(10,UI_STATUS_BAR_HEIGHT,70, 48);
    [backBtn setImage:[UIImage imageNamed:@"u_info_back_white"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    backBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(1, -13, -1, 13)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-13, 0,13)];
    [backBtn addTarget:self action:@selector(onGoback) forControlEvents:UIControlEventTouchUpInside];
    
    //粗体
    if (IsBoldSize()) {
        backBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-7,0,7);
    }
}

-(AuditApplyBottomV*)bottomV
{
    if (!_bottomV) {
        _bottomV = [[AuditApplyBottomV alloc]init];
        [self.view addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            make.height.mas_equalTo(SafeAreaTabBarHeight_IphoneX+98);
        }];
        WeakSelf(self);
        _bottomV.placeOrderBlock = ^{
            [weakself submitOrder];
        };
    }
    return _bottomV;
}

//总价刷新
-(void)refreshTotalPrice
{
    NSInteger totalPrice=0;
    if (self.count<=5) {
        totalPrice=200*self.count;
    }
    else if(self.count<=9)
    {
        totalPrice=200*5+(self.count-5)*180;
    }
    else
    {
        totalPrice=200*5+4*180+(self.count-9)*160;
    }
    [self.bottomV reloadUIWithTotalPrice:totalPrice];
}

//提交订单
-(void)submitOrder
{
    
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist)
    {
        LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
        [self presentViewController:login animated:YES completion:nil];
        return;
    }
    
    if (self.count<=0) {
        [SVProgressHUD showImage:nil status:@"请选择演员人数"];
        return;
    }
    
    [SVProgressHUD showImage:nil status:@"正在提交订单，请稍等。。"];
    NSDictionary *dicArg = @{@"serviceType":@(self.auditionType),
                             @"count":@(self.count),
                             @"remark":self.remark.length==0?@"":self.remark,
                             @"userId":[UserInfoManager getUserUID]};
    [AFWebAPI_JAVA getCreatRoleServiceWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"订单已提交"];
            
            NSDictionary *auditionServiceInfo = [[object objectForKey:JSON_body] objectForKey:@"chooseActorServiceOrderInfo"];
            RoleServiceModel *model = [RoleServiceModel yy_modelWithDictionary:auditionServiceInfo];
            
            RoleServiceApplyFinishVC *finishVC = [[RoleServiceApplyFinishVC alloc]init];
            finishVC.model=model;
            [self.navigationController pushViewController:finishVC animated:YES];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSLog(@"will hide");
}

- (void)keyboardFrameWillChange:(NSNotification*)notification
{
    NSLog(@"will change");
}

@end
