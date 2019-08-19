//
//  UserInfoVC+Action.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/15.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "UserInfoVC+Action.h"
#import "ReportUserVC.h"
#import "AuthBuyerSelectPopV.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"

@implementation UserInfoVC (Action)



//更多
-(void)moreAction
{
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist)
    {
        [self goLogin];
        return;
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"更多操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"举报"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self reportUser];
                                                    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拉黑"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self PullblackUser];
                                                    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    
    [self presentViewController:alert animated:YES completion:^{}];
}


//拉黑
-(void)PullblackUser
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确定要拉黑TA吗？" message:@"拉黑后你将不再看到对方的资料" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拉黑"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        
                                                        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                                                        if ([UserInfoManager getIsJavaService]) {//java后台
                                                            NSDictionary *dicArg = @{@"userId":@([[UserInfoManager getUserUID] integerValue]),
                                                                                     @"otherUserId":@(self.info.actorId),
                                                                                     @"operateType":@"1"};
                                                            [AFWebAPI_JAVA getPullBlackUserWithArg:dicArg callBack:^(BOOL success, id  _Nonnull object) {
                                                                if (success) {
                                                                    [SVProgressHUD showSuccessWithStatus:@"用户已拉黑"];
                                                                }
                                                                else
                                                                {
                                                                    AF_SHOW_JAVA_ERROR
                                                                }
                                                            }];
                                                        }else{
                                                            NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                                                                                     @"creativeid":@(self.info.actorId),
                                                                                     @"type":@(1)};
                                                            [AFWebAPI getPullBlackUserWithArg:dicArg callBack:^(BOOL success, id object) {
                                                                if (success) {
                                                                    [SVProgressHUD showSuccessWithStatus:@"用户已拉黑"];
                                                                }
                                                                else
                                                                {
                                                                    AF_SHOW_RESULT_ERROR
                                                                }
                                                            }];
                                                            
                                                        }
                                                        
                                                    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    
    [alert addAction:action0];
    [alert addAction:action1];
    
    [self presentViewController:alert animated:YES completion:^{}];
}


//举报
-(void)reportUser
{
    ReportUserVC *reportVC=[[ReportUserVC alloc]init];
    reportVC.info=self.info;
    [self.navigationController pushViewController:reportVC animated:YES];
}
#pragma mark---未登录，先去登录
-(void)goLogin
{
    LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
    [self presentViewController:login animated:YES completion:nil];
}

#pragma mark --未认证，先去认证
-(void)goAuth
{
    if ([UserInfoManager getUserAuthState]==3){  //审核中
        [SVProgressHUD showImage:nil status:@"你的认证信息正在审核中，通过后才能下单！"];
        return;
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"去认证" message:@"认证通过之后您才能下单！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"去认证"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        
                                                        if ([UserInfoManager getUserAuthState]==0) {
                                                            AuthBuyerSelectPopV *popV = [[AuthBuyerSelectPopV alloc]init];
                                                            [popV show];
                                                            WeakSelf(self);
                                                            popV.authTypeSelectBlock = ^(NSInteger type) {
                                                                AuthBuyerVC *authVC=[[AuthBuyerVC alloc]init];
                                                                authVC.buyType=type;
                                                                authVC.hidesBottomBarWhenPushed=YES;
                                                                [weakself.navigationController pushViewController:authVC animated:YES];
                                                            };
                                                        }
                                                        else if ([UserInfoManager getUserAuthState]==2 || [UserInfoManager getUserAuthState]==3)
                                                        {
                                                            MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
                                                            stateVC.authState=[UserInfoManager getUserAuthState];
                                                            stateVC.hidesBottomBarWhenPushed=YES;
                                                            [self.navigationController pushViewController:stateVC animated:YES];
                                                        }
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}


//视频浏览量埋点统计
-(void)VideostatisticsWithWorkModel:(UserWorkModel*)model withType:(NSInteger)type
{
    if ([UserInfoManager getIsJavaService]) {
        NSDictionary *dicArg = @{@"vid":@(model.id),
                                 @"vType":@(model.vtype),
                                 @"numType":@(type),
                                 @"num":@(1)
                                 };
        [AFWebAPI_JAVA getVideoStatisticalWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
            }
            else{}
        }];
    }
    else
    {
        
        NSDictionary *dicArg = @{@"vid":@(model.id),
                                 @"vtype":@(model.vtype),
                                 @"type":@(type)};
        [AFWebAPI getVideoStatisticalWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
            }
            else{}
        }];
    }
}

@end
