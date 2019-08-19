//
//  MyAuthVC.m
//  IDFace
//
//  Created by HYH on 2018/5/14.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyAuthVC.h"
#import "AuthHeadV.h"
#import "AuthCellA.h"
#import "AuthCellB.h"
#import "AuthFootV.h"

@interface MyAuthVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIScrollView *scrollV;
@property (nonatomic,strong)AuthHeadV *headV;
@property (nonatomic,strong)NSArray *dataS;
@property (nonatomic,assign)NSInteger currStep;
@property (nonatomic,strong)NSIndexPath *photoIndexPath;
@end

@implementation MyAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"我的认证"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    self.currStep=0;
    
    self.dataS= @[@[@{@"title":@"真实姓名",@"placeholder":@"请填写身份证或护照姓名",@"isEdit":@(YES)},
                    @{@"title":@"艺名",@"placeholder":@"请填写业内昵称",@"isEdit":@(YES)},
                    @{@"title":@"出生日期",@"placeholder":@"请选择出生年月",@"isEdit":@(NO)},
                    @{@"title":@"性别",@"placeholder":@"请选择性别",@"isEdit":@(NO)},
                    @{@"title":@"国籍",@"placeholder":@"请选择国籍",@"isEdit":@(NO)},
                    @{@"title":@"语言",@"placeholder":@"请选择语言",@"isEdit":@(NO)},
                    @{@"title":@"有效证件号",@"placeholder":@"请填写身份证/护照号",@"isEdit":@(YES)}],
                  @[@{@"title":@"开户姓名",@"placeholder":@"请填写银行卡开户姓名",@"isEdit":@(YES)},
                    @{@"title":@"开户银行",@"placeholder":@"请填写开户银行名称",@"isEdit":@(YES)},
                    @{@"title":@"银行账号",@"placeholder":@"请填写开户银行账号/银行卡账号",@"isEdit":@(YES)},
                    @{@"title":@"支付宝账号",@"placeholder":@"请填写本人支付宝账号",@"isEdit":@(YES)}]];
    
    [self headV];
    [self scrollV];

}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(AuthHeadV*)headV
{
    if (!_headV) {
        _headV=[[AuthHeadV alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
        [self.view addSubview:_headV];
    }
    return _headV;
}

- (UIScrollView *)scrollV
{
    if(!_scrollV)
    {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 48, UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight-48)];
        _scrollV.pagingEnabled = NO;
        _scrollV.delegate = self;
        _scrollV.scrollEnabled = NO;
        _scrollV.backgroundColor = [UIColor clearColor];
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollV];
        _scrollV.contentSize = CGSizeMake(UI_SCREEN_WIDTH*4, 0);
        
        for (int i =0; i<4; i++) {
            UITableView *tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*i,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-SafeAreaTopHeight-48) style:UITableViewStyleGrouped];
            tableV.delegate = self;
            tableV.dataSource = self;
            tableV.tag=i;
            tableV.bounces=NO;
            tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
            tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [self.scrollV addSubview:tableV];
            tableV.estimatedRowHeight = 0;
            tableV.estimatedSectionHeaderHeight = 0;
            tableV.estimatedSectionFooterHeight = 0;
            tableV.backgroundColor=[UIColor clearColor];
            
            if (i<2) {
                AuthFootV *footV = [[AuthFootV alloc] initWithFrame:CGRectMake(0,UI_SCREEN_HEIGHT-SafeAreaTopHeight-48-100, UI_SCREEN_WIDTH, 100)];
                [footV reloadUIWithType:i];
                [tableV addSubview:footV];
                WeakSelf(self);
                footV.clickNextStep = ^{
                    [weakself didClickNextWithStep:i];
                };
                footV.clickLastStep = ^{
                    [weakself didClickLastWithStep:i];
                };
            }
        }
    }
    return _scrollV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView.tag==2 && section == 1) {
        return 100;
    }
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag<=1) {
        return 10.f;
    }
    else if (tableView.tag==2)
    {
        return 50;
    }
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag<2) {
        return 1;
    }
    else if (tableView.tag==2)
    {
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        return 7;
    }
    else if (tableView.tag==1)
    {
        return 4;
    }
    else if (tableView.tag==2)
    {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0||tableView.tag==1) {
        return 48;
    }
    return UI_SCREEN_WIDTH*(418.0/750.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag<2) {
        static NSString *identifer = @"AuthCellA";
        AuthCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuthCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
            
        }
        NSArray *array= self.dataS[tableView.tag];
        [cell reloadUIWithDic:array[indexPath.row]];
        return cell;
    }
    else if (tableView.tag<4)
    {
        static NSString *identifer = @"AuthCellB";
        AuthCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[AuthCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            WeakSelf(self);
            cell.addPhotoBlock = ^{
                weakself.photoIndexPath=indexPath;
                [weakself addCertificate];
            };
        }
        [cell reloadUIWithIndexPath:indexPath];
        return cell;
    }
    
    return nil;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==2) {
        UIView *view = [[UIView alloc] init];
        UILabel *titleLabel = [[UILabel alloc] init];
       
        titleLabel.textColor =  [UIColor colorWithHexString:@"#999999"];
        titleLabel.font=[UIFont systemFontOfSize:12.0];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.bottom.mas_equalTo(view).offset(-10);
        }];
        if (section==0) {
             titleLabel.text = @"请上传您身份证/护照的正反面，用于实名认证";
        }
        else
        {
             titleLabel.text = @"请上传您银行卡的正反面，用于实名认证";
        }
        return view;
    }
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView.tag==2 && section==1) {
        AuthFootV *view = [[AuthFootV alloc] init];
        [view reloadUIWithType:2];
        WeakSelf(self);
        view.clickNextStep = ^{
            [weakself didClickNextWithStep:2];
        };
        view.clickLastStep = ^{
            [weakself didClickLastWithStep:2];
        };
        return view;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark--
-(CustomTableV*)getCurrentTableView:(NSInteger)tag
{
    CustomTableV *tableV=[self.scrollV viewWithTag:tag];
    return tableV;
}


#pragma mark----Action
//上一步
-(void)didClickLastWithStep:(NSInteger)step
{
    self.currStep--;
    [self.scrollV setContentOffset:CGPointMake(UI_SCREEN_WIDTH*self.currStep, 0) animated:NO];
    [self.headV reloadWithStep:self.currStep];
}

//
-(void)didClickNextWithStep:(NSInteger)step
{
    //下一步
    if (step<2) {
        self.currStep++;
    }
    //提交审核
    else if(step==2)
    {
        
    }
    [self.scrollV setContentOffset:CGPointMake(UI_SCREEN_WIDTH*self.currStep, 0) animated:NO];
    [self.headV reloadWithStep:self.currStep];

}


//添加银行卡，证件照
- (void)addCertificate
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{}];
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate


-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        AuthCellB *cell = [[self getCurrentTableView:self.currStep] cellForRowAtIndexPath:self.photoIndexPath];
        cell.image=image;
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


@end
