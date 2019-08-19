//
//  MyCertificate.m
//  IDLook
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyCertificateVC.h"
#import "MyCertificateCell.h"
#import "UploadCertifVC.h"
#import "LookCertificateVC.h"
#import "CertificateM.h"

@interface MyCertificateVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataS;
@end

@implementation MyCertificateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"我的授权书"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.dataS=[[NSMutableArray alloc]initWithCapacity:0];
    [self refreshData];
    [self tableV];
}


-(void)refreshData
{
    
    [self.dataS removeAllObjects];
    
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];

    NSDictionary *dicArg = @{@"userid":[UserInfoManager getUserUID]};
    
    [AFWebAPI getCertficiInfoWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array = [object objectForKey:JSON_data];
            
            for (int i = 0; i<4; i++) {
                CertificateM *model = [[CertificateM alloc]init];
                model.type=i;
                model.state=-1;
                for (NSDictionary *dic in array) {
                    if ([dic[@"authorizationtype"]integerValue]==i)
                    {
                        model.isExist=YES;
                        model.imageUrl = dic[@"authorizationimgurl"];
                        model.state = [dic[@"state"]integerValue];
                    }
                }
                [self.dataS addObject:model];
            }
            [self.tableV reloadData];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.layer.borderColor=[UIColor colorWithHexString:@"#F7F7F7"].CGColor;
        _tableV.layer.borderWidth=0.5;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
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
    return 23.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataS count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image  = [UIImage imageNamed:@"certificate_bg1"];
    return image.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"MyCertificateCell";
    MyCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[MyCertificateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    [cell reloadUIWithModel:self.dataS[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CertificateM *model = self.dataS[indexPath.row];
    
    if (model.isExist) {
        LookCertificateVC *lookVC=[[LookCertificateVC alloc]init];
        lookVC.model=model;
        WeakSelf(self);
        lookVC.uploadRefreshUI = ^{
            [weakself refreshData];
        };
        [self.navigationController pushViewController:lookVC animated:YES];
    }
    
    else
    {
        UploadCertifVC *uploadVC=[[UploadCertifVC alloc]init];
        uploadVC.model=model;
        WeakSelf(self);
        uploadVC.uploadRefreshUIWithUrl = ^(NSString *imageUrl) {
            [weakself refreshData];
        };
        [self.navigationController pushViewController:uploadVC  animated:YES];
    }
}



@end
