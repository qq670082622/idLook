//
//  MyProjectVC2.m
//  IDLook
//
//  Created by 吴铭 on 2019/4/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "MyProjectVC2.h"
#import "ProjectDetailVC2.h"

#import "ProjectCell2.h"
@interface MyProjectVC2 ()<UITableViewDelegate,UITableViewDataSource,ProjectDetailVC2Delegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet CustomTableV *table;
- (IBAction)add:(id)sender;
@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation MyProjectVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isSelectType) {
         [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"我的项目"]];
    }else{
         [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"选择项目"]];
    }
   
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    // Do any additional setup after loading the view from its nib.
    [_table addHeaderWithTarget:self action:@selector(pullDownToRefresh)];
    self.table.animatedStyle = TABTableViewAnimationStart;
    
 //   [self pullDownToRefresh];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self pullDownToRefresh];
}
-(void)pullDownToRefresh
{
  NSMutableDictionary *dicArg = [NSMutableDictionary new];
    NSString *uid = [UserInfoManager getUserUID];
    [dicArg setObject:@([uid integerValue]) forKey:@"userId"];
    [dicArg setObject:@(1) forKey:@"pageNumber"];
     [dicArg setObject:@(100) forKey:@"pageCount"];
    [AFWebAPI_JAVA getProjectListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            self.table.animatedStyle = TABTableViewAnimationEnd;
            
            NSArray *array =[object objectForKey:JSON_body][@"projectList"];
           
                [self.data removeAllObjects];
            self.data = [array mutableCopy];
            
//            for (NSDictionary *proj in array) {
//                ProjectModel2 *model = [ProjectModel2 yy_modelWithDictionary:proj];
//                [self.table hideNoDataScene];
//              [self.data addObject:model];
//
//            }
            
         self.table.tableFooterView = [UIView new];
            [self.table headerEndRefreshing];
            if ( _data.count==0) {//试镜
                [self.table showWithNoDataType:NoDataTypeProject];
                
            }
            [self.table reloadData];
            
            }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    ProjectCell2 *cell = [ProjectCell2 cellWithTableView:tableView];
//    cell.isSelectType = _isSelectType;
    if (tableView.animatedStyle != TABTableViewAnimationStart) {
  NSDictionary *dic = _data[indexPath.row];
        cell.dic = dic;
//    __block    BOOL overTime = [dic[@"overtime"] boolValue];
       cell.btnClicked = ^(NSString * _Nonnull clickType) {
//           if (overTime) {//过期
//               [SVProgressHUD showImage:nil status:@"该项目已过拍摄时间，请选择其他项目。"];
//               return ;
//           }
            if ([clickType isEqualToString:@"查看"]) {
                NSDictionary *diaArg = @{
                                         @"projectId":dic[@"projectId"],
                                         @"userId": @([[UserInfoManager getUserUID] integerValue])
                                         };
                [AFWebAPI_JAVA getProjectDetialWithArg:diaArg callBack:^(BOOL success, id  _Nonnull object) {
                    if (success) {
                        NSDictionary *moDic = [object objectForKey:JSON_body];
                        ProjectModel2 *model = [ProjectModel2 yy_modelWithDictionary:moDic];
                        ProjectDetailVC2 *PDVC = [ProjectDetailVC2 new];
                        PDVC.hidesBottomBarWhenPushed=YES;
                        PDVC.model = model;
                        PDVC.type = 3;
                        [weakself.navigationController pushViewController:PDVC animated:YES];
                    }
                }];
               
            }else if ([clickType isEqualToString:@"编辑"]){
                NSDictionary *diaArg = @{
                                         @"projectId":dic[@"projectId"],
                                         @"userId": @([[UserInfoManager getUserUID] integerValue])
                                         };
                [AFWebAPI_JAVA getProjectDetialWithArg:diaArg callBack:^(BOOL success, id  _Nonnull object) {
                    if (success) {
                        NSDictionary *moDic = [object objectForKey:JSON_body];
                        ProjectModel2 *model = [ProjectModel2 yy_modelWithDictionary:moDic];
                        ProjectDetailVC2 *PDVC = [ProjectDetailVC2 new];
                        PDVC.hidesBottomBarWhenPushed=YES;
                        PDVC.model = model;
                        PDVC.type = 2;
                        PDVC.delegate = weakself;
                        [weakself.navigationController pushViewController:PDVC animated:YES];
                    }
                }];
               
            }
        };
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isSelectType) {
        return;
    }
    //默认来选择项目的，进入项目从按钮进去
    NSDictionary *dic = _data[indexPath.row];
   BOOL overTime = [dic[@"overtime"] boolValue];
    if (overTime) {//过期
        [SVProgressHUD showImage:nil status:@"该项目已过拍摄时间，请选择其他项目。"];
        return ;
        }
  NSDictionary *diaArg = @{
                                 @"projectId":dic[@"projectId"],
                                 @"userId": @([[UserInfoManager getUserUID] integerValue])
                                 };
        [AFWebAPI_JAVA getProjectDetialWithArg:diaArg callBack:^(BOOL success, id  _Nonnull object) {
            if (success) {
                NSDictionary *moDic = [object objectForKey:JSON_body];
                ProjectModel2 *model = [ProjectModel2 yy_modelWithDictionary:moDic];
                self.selectModel(model);
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:@"读取项目信息失败"];
            }
        }];

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (IBAction)add:(id)sender {
    ProjectDetailVC2 *PDVC = [ProjectDetailVC2 new];
    PDVC.hidesBottomBarWhenPushed=YES;
   PDVC.delegate = self;
    PDVC.type = 1;
    [self.navigationController pushViewController:PDVC animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return _data.count;
    
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [tableView setEditing:YES animated:YES]; 此傻逼句让每个cell前端都带了一个删除红按钮
   
       NSDictionary *dic = _data[indexPath.row];
    BOOL canDel = [dic[@"canDel"] boolValue];
   if (canDel) {//可删除
            return UITableViewCellEditingStyleDelete;
        }else{
            return  UITableViewCellEditingStyleNone;
        }
        
   
}

//进入编辑模式，按下出现的删除按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"删除了%ld行",indexPath.row);
    [tableView setEditing:NO animated:YES];
    
    
    NSMutableDictionary *dicArg = [NSMutableDictionary new];
    NSString *uid = [UserInfoManager getUserUID];
    [dicArg setObject:[NSNumber numberWithInteger:[uid integerValue]] forKey:@"userId"];
   
      NSDictionary *dic = _data[indexPath.row];
    NSString *proid = [NSString stringWithFormat:@"%@",dic[@"projectId"]];
    [dicArg setObject:proid forKey:@"projectId"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [self.table hideNoDataScene];
    [AFWebAPI_JAVA delectProjectWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self pullDownToRefresh];
        }else
        {
            AF_SHOW_JAVA_ERROR
        }
    }];
    //    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"该操作不可撤销，您确定删除?"] delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    //    [sheet showInView:self.view];
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index is %ld",(long)buttonIndex);
    if (buttonIndex == 0) {//删除
        
    }else{//不删除
        
    }
}

-(void)VCReferesh
{
   // [self pullDownToRefresh];
}
- (void)onGoback
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}
@end
