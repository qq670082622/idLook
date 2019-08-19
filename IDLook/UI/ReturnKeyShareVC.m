//
//  ReturnKeyShareVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/5/8.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ReturnKeyShareVC.h"
#import "SharePopV.h"
#import "ShareManager.h"
@interface ReturnKeyShareVC ()
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UILabel *code;
- (IBAction)share:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *shareView;
- (IBAction)cancelShare:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
//@property(nonatomic,strong)UIImage *shareImg;
@property (weak, nonatomic) IBOutlet UIView *shareView2;
@property (weak, nonatomic) IBOutlet UILabel *code2;
@property (weak, nonatomic) IBOutlet UILabel *nameCode;
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImg;

@property (weak, nonatomic) IBOutlet UILabel *num1;
@property (weak, nonatomic) IBOutlet UILabel *num2;
@property (weak, nonatomic) IBOutlet UILabel *num3;
@property (weak, nonatomic) IBOutlet UILabel *num4;
@property (weak, nonatomic) IBOutlet UILabel *Tip4;

@property (weak, nonatomic) IBOutlet UILabel *num5;

@end

@implementation ReturnKeyShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeView.layer.cornerRadius = 9;
    self.codeView.layer.masksToBounds = YES;
      [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"返现码分享"]];
    [self yuanjiao];
      [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    NSDictionary *dic = @{
                          @"mobile":[UserInfoManager getUserMobile]
                          };
    [AFWebAPI_JAVA getCouponShareCodeWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSDictionary *body = [object objectForKey:JSON_body];
            NSString *shareCode = body[@"shareCode"];
            [self createQRCodeWithReturnCode:shareCode];
            self.code.text = shareCode;
            self.code2.text = shareCode;
          //  NSLog(@"username is %@  /// realName is %@",[UserInfoManager getUserNick],[UserInfoManager getUserRealName]);
            self.nameCode.text = [NSString stringWithFormat:@"%@分享给您的返现码",[UserInfoManager getUserRealName]];
//            NSDictionary *uploadDic = @{
//                                        @"category":@(1),
//                                        @"fileType":@(1),
//                                        @"userId":@([[UserInfoManager getUserUID]integerValue])
//                                        };
//            UIImage *scaleImage = [self jiep];
//            NSData *data = UIImageJPEGRepresentation(scaleImage, 1);
//            [AFWebAPI_JAVA uploadCommonWithArg:uploadDic data:data callBack:^(BOOL success, id  _Nonnull object) {
//                if (success) {
//                    NSDictionary *response = object[@"body"];
//                    NSString *url = response[@"url"];
//                    self.shareUrl =url;
//                }
//            }];
        }else{
            [SVProgressHUD showErrorWithStatus:object];
        }
    }];
    self.scrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 1005);
    [self.cancelBtn setTag:111];
    [self.QRCodeImg setTag:222];
    self.cancelBtn.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
 
}


- (IBAction)share:(id)sender {
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
                              @"userType":@(2),
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
                                      @"userType":@(2),
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
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
- (IBAction)cancelShare:(id)sender {
      self.shareView.hidden = YES;
      self.navigationController.navigationBar.hidden = NO;
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
    return sendImage;
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
-(void)yuanjiao
{
    self.num1.layer.cornerRadius = 6.5;
    self.num1.layer.masksToBounds = YES;
    self.num2.layer.cornerRadius = 6.5;
    self.num2.layer.masksToBounds = YES;
    self.num3.layer.cornerRadius = 6.5;
    self.num3.layer.masksToBounds = YES;
    self.num4.layer.cornerRadius = 6.5;
    self.num4.layer.masksToBounds = YES;
    [_Tip4 sizeToFit];
    _num4.y = _Tip4.y+4;
    self.num5.layer.cornerRadius = 6.5;
    self.num5.layer.masksToBounds = YES;
}
@end
