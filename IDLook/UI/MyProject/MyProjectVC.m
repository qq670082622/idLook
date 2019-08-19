//
//  MyProjectVC.m
//  IDLook
//
//  Created by 吴铭 on 2018/12/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyProjectVC.h"
#import "ProjectDetailVC.h"
#import "ProjectModel.h"
#import "ProjectCell.h"
@interface MyProjectVC ()<UITableViewDelegate,UITableViewDataSource,ProjectDetailVCDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet CustomTableV *screenTable;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)newProject:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *progress;
@property(nonatomic,assign)NSInteger selectType;
- (IBAction)auditionAction:(id)sender;
- (IBAction)screenAction:(id)sender;
@property(nonatomic,strong)NSMutableArray *auditionArr;
@property(nonatomic,strong)NSMutableArray *screenArr;
@end

@implementation MyProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectType=0;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"我的项目"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    // Do any additional setup after loading the view from its nib.
    [_screenTable addHeaderWithTarget:self action:@selector(pullDownToRefresh)];
  self.screenTable.animatedStyle = TABTableViewAnimationStart;

   [self pullDownToRefresh];
}
-(void)pullDownToRefresh
{
 //   [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
   
   NSMutableDictionary *dicArg = [NSMutableDictionary new];
    NSString *uid = [UserInfoManager getUserUID];
    [dicArg setObject:[NSNumber numberWithInteger:[uid integerValue]] forKey:@"userid"];
    if (_selectType==0) {
      //  [self.screenArr removeAllObjects];
        [dicArg setObject:[NSNumber numberWithInteger:1] forKey:@"type"];
    }else{
       // [self.auditionArr removeAllObjects];
         [dicArg setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
    }

    [AFWebAPI getProjectInfoWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
             self.screenTable.animatedStyle = TABTableViewAnimationEnd;
        
            NSArray *array =[object objectForKey:JSON_data];
            if (_selectType==0) {
                [self.screenArr removeAllObjects];
               
            }else{
                [self.auditionArr removeAllObjects];
               
            }
         for (NSDictionary *proj in array) {
                ProjectModel *model = [ProjectModel yy_modelWithDictionary:proj];
                [self.screenTable hideNoDataScene];
                if (_selectType==0) {//试镜
                  [self.screenArr addObject:model];
                  }else{
                    [self.auditionArr addObject:model];
                }
            }
            CGFloat cellHeights = 0;
            if (_selectType == 0) {
                cellHeights = 93*_screenArr.count;
               
               }else{
                cellHeights = 93*_auditionArr.count;
              }
        
            self.screenTable.tableFooterView = [UIView new];
            [self.screenTable headerEndRefreshing];
           
            if (_selectType==0 && _screenArr.count==0) {//试镜
                [self.screenTable showWithNoDataType:NoDataTypeProject];
            
            }else if(_selectType==1 && _auditionArr.count==0){
                [self.screenTable showWithNoDataType:NoDataTypeProject];
              
            }
            
            if (_selectType==0 ) {
                 [self.screenTable reloadData];
            }
            if (_selectType==1) {
                [self.screenTable reloadData];
            }
            
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
    ProjectCell *cell = [ProjectCell cellWithTableView:tableView];
     if (tableView.animatedStyle != TABTableViewAnimationStart) {
 __block   ProjectModel *cellModel = [ProjectModel new];
    if (_selectType==0) {
        cellModel = _screenArr[indexPath.row];
        cell.model = cellModel;
    }else{
        cellModel = _auditionArr[indexPath.row];
        cell.model = cellModel;
    }
    cell.btnClicked = ^(NSString * _Nonnull clickType) {
        if ([clickType isEqualToString:@"查看"]) {
            ProjectDetailVC *PDVC = [ProjectDetailVC new];
            PDVC.hidesBottomBarWhenPushed=YES;
            if (_selectType==1) {
                PDVC.isAudition = YES;
               }
             PDVC.model = cellModel;
            PDVC.type = 3;
           [weakself.navigationController pushViewController:PDVC animated:YES];
        }else if ([clickType isEqualToString:@"编辑"]){
            ProjectDetailVC *PDVC = [ProjectDetailVC new];
            PDVC.hidesBottomBarWhenPushed=YES;
            if (_selectType==1) {
                PDVC.isAudition = YES;
                }
            PDVC.model = cellModel;
            PDVC.type = 2;
            PDVC.delegate = weakself;
            [weakself.navigationController pushViewController:PDVC animated:YES];
        }
    };
     }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

- (IBAction)newProject:(id)sender {
    ProjectDetailVC *PDVC = [ProjectDetailVC new];
     PDVC.hidesBottomBarWhenPushed=YES;
    if (_selectType==0) {
        PDVC.isAudition = NO;
    }else{
        PDVC.isAudition = YES;
    }
    PDVC.delegate = self;
    PDVC.type = 1;
    [self.navigationController pushViewController:PDVC animated:YES];
}

- (IBAction)auditionAction:(id)sender {
    self.selectType = 1;
    
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
        self.progress.transform = CGAffineTransformMakeTranslation(UI_SCREEN_WIDTH/2, 0);
     //   self.scrollView.contentOffset = CGPointMake(UI_SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        
    }];
//    if (_auditionArr.count==0) {
//     [self.screenTable showWithNoDataType:NoDataTypeProject];
//    }else{
//
//         [self.screenTable hideNoDataScene];
//    }
//    [self.screenTable reloadData];
     [self pullDownToRefresh];
}

- (IBAction)screenAction:(id)sender {
    self.selectType = 0;
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:0 animations:^{
        self.progress.transform = CGAffineTransformMakeTranslation(0, 0);
      //   self.scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        
    }];
//    if (_screenArr.count==0) {
//    [self.screenTable showWithNoDataType:NoDataTypeProject];
//    }else{
//
//        [self.screenTable hideNoDataScene];
//    }
//    [self.screenTable reloadData];
    [self pullDownToRefresh];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectType==0) {
        return _screenArr.count;
    }else{
        return _auditionArr.count;
    }
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
    if (_selectType==0) {//试镜
        ProjectModel *delModel = _screenArr[indexPath.row];
        if (delModel.delstatus == 1) {//可删除
              return UITableViewCellEditingStyleDelete;
        }else{
          return  UITableViewCellEditingStyleNone;
        }
        
    }else{//拍摄
            ProjectModel *delModel = _auditionArr[indexPath.row];
            if (delModel.delstatus == 1) {//可删除
                return UITableViewCellEditingStyleDelete;
            }else{
                return  UITableViewCellEditingStyleNone;
            }
      }
}

//进入编辑模式，按下出现的删除按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"删除了%ld行",indexPath.row);
    [tableView setEditing:NO animated:YES];
  
 
    NSMutableDictionary *dicArg = [NSMutableDictionary new];
    NSString *uid = [UserInfoManager getUserUID];
    [dicArg setObject:[NSNumber numberWithInteger:[uid integerValue]] forKey:@"userid"];
    if (_selectType==0) {
        ProjectModel *delModel = _screenArr[indexPath.row];
        [dicArg setObject:[NSNumber numberWithInteger:delModel.id] forKey:@"creativeid"];
        [dicArg setObject:[NSNumber numberWithInteger:1] forKey:@"type"];
    }else{
        ProjectModel *delModel = _auditionArr[indexPath.row];
        [dicArg setObject:[NSNumber numberWithInteger:delModel.id] forKey:@"creativeid"];
        [dicArg setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
    }
       [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [self.screenTable hideNoDataScene];
    [AFWebAPI delectProjectWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            [self pullDownToRefresh];
            }else
        {
            AF_SHOW_RESULT_ERROR
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

-(void)VCRefereshWithProjectModel:(ProjectModel *)projectModel
{
    [self pullDownToRefresh];
}
- (void)onGoback
{
    
     [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSMutableArray *)auditionArr
{
    if (!_auditionArr) {
        self.auditionArr = [NSMutableArray new];
    }
    return _auditionArr;
}

-(NSMutableArray *)screenArr
{
    if (!_screenArr) {
        self.screenArr = [NSMutableArray new];
    }
    return _screenArr;
}
// 全面屏手机统一进入这个方法适配
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
//    [self. mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-34);
//    }];
//    // self.tableV.frame = CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-84);
//    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.addBtn.mas_top);
//    }];
    self.addBtn.y-=34;
    self.screenTable.height-=34;
}
@end
