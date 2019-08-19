//
//  AnnunDetailVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/23.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunDetailVC.h"
#import "AnnunRoleCell.h"
#import "AskPriceView.h"
#import "AnnunHeader.h"
#import "AnnunApplyvc.h"
#import "LookBigImageVC.h"
#import "SharePopV.h"
#import "ShareManager.h"
@interface AnnunDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)call:(id)sender;
- (IBAction)apply:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableArray *heightArray;
@end

@implementation AnnunDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"通告详情"]];
   //  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
    self.table.tableFooterView = [UIView new];
    self.bottomView.layer.shadowOffset = CGSizeMake(0, -8);
    self.bottomView.layer.shadowOpacity = 1.0;
    self.bottomView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
  AnnunHeader *header =[[AnnunHeader alloc] init];
    header.model = _model;
    self.data = [_model.roleList mutableCopy];
    self.table.tableHeaderView = header;
    self.table.tableHeaderView.height = 158;//6p
    CGFloat statusBarheight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (statusBarheight==44) {
         self.table.tableHeaderView.height = 75;//xr
    }
    if (UI_SCREEN_WIDTH==375 &&statusBarheight==20) {
         self.table.tableHeaderView.height = 227;//6
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>88) {
        //    如果不想让其他页面的导航栏变为透明 需要重置
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"通告详情"]];
       [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
        UIButton *shareBtn = [CustomNavVC getRightBarButtonItem2WithTarget:self action:@selector(share) normalImg:@"notice_nav_share_icon" hilightImg:@"notice_nav_share_icon"];
        shareBtn.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:shareBtn]];
    }
    if (scrollView.contentOffset.y<88) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(self.table.contentOffset.y / SafeAreaTopHeight)>0.99?0.99:(self.table.contentOffset.y /SafeAreaTopHeight)]] forBarMetrics:UIBarMetricsDefault];
        //去掉透明后导航栏下边的黑边
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"通告详情"]];
          [self.navigationItem setTitleView:[CustomNavVC setWhiteNavgationItemTitle:@"通告详情"]];
          [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultWhiteButtonWithTarget:self action:@selector(onGoback)]]];
        UIButton *shareBtn = [CustomNavVC getRightBarButtonItem2WithTarget:self action:@selector(share) normalImg:@"u_info_share_n" hilightImg:@"u_info_share_n"];
        shareBtn.adjustsImageWhenHighlighted = NO;//去掉选中时的黑影
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:shareBtn]];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    _table.tableHeaderView.height = 235;
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(self.table.contentOffset.y / SafeAreaTopHeight)>0.99?0.99:(self.table.contentOffset.y /SafeAreaTopHeight)]] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (IBAction)call:(id)sender {
    AskPriceView *ap  = [[AskPriceView alloc] init];
    [ap showWithTitle:@"咨询副导" desc:@"若对报名事宜还有疑惑，请拨打400-833-6969咨询脸探副导。" leftBtn:@"" rightBtn:@"" phoneNum:@"4008336969"];
//     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"telprompt://4008336969"]];
}
//未选角色的报名
- (IBAction)apply:(id)sender {
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {   //游客模式
        LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
        [self presentViewController:login animated:YES completion:nil];
        return;
    }
    if ([UserInfoManager getUserType]==1) {
        [SVProgressHUD showErrorWithStatus:@"购买方不能通告报名"];
        return;
    }
    AnnunApplyvc *aply = [AnnunApplyvc new];
    aply.hidesBottomBarWhenPushed = YES;
    aply.model = _model;
    [self.navigationController pushViewController:aply animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    AnnunRoleCell *cell = [AnnunRoleCell cellWithTableView:tableView];
    cell.dic = _data[indexPath.row];
    NSDictionary *heightDic = @{
                                @"height":@(cell.cellHeight),
                                @"index":@(indexPath.row)
                                };
    [self.heightArray addObject:heightDic];
    NSInteger index = indexPath.row;
    cell.index = index;
    cell.apply = ^(NSDictionary * _Nonnull roleDic) {//选了角色的报名
        if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {   //游客模式
            LoginAndRegistVC *login=[[LoginAndRegistVC alloc]init];
            [weakself presentViewController:login animated:YES completion:nil];
            return;
        }
        if ([UserInfoManager getUserType]==1) {
            [SVProgressHUD showErrorWithStatus:@"购买方不能通告报名"];
            return;
        }
        AnnunApplyvc *aply = [AnnunApplyvc new];
        aply.hidesBottomBarWhenPushed = YES;
        aply.model = weakself.model;
        aply.roleDic = roleDic;
        [weakself.navigationController pushViewController:aply animated:YES];
    };
    cell.checkImg = ^(NSString * _Nonnull imgUrl) {//查看大图
        LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
        lookImage.isShowDown=YES;
        [lookImage showWithImageArray:[NSArray arrayWithObject:imgUrl] curImgIndex:0 AbsRect:CGRectMake(0, 0,0,0)];
        lookImage.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:lookImage animated:YES];
    };
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return _footerView;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSDictionary *heightDic in _heightArray) {
        NSInteger height = [heightDic[@"height"] integerValue];
        NSInteger index = [heightDic[@"index"] integerValue];
        if (index == indexPath.row && height>0) {
            return height;
            break;
        }
    }
    return 190;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 245;
//}
-(void)share
{
    SharePopV *pop=[[SharePopV alloc]init];
    WeakSelf(self);
    pop.shareBlock=^(NSInteger tag)
    {
        NSString *test =       @"http://www.test.idlook.com/idlook_h5/annucdetails?type=annunciateDetail&annunciateId=";
        NSString *production = @"http://www.idlook.com/idlook_h5/annucdetails?annunciateId=";
        NSString *title = [NSString stringWithFormat:@"脸探通告-%@",_model.title];
        NSString *subTitle = [NSString stringWithFormat:@"简介：您与片中角色匹配度高，拍摄日期%@至%@,地点%@,点击立即报名",_model.shotStartDate,[_model.shotEndDate stringByReplacingOccurrencesOfString:@"2019-" withString:@""],_model.shotCity];
        [ShareManager shareAnnunciateWithType:tag Title:title andDesc:subTitle andUrl:[NSString stringWithFormat:@"%@%ld&type=annunciateDetail",production,_model.id] andController:weakself];
    };
    
    [pop showBottomShare];
}
-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}
-(NSMutableArray *)heightArray
{
    if (!_heightArray) {
        _heightArray = [NSMutableArray new];
    }
    return _heightArray;
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
