//
//  InsuranceVC.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/11.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "InsuranceVC.h"
#import "InsuranceHeaderView.h"
#import "InsurancePlanCell.h"
#import "InsuranceCompensateCell.h"
#import "InsuranceQuestionsCell.h"
#import "InsuranceInfovc.h"
#import "WebVC.h"
@interface InsuranceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
- (IBAction)phoneAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *version;
- (IBAction)buy:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (weak, nonatomic) IBOutlet UIButton *planeBtn;
- (IBAction)planAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *compensateBtn;
- (IBAction)compensateAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *questionsBtn;
- (IBAction)questionsAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *redLine;

@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger lastRowHei;
@end

@implementation InsuranceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"400-833-6969"];
   
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    //在某个范围内增加下划线
 [str addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ff6f01"],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, [str length])];
    [_phoneBtn setAttributedTitle:str forState:0];
    
    self.version.layer.borderWidth = 0.5;
    self.version.layer.borderColor = Public_Red_Color.CGColor;
    [self.price sizeToFit];
    _price.width+=10;
    [self.version sizeToFit];
    self.version.width+=10;
    self.price.frame = CGRectMake(47, 50, _price.width, 48);
    _version.frame = CGRectMake(_price.right+10, 67, _version.width, 15);
    self.table.tableHeaderView = [[InsuranceHeaderView alloc] init];
    _table.tableHeaderView.height = 161;
    _type = 1;
    self.table.tableFooterView = [UIView new];
    [self.table reloadData];
    NSLog(@"header's height is %f,",_table.tableHeaderView.height);
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>171+340) {
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
            self.redLine.transform = CGAffineTransformMakeTranslation(UI_SCREEN_WIDTH/3, 0);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    if (scrollView.contentOffset.y>171+417+580) {
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
            self.redLine.transform = CGAffineTransformMakeTranslation(UI_SCREEN_WIDTH*2/3, 0);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    if (scrollView.contentOffset.y<171+250) {
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
            self.redLine.transform = CGAffineTransformMakeTranslation(0, 0);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (scrollView.contentOffset.y>107) {
        //    如果不想让其他页面的导航栏变为透明 需要重置
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
         [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"意外险"]];
    }
    if (scrollView.contentOffset.y<107) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:(self.table.contentOffset.y / SafeAreaTopHeight)>0.99?0.99:(self.table.contentOffset.y /SafeAreaTopHeight)]] forBarMetrics:UIBarMetricsDefault];
        //去掉透明后导航栏下边的黑边
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
         [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@""]];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    if (indexPath.row==0) {
        InsurancePlanCell *cell = [InsurancePlanCell cellWithTableView:tableView];
        cell.type = _type;
        cell.slectType = ^(NSInteger type) {
            weakself.type = type;
            weakself.version.text = type==1?@"20万版本":@"30万版本";
            weakself.price.text = type==1?@"￥10":@"￥15";
            [weakself.table reloadData];
        };
        cell.check = ^{
            WebVC *wvc = [WebVC new];
            wvc.hidesBottomBarWhenPushed = YES;
            wvc.navTitle = @"保险条款";
            wvc.fileName = @"InsurancePDF";
            [weakself.navigationController pushViewController:wvc animated:YES];
        };
        return cell;
    }else if (indexPath.row==1){
        InsuranceCompensateCell *cell = [InsuranceCompensateCell cellWithTableView:tableView];
        cell.download = ^{
            
        };
        return cell;
    }else if (indexPath.row==2){
        InsuranceQuestionsCell *cell = [InsuranceQuestionsCell cellWithTableView:tableView];
        _lastRowHei = cell.cellHeight;
        return cell;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
         return 417;
    }else if (indexPath.row==1){
       return 720;
    }else if (indexPath.row==2){
        return _lastRowHei;
    }
    return 0;
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _sectionView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48;
}
- (IBAction)phoneAction:(id)sender {
   
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"telprompt://4008336969"]];
}
- (IBAction)buy:(id)sender {
    InsuranceInfovc *inf = [InsuranceInfovc new];
    inf.selectType = _type;
    inf.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inf animated:YES];
}
- (IBAction)planAction:(id)sender {
      [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
        self.redLine.transform = CGAffineTransformMakeTranslation(0, 0);
      
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)compensateAction:(id)sender {
     [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
        self.redLine.transform = CGAffineTransformMakeTranslation(UI_SCREEN_WIDTH/3, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)questionsAction:(id)sender {
       [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
        self.redLine.transform = CGAffineTransformMakeTranslation(UI_SCREEN_WIDTH*2/3, 0);
      
    } completion:^(BOOL finished) {
        
    }];
}
-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    CGFloat statusBarheight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (statusBarheight==44) {
        self.table.tableHeaderView.height-=145;
    }
    if (UI_SCREEN_WIDTH==414) {
        self.table.tableHeaderView.height-=70;
    }
}
@end
