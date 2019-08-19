//
//  CouponVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/16.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CouponVC.h"
#import "CouponTopV.h"
#import "CouponExplainVC.h"
#import "CouponGetPopV.h"
#import "CouponCell.h"
#import "SharePopV.h"
#import "ShareManager.h"
#import <CoreImage/CoreImage.h>
@interface CouponVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
//@property(nonatomic,strong)TouchTableV *tableV;
@property (weak, nonatomic) IBOutlet TouchTableV *tableV;

@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,strong)CouponTopV *topV;
- (IBAction)shareAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *shareView2;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImg;


@end

@implementation CouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"返现码兑换"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.dataSource= [NSMutableArray new];
    [self topV];
    [self tableVUI];
    [self getData];
    
    
    NSDictionary *dic = @{
                          @"mobile":[UserInfoManager getUserMobile]
                          };
    [AFWebAPI_JAVA getCouponShareCodeWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *body = [object objectForKey:JSON_body];
            NSString *shareCode = body[@"shareCode"];
             [self createQRCodeWithReturnCode:shareCode];
            self.codeLabel.text = shareCode;
            NSString *nickName = [UserInfoManager getUserNick];
            NSString *realName = [UserInfoManager getUserRealName];
              NSLog(@"username is %@  /// realName is %@",nickName,realName);
            self.codeLabel2.text = [NSString stringWithFormat:@"%@分享给您的返现码",realName.length>0?realName:nickName];
         }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
    [self.cancelBtn setTag:111];
    [self.QRCodeImg setTag:222];
    self.cancelBtn.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
    
    if (_returnCode.length>0) {
        [self getCouponWithCode:_returnCode];
    }
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData
{
    NSDictionary *dicArg = @{@"status":@(0),
                             @"userId":[UserInfoManager getUserUID]};
    [AFWebAPI_JAVA getCouponListWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_body];
            NSArray *array = (NSArray*)safeObjectForKey(dic, @"couponList");
            [self.dataSource removeAllObjects];
   
            for (int i=0; i<array.count; i++) {
                CouponModel *model = [CouponModel yy_modelWithDictionary:array[i]];
                [self.dataSource addObject:model];
            }
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeCoupon];
            }
            
            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_JAVA_ERROR
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeNetwork];
            }
        }
    }];
}

-(CouponTopV*)topV
{
    if (!_topV) {
        _topV=[[CouponTopV alloc]init];
        [self.view addSubview:_topV];
        _topV.backgroundColor=[UIColor whiteColor];
        [_topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view).offset(0.5);
            make.height.mas_equalTo(92);
        }];
        WeakSelf(self);
        _topV.convertBlock = ^(NSString * _Nonnull text) {
            [weakself getCouponWithCode:text];
        };
        _topV.explainBlock = ^{
            CouponExplainVC *explainVC = [[CouponExplainVC alloc]init];
            [weakself.navigationController pushViewController:explainVC animated:YES];
        };
    }
    return _topV;
}

- (IBAction)shareAction:(id)sender {
    self.shareView.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
    SharePopV *pop=[[SharePopV alloc]init];
    WeakSelf(self);
    pop.shareBlock=^(NSInteger tag)
    {
        //   [ShareManager sharePic:weakself.shareUrl shareType:tag isVideo:NO videoUrl:nil videoTitle:nil andController:weakself];
        NSDictionary *dic = @{ //先分享
                              @"action":@"rebateActorPage",
                              @"userId":@([[UserInfoManager getUserUID] integerValue]),
                              @"userType":@(1),
                              };
        [AFWebAPI_JAVA staticsWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSLog(@"---------obj is %@ -----------",object);
            }
        }];
        [ShareManager sharePic:[weakself jiep] shareType:tag isVideo:NO videoUrl:nil videoTitle:nil andController:weakself result:^(BOOL isSuccess) {
            if (isSuccess) {//分享成功了
                NSDictionary *dic = @{
                                      @"action":@"rebateShared",
                                      @"userId":@([[UserInfoManager getUserUID] integerValue]),
                                      @"userType":@(1),
                                      };
                [AFWebAPI_JAVA staticsWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
                    if (success) {
                        NSLog(@"---------obj is %@ -----------",object);
                    }
                }];
            }
        }];
    };
    pop.hideBlock = ^{
        weakself.shareView.hidden = YES;
        weakself.navigationController.navigationBar.hidden = NO;
    };
    [pop showBottomShareWithReturnView:[self duplicate:_shareView] andQRCodeImg:self.QRCodeImg.image];
}

-(void)tableVUI
{
   // if (!_tableV) {
      //  _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,92,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-92-90) style:UITableViewStyleGrouped];
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(92);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-90);
    }];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
//    }
//    return _tableV;
}


#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:@"me_coupon_list_bg_w"];
    return image.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"CouponCell";
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    CouponModel *model =self.dataSource[indexPath.section];
    [cell reloadUIWithModel:model];
    WeakSelf(self);
    cell.getFirstBlock = ^{
        [weakself getFirsSortWithModel:model];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)getCouponWithCode:(NSString*)code
{
    NSDictionary *dicArg = @{@"shareCode":code,
                             @"userId":[UserInfoManager getUserUID]};
    [AFWebAPI_JAVA getCoupongenerateCodeWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *dic = [object objectForKey:JSON_body];
            CouponModel *model = [CouponModel yy_modelWithDictionary:dic];
            CouponGetPopV *popV = [[CouponGetPopV alloc]init];
            [popV showWithModel:model];
            popV.goUserBlock = ^{
                self.navigationController.tabBarController.selectedIndex=0;  //0
                [self.navigationController popToRootViewControllerAnimated:NO];
            };
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}

-(void)getFirsSortWithModel:(CouponModel*)model
{
    NSDictionary *dicArg = @{@"firstPriorityId":@(model.couponId),
                             @"userId":[UserInfoManager getUserUID]};
    [AFWebAPI_JAVA getCouponSortWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            for (int i=0; i<self.dataSource.count; i++) {
                CouponModel *modelA = self.dataSource[i];
                if (model.couponId ==modelA.couponId) {
                    modelA.firstPriority=YES;
                }
                else
                {
                    modelA.firstPriority=NO;
                }
                [self.tableV reloadData];
//                [self getData];
            }
        }
        else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
}
-(UIImage *)jiep
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.shareView2.frame.size.width,self.shareView2.frame.size.height), YES, 0);
    [self.shareView2.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRef];
    NSLog(@"sendImage==%@",sendImage);
    //保存图片到照片库 （iOS10 以上记得在info.plist添加相册访问权限，否则可能崩溃）
    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);
   // UIImageView *qrcode = [[UIImageView alloc] initWithImage:self.QRCodeImg.image];
    return sendImage;
}
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
- (void)createQRCodeWithReturnCode:(NSString *)returnCode{
    
         // 0.导入头文件#import <CoreImage/CoreImage.h>
    
         // 1.创建过滤器 -- 苹果没有将这个字符封装成常量
         CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
         // 2.过滤器恢复默认设置
         [filter setDefaults];
    
         // 3.给过滤器添加数据(正则表达式/帐号和密码) -- 通过KVC设置过滤器,只能设置NSData类型
    NSString *test = @"http://www.test.idlook.com/idlook_h5/advertising/download?returnCode=";
    NSString *production = @"http://www.idlook.com/idlook_h5/advertising/download?returnCode=";
    NSString *dataString = [NSString stringWithFormat:@"%@%@&userId=%@&type=returnCode",production,returnCode,[UserInfoManager getUserUID]];
         NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
         [filter setValue:data forKeyPath:@"inputMessage"];
    
         // 4.获取输出的二维码
         CIImage *outputImage = [filter outputImage];
    
         // 5.显示二维码
         self.QRCodeImg.image = [UIImage imageWithCIImage:outputImage];
     }
@end
