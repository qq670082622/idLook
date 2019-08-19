//
//  MyAuthStep4.m
//  IDLook
//
//  Created by HYH on 2018/6/4.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyAuthSuccessVC.h"
#import "AuthSuccCellA.h"
#import "AuthSuccCellB.h"
#import "AuthBuyerVC.h"
#import "IDTypeModel.h"

@interface MyAuthSuccessVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableV;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIButton *bottomBtn;  //升级企业认证按钮
@end

@implementation MyAuthSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"实名认证"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    

    self.dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];
    [self getData];
    [self tableV];
    [self bottomBtn];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//升级成企业买家
-(void)upgradeCompany
{
    AuthBuyerVC *authVC=[[AuthBuyerVC alloc]init];
    authVC.buyType=1;
    authVC.upgradeDic=self.dic;
    authVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:authVC animated:YES];
}

-(void)getData
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dic =@{@"userid":[UserInfoManager getUserUID],
                         @"usertype":@([UserInfoManager getUserType]),
                         };
    [AFWebAPI getAuthInfoWithArg:dic callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [object objectForKey:JSON_data];
            [self.dic setDictionary:dic];
            
            //资源方
            if ([UserInfoManager getUserType]==UserTypeResourcer)
            {
                NSArray *array1 = @[@{@"title":@"真实姓名",@"desc":dic[@"name"]},
                                    @{@"title":@"出生年月",@"desc":dic[@"dateofbirth"]},
                                    @{@"title":@"性        别",@"desc":[(NSNumber *)safeObjectForKey(dic, @"sex") integerValue]==1?@"男":@"女"},
                                    @{@"title":@"国        籍",@"desc":dic[@"nationality"]},
                                    @{@"title":@"有效证件号",@"desc":dic[@"papers"]}];
                
                NSArray *array2 =@[@{@"title":@"身份证正面",@"image":dic[@"papersphotourl1"]},
                                   @{@"title":@"身份证背面",@"image":dic[@"papersphotourl2"]}];
                
                [self.dataSource addObject:@{@"CellClass":@"AuthSuccCellA",
                                             @"CellHeight":@(210),
                                             @"data":@{@"title":@"基本信息",@"data":array1}}];

                [self.dataSource addObject:@{@"CellClass":@"AuthSuccCellB",
                                             @"CellHeight":@(215),
                                             @"data":@{@"title":@"身份证/护照信息",@"data":array2}}];
                
            }
            else  //购买方
            {
                //购买方个人
                if ([UserInfoManager getUserSubType]==UserSubTypePurPersonal) {
                    NSArray *array1 = @[@{@"title":@"真实姓名",@"desc":dic[@"adminnickname"]},
                                        @{@"title":@"有效证件号",@"desc":dic[@"papers"]},
                                        @{@"title":@"所属职业",@"desc":dic[@"position"]}];
                    
                    NSArray *array2 =@[@{@"title":@"身份证/护照正面",@"image":dic[@"photourl1"]},
                                       @{@"title":@"身份证/护照背面",@"image":dic[@"photourl2"]}];
                    
                    [self.dataSource addObject:@{@"CellClass":@"AuthSuccCellA",
                                                 @"CellHeight":@(160),
                                                 @"data":@{@"title":@"基本信息",@"data":array1}}];

                    [self.dataSource addObject:@{@"CellClass":@"AuthSuccCellB",
                                                 @"CellHeight":@(215),
                                                 @"data":@{@"title":@"身份证/护照信息",@"data":array2}}];
                }
                else   //购买方企业
                {
                    //根据identity得到公司类型
                    NSInteger userType  = [dic[@"identity"] integerValue];
                    NSString *typeStr =@"";
                    NSArray *typeArray = [IDTypeModel getData];
                    for (int i=0; i<typeArray.count; i++) {
                        IDTypeStructModel *model = typeArray[i];
                        
                        for (int j=0; j<model.array.count; j++) {
                            NSString *subType = model.array[j][@"UserSubTypeName"];
                            NSInteger UserSubType = [model.array[j][@"UserSubType"] integerValue];
                            if (userType==UserSubType) {
                                if (model.array.count>1) {
                                    typeStr = [NSString stringWithFormat:@"%@(%@)",model.title,subType];
                                }
                                else
                                {
                                    typeStr = model.title;
                                }
                            }
                        }
                    }
                    
                    NSArray *array1 = @[@{@"title":@"公司名称",@"desc":dic[@"companyname"]},
                                        @{@"title":@"营业执照号",@"desc":dic[@"business"]},
                                        @{@"title":@"公司类型",@"desc":typeStr},
                                        @{@"title":@"经办人姓名",@"desc":dic[@"adminnickname"]},
                                        @{@"title":@"有效证件号",@"desc":dic[@"papers"]}];
                    
                    
                    NSArray *array2 =@[@{@"title":@"营业执照",@"image":dic[@"url"]},
                                      @{@"title":@"委托下单授权书",@"image":dic[@"proxy"]}];
                    
                    NSArray *array3 = @[@{@"title":@"身份证/护照正面",@"image":dic[@"photourl1"]},
                                        @{@"title":@"身份证/护照背面",@"image":dic[@"photourl2"]}];
                    
                    [self.dataSource addObject:@{@"CellClass":@"AuthSuccCellA",
                                                 @"CellHeight":@(210),
                                                 @"data":@{@"title":@"基本信息",@"data":array1}}];
                    
                    [self.dataSource addObject:@{@"CellClass":@"AuthSuccCellB",
                                                 @"CellHeight":@(265),
                                                 @"data":@{@"title":@"营业执照及委托下单授权书信息",@"data":array2}}];
                    
                    [self.dataSource addObject:@{@"CellClass":@"AuthSuccCellB",
                                                 @"CellHeight":@(215),
                                                 @"data":@{@"title":@"身份证/护照信息",@"data":array3}}];
                }
            }
            
            [self.tableV reloadData];

        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

-(UITableView*)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0,0.5,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableV];
        
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=Public_Background_Color;
    }
    return _tableV;
}

-(UIButton*)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] init];
        _bottomBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.view addSubview:_bottomBtn];
        _bottomBtn.backgroundColor=Public_Red_Color;
        [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).offset(-SafeAreaTabBarHeight_IphoneX);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(55);
        }];
        
        NSMutableAttributedString *title1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",@"升级成企业买家"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        NSAttributedString *title2 = [[NSAttributedString alloc] initWithString:@"(可在拍摄完成后10个工作日内支付剩余尾款)" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FED5D8"]}];
        
        [title1 appendAttributedString:title2];
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        [paraStyle setLineSpacing:5];
        paraStyle.alignment = NSTextAlignmentCenter;
        [title1 addAttributes:@{NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, title1.length)];
        [_bottomBtn setAttributedTitle:title1 forState:UIControlStateNormal];
        
        if ([UserInfoManager getUserSubType]==UserSubTypePurPersonal) {
            _bottomBtn.hidden=NO;
        }
        else
        {
            _bottomBtn.hidden=YES;
        }
        [_bottomBtn addTarget:self action:@selector(upgradeCompany) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
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
        return 55.0;
    }
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
    return [[self.dataSource[indexPath.row] objectForKey:@"CellHeight"]floatValue];;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        static NSString *identifer = @"UITableViewHeaderFooterView";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
        if(!headerView)
        {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifer];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.textColor =  [UIColor colorWithHexString:@"#666666"];
            titleLabel.font=[UIFont systemFontOfSize:14.0];
            [headerView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headerView);
                make.centerX.mas_equalTo(headerView).offset(10);
            }];
            titleLabel.text = @"实名认证已通过";
            
            UIImageView *imageV = [[UIImageView alloc]init];
            [headerView addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headerView);
                make.right.mas_equalTo(titleLabel.mas_left).offset(-5);
            }];
            imageV.image=[UIImage imageNamed:@"auth_pass"];
        }
        return headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSString *classStr = [(NSDictionary *)self.dataSource[row] objectForKey:@"CellClass"];
    NSDictionary *dic = [(NSDictionary *)self.dataSource[row] objectForKey:@"data"];

    id obj = [tableView dequeueReusableCellWithIdentifier:classStr];
    if(!obj)
    {
        obj = [[NSClassFromString(classStr) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classStr];
    }
    
    if([classStr isEqualToString:@"AuthSuccCellA"])
    {
        AuthSuccCellA *cell = (AuthSuccCellA*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        [cell reloadUIWithDic:dic];
    }
    else if ([classStr isEqualToString:@"AuthSuccCellB"])
    {
        NSArray *dataS = dic[@"data"];

        AuthSuccCellB *cell = (AuthSuccCellB*)obj;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        NSMutableArray *arr=[NSMutableArray new];
        WeakSelf(self);
        WeakSelf(cell);
        for (int i=0; i<dataS.count; i++) {
            [arr addObject:[dataS[i]objectForKey:@"image"]];
        }
        cell.LookBigPhotoWithIndex = ^(NSInteger index) {
            LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
            [lookImage showWithImageArray:arr curImgIndex:index AbsRect:weakcell.contentView.bounds];
            [weakself.navigationController pushViewController:lookImage animated:YES];
            lookImage.downPhotoBlock = ^(NSInteger index) {};
        };
        [cell reloadUIWithDic:dic];
    }
    return obj;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor whiteColor];
    }
}


@end
