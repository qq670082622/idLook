//
//  ProjectChooseVC.m
//  IDLook
//
//  Created by Mr Hu on 2019/1/3.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import "ProjectChooseVC.h"
#import "OrderPJChooseCell.h"
#import "ProjectDetailVC.h"

@interface ProjectChooseVC ()<UITableViewDelegate,UITableViewDataSource,ProjectDetailVCDelegate>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)UIButton *bottomBtn;  //确定
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation ProjectChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    
    if (self.projectType==1) {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"试镜项目"]];
    }
    else if (self.projectType==2)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"拍摄项目"]];
    }
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"新建项目" Target:self action:@selector(addProject)]]];
    
    self.dataSource = [NSMutableArray new];
    [self tableV];
    [self bottomBtn];
    [self getData];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//新建项目
-(void)addProject
{
    ProjectDetailVC *PDVC = [ProjectDetailVC new];
    if (self.projectType==1) {
        PDVC.isAudition = NO;
    }else{
        PDVC.isAudition = YES;
    }
    PDVC.delegate=self;
    PDVC.type = 1;
    [self.navigationController pushViewController:PDVC animated:YES];
}


-(void)getData
{
    [self.dataSource removeAllObjects];
    
    [SVProgressHUD show];
    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID],
                             @"type":@(self.projectType)};
    [AFWebAPI getProjectInfoWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array = [object objectForKey:JSON_data];
            for (int i=0; i<array.count; i++) {
                ProjectModel *model = [ProjectModel yy_modelWithDictionary:array[i]];

                if ([model.projectid isEqualToString:self.projectModel.projectid]) {
                    model.isChoose=YES;
                }
                
                [self.dataSource addObject:model];
            }
            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTabBarHeight_IphoneX-48) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableV.separatorColor =Public_LineGray_Color;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
    }
    return _tableV;
}

-(UIButton*)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] init];
        [self.view addSubview:_bottomBtn];
        _bottomBtn.backgroundColor=Public_Red_Color;
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
        [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).offset(-SafeAreaTabBarHeight_IphoneX);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(48);
        }];
        [_bottomBtn addTarget:self action:@selector(conformAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

-(void)conformAction
{
    ProjectModel *model=[ProjectModel new];
    for (int i=0; i<self.dataSource.count; i++) {
        ProjectModel *pModel = self.dataSource[i];
        if (pModel.isChoose==YES) {
            model=pModel;
        }
    }
    
    if (model.isChoose==NO) {
        [SVProgressHUD showImage:nil status:@"请选择项目"];
        return;
    }
    
    if (model.isChoose==YES) {
        if (self.selectProjectModelBlock) {
            self.selectProjectModelBlock(model);
        }
        [self onGoback];
    }
    
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"OrderPJChooseCell";
    OrderPJChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[OrderPJChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    ProjectModel *model = self.dataSource[indexPath.row];
    [cell reloadUIWithModel:model];
    WeakSelf(self);
    cell.selectProjectBlock = ^{
        [weakself reloadTableWithRow:indexPath.row];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProjectModel *model = self.dataSource[indexPath.row];

    ProjectDetailVC *PDVC = [ProjectDetailVC new];
    if (self.projectType==1) {
        PDVC.isAudition = NO;
    }
    else
    {
        PDVC.isAudition = YES;
    }
    PDVC.model = model;
    PDVC.delegate=self;
    if (model.editstatus==1) {
        PDVC.type = 2;
    }
    else
    {
        PDVC.type = 3;
    }
    [self.navigationController pushViewController:PDVC animated:YES];
}

//选中一条刷新数据
-(void)reloadTableWithRow:(NSInteger)row
{
    for (int i=0; i<self.dataSource.count; i++) {
        ProjectModel *model = self.dataSource[i];
        if (i==row) {
            model.isChoose=YES;
        }
        else
        {
            model.isChoose=NO;
        }
    }
    [self.tableV reloadData];
}

#pragma mark---ProjectDetailVCDelegate
-(void)VCRefereshWithProjectModel:(ProjectModel *)projectModel
{
    [self getData];
    
//    if (self.selectProjectModelBlock) {
//        self.selectProjectModelBlock(projectModel);
//    }
//    [self onGoback];
}

@end
