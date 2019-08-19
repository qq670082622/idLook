//
//  SettingMainVC.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SettingMainVC.h"
#import "SettingMainCell.h"
#import "MsgSettingVC.h"
#import "ContactVC.h"
#import "FeedbackVC.h"
#import "AboutVC.h"
#import "ResetPasswordVC.h"
#import "ChangeMobileStep1.h"
#import "LoginAndRegistVC.h"
#import "SettingMainCellB.h"
#import "LoginAndRegistVC.h"
#import "BlackListVC.h"
#import "NetWorkSetVC.h"
#import "VIMediaCache.h"

@interface SettingMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation SettingMainVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"设置"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.dataSource = [[NSMutableArray alloc]initWithObjects:
                       @[@"账号安全",@"消息设置",@"播放设置",@"清理缓存",@"黑名单"],
                       @[@"联系我们",@"意见反馈",@"关于脸探肖像"],
                       @[@"退出登录"],nil];
    
    [self tableV];
    
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableV.separatorColor = Public_LineGray_Color;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
    }
    return _tableV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return .1f;
    }
    else if (section==2)
    {
        return 30.f;
    }
    return 10.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section]count];;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section<=1) {
        static NSString *identifer = @"SettingMainCell";
        SettingMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[SettingMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell reloadUIWithTitle:self.dataSource[indexPath.section][indexPath.row] withDesc:@""];
        return cell;
    }
    else
    {
        static NSString *identifer = @"SettingMainCellB";
        SettingMainCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[SettingMainCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *str = self.dataSource[indexPath.section][indexPath.row];
    if([str length])
    {
        if([str isEqualToString:@"账号安全"])
        {
            [self securityAction];
        }
        else if([str isEqualToString:@"消息设置"])
        {
            MsgSettingVC *msg = [[MsgSettingVC alloc] init];
            [self.navigationController pushViewController:msg animated:YES];
        }
        else if([str isEqualToString:@"联系我们"])
        {            
            ContactVC *contactVC = [[ContactVC alloc] init];
            [self.navigationController pushViewController:contactVC animated:YES];
        }
        else if([str isEqualToString:@"意见反馈"])
        {
            FeedbackVC *lis = [[FeedbackVC alloc] init];
            [self.navigationController pushViewController:lis animated:YES];
        }
        else if([str isEqualToString:@"关于脸探肖像"])
        {
            AboutVC *abo = [[AboutVC alloc] init];
            [self.navigationController pushViewController:abo animated:YES];
        }
        else if([str isEqualToString:@"退出登录"])
        {
            [self logOut];
        }
        else if ([str isEqualToString:@"黑名单"])
        {
            BlackListVC *blackListVC = [[BlackListVC alloc] init];
            [self.navigationController pushViewController:blackListVC animated:YES];
        }
        else if ([str isEqualToString:@"播放设置"])
        {
            NetWorkSetVC *networkVC = [[NetWorkSetVC alloc] init];
            [self.navigationController pushViewController:networkVC animated:YES];
        }
        else if ([str isEqualToString:@"清理缓存"])
        {
            [self cleanCache];
        }
    }
}

//清理缓存
-(void)cleanCache
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"确定要清除缓存吗？"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showWithStatus:@"正在清理缓存，请稍后" maskType:SVProgressHUDMaskTypeClear];
        NSError *error;
        [VICacheManager cleanAllCacheWithError:&error];
        if (error) {
            NSLog(@"clean cache failure: %@", error);
            [SVProgressHUD showErrorWithStatus:@"清理出错"];
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"清理成功"];
        });
        [self.tableV reloadData];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [alert dismissViewControllerAnimated:YES completion:^{}];
                                                    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)securityAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"重置密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ResetPasswordVC *resetpasswordVC = [[ResetPasswordVC alloc]init];
        resetpasswordVC.isPush=YES;
        resetpasswordVC.type=1;
        [self.navigationController pushViewController:resetpasswordVC animated:NO];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"更换手机号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ChangeMobileStep1 *changeMVC = [[ChangeMobileStep1 alloc]init];
        [self.navigationController pushViewController:changeMVC animated:NO];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [alert dismissViewControllerAnimated:YES completion:^{}];
                                                    }];
    
    [alert addAction:action0];
    [alert addAction:action1];
    [alert addAction:action2];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
    
}

//退出登录
-(void)logOut
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确定要退出吗？" message:@"退出后，不会删除历史数据，下次登录需要手动输入账号和密码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"退出"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        
                                                        [UserInfoManager clearUserLoginfo];
                                                        
//                                                        AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//                                                        [dele showLRVC];
                                                        
                                                        LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
                                                        login.isHideClose=YES;
                                                        [self presentViewController:login animated:YES completion:nil];
                                                        
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}

@end
