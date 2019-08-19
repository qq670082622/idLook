//
//  AboutVC.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "AboutVC.h"
#import "SettingMainCell.h"
#import "PublicWebVC.h"

@interface AboutVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"关于脸探肖像"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    [self tableV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIView *)tableHeaderView
{
    
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,0,180}];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image=[UIImage imageNamed:@"app_icon"];
    [view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset(37);
    }];

    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"脸探肖像 %@",Current_BundleVersion];
    label.textColor = Public_Text_Color;
    label.font = [UIFont systemFontOfSize:15.0];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(icon.mas_bottom).offset(12);
    }];
    return view;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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
        _tableV.tableHeaderView=[self tableHeaderView];
    }
    return _tableV;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"SettingMainCell";
    SettingMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[SettingMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    NSArray *array = @[@"为脸探肖像评分",@"公司介绍"];
    NSArray *descArr = @[@"",@"",@""];

    [cell reloadUIWithTitle:array[indexPath.row] withDesc:descArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",STORE_APPID]];
        [[UIApplication sharedApplication] openURL:url];
    }
    if (indexPath.row==1) {
        [self showProtocol];
    }
    
}

- (void)showProtocol
{
    PublicWebVC * webVC = [[PublicWebVC alloc] initWithTitle:@"公司介绍" url:@"http://www.idlook.com/public/about_us.html"];
    [self.navigationController pushViewController:webVC animated:YES];

}

@end