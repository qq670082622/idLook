//
//  CheckGradeViewController.m
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "CheckGradeViewController.h"
#import "CheckGradeSectionView.h"
#import "CheckGradeModel.h"
#import "CheckGradeCell.h"
#import "PublishGradeViewController.h"
@interface CheckGradeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet CustomTableV *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation CheckGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // if (_isMy) {
         [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"我的评价"]];
//    }else{
//        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"评价"]];
//    }
   
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    self.tableView.tableFooterView = [UIView new];
    [self loadData];
   
}
-(void)loadData
{
    NSDictionary *evaluateTags11 = [NSDictionary dictionaryWithObjectsAndKeys:@"11",@"attrid",@"表演有亮点",@"attrname", nil];
    NSDictionary *evaluateTags12 = [NSDictionary dictionaryWithObjectsAndKeys:@"12",@"attrid",@"理解脚本能力强",@"attrname", nil];
    NSDictionary *evaluateTags13 = [NSDictionary dictionaryWithObjectsAndKeys:@"13",@"attrid",@"现场配合度高",@"attrname", nil];
    NSDictionary *evaluateTags14 = [NSDictionary dictionaryWithObjectsAndKeys:@"14",@"attrid",@"提前到场准备",@"attrname", nil];
    NSDictionary *evaluateTags15 = [NSDictionary dictionaryWithObjectsAndKeys:@"15",@"attrid",@"有专业互动",@"attrname", nil];
    NSDictionary *evaluateTags16 = [NSDictionary dictionaryWithObjectsAndKeys:@"16",@"attrid",@"有礼貌",@"attrname", nil];
    
    NSDictionary *evaluateTags21 = [NSDictionary dictionaryWithObjectsAndKeys:@"21",@"attrid",@"理解脚本能力一般",@"attrname", nil];
    NSDictionary *evaluateTags22 = [NSDictionary dictionaryWithObjectsAndKeys:@"22",@"attrid",@"演技一般",@"attrname", nil];
    NSDictionary *evaluateTags23 = [NSDictionary dictionaryWithObjectsAndKeys:@"23",@"attrid",@"准时到场",@"attrname", nil];
    NSDictionary *evaluateTags24 = [NSDictionary dictionaryWithObjectsAndKeys:@"24",@"attrid",@"表演配合良好",@"attrname", nil];
    NSDictionary *evaluateTags25 = [NSDictionary dictionaryWithObjectsAndKeys:@"25",@"attrid",@"偶有情绪般",@"attrname", nil];
    
    NSDictionary *evaluateTags31 = [NSDictionary dictionaryWithObjectsAndKeys:@"31",@"attrid",@"理解能力有待提高",@"attrname", nil];
    NSDictionary *evaluateTags32 = [NSDictionary dictionaryWithObjectsAndKeys:@"32",@"attrid",@"演技有待提高",@"attrname", nil];
    NSDictionary *evaluateTags33 = [NSDictionary dictionaryWithObjectsAndKeys:@"33",@"attrid",@"迟到半小时以上",@"attrname", nil];
    NSDictionary *evaluateTags34 = [NSDictionary dictionaryWithObjectsAndKeys:@"34",@"attrid",@"表演不配合",@"attrname", nil];
    NSDictionary *evaluateTags35 = [NSDictionary dictionaryWithObjectsAndKeys:@"35",@"attrid",@"容易情绪化",@"attrname", nil];
    
    NSArray *tipsArray = [NSArray arrayWithObjects:evaluateTags11,evaluateTags12, evaluateTags13,evaluateTags14,evaluateTags15, evaluateTags16,evaluateTags21,evaluateTags22,evaluateTags23,evaluateTags24,evaluateTags25,evaluateTags31,evaluateTags32,evaluateTags33,evaluateTags34,evaluateTags35,nil];
 
        NSDictionary *dic = @{
                              @"pageCount":@(30),
                              @"pageNumber":@(1),
                              @"userId":@([[UserInfoManager getUserUID] integerValue])
                              };
        [AFWebAPI_JAVA checkProjectGradeWithArg:dic callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSDictionary *body = (NSDictionary *)object[@"body"];
                NSArray *grades = body[@"evaluateList"];
                if (grades.count==0) {
                    [self.tableView showWithNoDataType:NoDataTypeGrade];
                    return ;
                }
                [self.tableView hideNoDataScene];
                for (NSDictionary *grade in body[@"evaluateList"]) {
               //     NSMutableArray *tipStringArray = [NSMutableArray new];
                
                    NSArray *gradeStrings = [grade[@"tag"] componentsSeparatedByString:@"|"];
//                    for (NSDictionary *tipDic in tipsArray) {
//                        for (NSString *tipId in gradeStrings) {
//                            if ([tipDic[@"attrid"]isEqualToString:tipId]) {
//                                [tipStringArray addObject:tipDic[@"attrname"]];
//                            }
//                        }
//
//                    }
           
                                        //@"gradeStrings":tipStringArray,
        
                    CheckGradeModel *checkModel = [CheckGradeModel yy_modelWithDictionary:grade];
                    checkModel.gradeStrings = gradeStrings;
                    [self.dataSource addObject:checkModel];
                }
                [self.tableView reloadData];
            }else{
                [SVProgressHUD showErrorWithStatus:object];
            }
        }];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
   __block CheckGradeCell *cell = [CheckGradeCell cellWithTableView:tableView];
    __block CheckGradeModel *model = self.dataSource[indexPath.row];
    cell.checkModel = model;
    cell.userInfoAction = ^{
          NSDictionary *actorInfo = model.actorInfo;
        NSInteger actorId = [actorInfo[@"actorId"] integerValue];
        UserInfoVC *userInfoVC=[[UserInfoVC alloc]init];
        userInfoVC.hidesBottomBarWhenPushed=YES;
        UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
        uInfo.actorId = actorId;
       uInfo.nickName = actorInfo[@"actorName"];
        uInfo.sex = [actorInfo[@"sex"] integerValue];
        uInfo.region = actorInfo[@"region"];
        uInfo.avatar = actorInfo[@"actorHead"];
        userInfoVC.info =uInfo;
       [weakself.navigationController pushViewController:userInfoVC animated:YES];
    };
   cell.moreAction = ^{
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        NSString *anomyTitle = model.anonymous==1?@"我要匿名":@"取消匿名";
        UIAlertAction *anomy = [UIAlertAction actionWithTitle:anomyTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          if (model.anonymous==2) {
                model.anonymous=1;
            }else{
                model.anonymous = 2;
            }
            NSDictionary *evaluateInfo = @{
                                           @"actingPower":@(model.actingPower),
                                           @"comment":model.comment,
                                           @"coordination":@(model.coordination),
                                           @"favor":@(model.favor),
                                           @"level":@(model.level),
                                           @"performance":@(model.performance),
                                           @"tag":[model.gradeStrings componentsJoinedByString:@"|"]
                                           };
            NSDictionary *gradeDic = @{@"anonymous":@(model.anonymous),
                                       @"id":@(model.id),
                                       @"status":@(0),
                                       @"userId":@([[UserInfoManager getUserUID] integerValue]),
                                       @"evaluateInfo":evaluateInfo
                                       };
            [AFWebAPI_JAVA modifyGradeWithArg:gradeDic callBack:^(BOOL success, id  _Nonnull object) {
                if (success) {
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:object];
                }
            }];
            [weakself.tableView reloadData];
        }];
   
        UIAlertAction *reGrade = [UIAlertAction actionWithTitle:@"修改评价" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            PublishGradeViewController *publish = [PublishGradeViewController new];
            publish.checkModel = model;
            [weakself.navigationController pushViewController:publish animated:YES];
        }];
         [alertController addAction:cancelAction];
         [alertController addAction:anomy];
         [alertController addAction:reGrade];
        [weakself presentViewController:alertController animated:YES completion:nil];
    };
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

     CheckGradeCell *cell = [CheckGradeCell cellWithTableView:tableView];
     CheckGradeModel *model = self.dataSource[indexPath.row];
    cell.checkModel = model;
    return cell.cellHeight;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    self.tableView.height-=34;
}
@end
