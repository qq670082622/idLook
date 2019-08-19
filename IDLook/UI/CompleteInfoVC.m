
//
//  CompleteInfoVC.m
//  IDLook
//
//  Created by HYH on 2018/8/29.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "CompleteInfoVC.h"
#import "RegistCellA.h"
#import "CustTableViewCell.h"
#import "RegionChooseVC.h"
#import "PublicPickerView.h"
#import "UploadHeadVC.h"
#import "UploadPersonBGVC.h"
#import "RootTabbarVC.h"
#import "EditStructM.h"
#import "CenterCustomCell.h"
#import "BirthSelectV.h"
#import "CountryChooseVC.h"

@interface CompleteInfoVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIImage *head;
@property(nonatomic,strong)UIImage *iconBG;
@end

@implementation CompleteInfoVC
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"完善个人资料"]];
    
    NSString *occouption=@"";
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"occupationType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if ([UserInfoManager getUserOccupation] == [dic[@"attrid"] integerValue]) {
            occouption=dic[@"attrname"];
        }
    }
    
    NSString *sex = @"";
    if ([UserInfoManager getUserSex]==1) {
        sex=@"男";
    }
    else if ([UserInfoManager getUserSex]==2)
    {
        sex=@"女";
    }
    
    self.dataSource=[[NSMutableArray alloc]initWithCapacity:0];
    
    NSArray *array = @[@[@{@"title":@"",@"content":@"",@"placeholder":@"",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeOther)}],
                       @[@{@"title":@"所在地",@"content":[UserInfoManager getUserRegion],@"placeholder":@"请选择所在地",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeRegion)}],
                       @[@{@"title":@"真实姓名",@"content":[UserInfoManager getUserRealName],@"placeholder":@"请填写真实姓名",@"isShowArrow":@(NO),@"IsMustInput":@(NO),@"type":@(UserInfoTypeRealName)},
                         @{@"title":@"出生日期",@"content":[UserInfoManager getUserBirth],@"placeholder":@"请选择出生日期",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeBirth)},
                         @{@"title":@"性别",@"content":sex,@"placeholder":@"请选择性别",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeSex)},
                         @{@"title":@"国籍",@"content":[UserInfoManager getUserNationality],@"placeholder":@"请选择国籍",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeNationtitly)},
                         @{@"title":@"职业",@"content":occouption,@"placeholder":@"请选择职业",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeOccupation)},
                         ]];
    
    for (int i =0; i<array.count; i++) {
        NSArray *Arr = array[i];
        NSMutableArray *sec = [NSMutableArray new];
        for (int j=0; j<Arr.count; j++) {
            EditStructM *model = [[EditStructM alloc]initWithDic:Arr[j]];
            [sec addObject:model];
        }
        [self.dataSource addObject:sec];
    }
    
    [self reloadMasteryDataWithContent:occouption];
    [self getHead];
    
    [self tableV];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
}

//获取头像
-(void)getHead
{
    NSURL *URL = [NSURL URLWithString:[UserInfoManager getUserHead]];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:URL completion:^(BOOL isInCache) {
        if(isInCache)
        {
            UIImage *image = nil;
            image =[[manager imageCache] imageFromMemoryCacheForKey:URL.absoluteString];
            if(image)
            {
                self.head=image;
            }
            else
            {
                image = [[manager imageCache] imageFromDiskCacheForKey:URL.absoluteString];
                if(image)
                {
                    self.head=image;
                }
            }
            [self.tableV reloadData];
        }
        else
        {
            [manager downloadImageWithURL: URL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if(image)
                {
                    self.head=image;
                }
                else
                {
                }
                [self.tableV reloadData];
            }];
        }
    }];
}

-(TouchTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[TouchTableV alloc] initWithFrame:CGRectMake(0,0.5,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.touchDelegate=self;
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
        _tableV.tableFooterView=[self footView];
    }
    return _tableV;
}

-(UIView*)footView
{
    UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 108)];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor=Public_Red_Color;
    commitBtn.layer.cornerRadius=5.0;
    commitBtn.layer.masksToBounds=YES;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [footV addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footV);
        make.left.mas_equalTo(footV).offset(15);
        make.centerY.mas_equalTo(footV);
        make.height.mas_equalTo(48);
    }];
    [commitBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    return footV;
}

//确认
-(void)confirmAction
{
    for(int i=1; i<self.dataSource.count; i++) {
        NSMutableArray *sec = self.dataSource[i];
        for (int j=0; j<sec.count; j++) {
            EditStructM *model = sec[j];
            if (model.content.length==0) {
                [SVProgressHUD showImage:nil status:@"请把资料填写完整"];
                return;
            }
        }

    }
    
    EditStructM *model1 = self.dataSource[1][0];
    
    EditStructM *model2 = self.dataSource[2][0];
    EditStructM *model3 = self.dataSource[2][1];
    EditStructM *model4 = self.dataSource[2][2];
    EditStructM *model5 = self.dataSource[2][3];
    EditStructM *model6 = self.dataSource[2][4];

    
    NSInteger occupation=0;
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"occupationType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if ([dic[@"attrname"] isEqualToString:model6.content]) {
            occupation = [dic[@"attrid"] integerValue];
        }
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dic =@{@"userid":[UserInfoManager getUserUID],
                            @"region":model1.content,
                            @"realname":model2.content,
                            @"birth":model3.content,
                            @"sex":[model4.content isEqualToString:@"男"]?@(1):@(2),
                            @"nationality":model5.content,
                            @"occupation":@(occupation),
                            };
    
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
    NSMutableDictionary *infoDic = [[NSMutableDictionary alloc]init];
    if (self.head) {
        [infoDic setObject:self.head forKey:@"head"];
    }
    if (self.iconBG) {
        [infoDic setObject:self.iconBG forKey:@"background"];
    }
    if (occupation==1&&[[self.dataSource lastObject]count]==6) {
        EditStructM *model7 = self.dataSource[2][5];
        
        NSInteger mastery=0;
        NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"masteryType"];
        for (int i=0; i<array1.count; i++) {
            NSDictionary *dic = array1[i];
            if ([dic[@"attrname"] isEqualToString:model7.content]) {
                mastery = [dic[@"attrid"] integerValue];
            }
        }
        [dicArg setObject:@(mastery) forKey:@"mastery"];
    }
    
    [AFWebAPI modifMyotherInfoWithArg:dicArg DataDic:infoDic callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"资料已完善"];
            NSDictionary *dic = [object objectForKey:JSON_data];
            UserInfoM *uinfo = [[UserInfoM alloc] initWithDic:dic];
            [UserInfoManager setUserLoginfo:uinfo];

            AppDelegate *dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//            [dele showRootVC];
            
            RootTabbarVC *tabVC = [[RootTabbarVC alloc] init];
            dele.window.rootViewController = tabVC;
            [dele.window reloadInputViews];
            [dele.window makeKeyAndVisible];
            [tabVC skipMineWithIndex:3];
            [UserInfoManager setAuthBottomShow:YES];
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];

    
}


#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 42.f;
    }
    return .1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return UI_SCREEN_WIDTH*0.66;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *identifer = @"RegistCellA";
        RegistCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[RegistCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        WeakSelf(self);
        cell.uploadBGBlock = ^{
            [weakself uploadBG];
        };
        cell.uploadHeadBlock = ^{
            [weakself uploadHead];
        };
        [cell reloadUIHead:self.head withBG:self.iconBG withheadUrl:@"" withBGUrl:@"" withType:0 isShowState:NO];
        return cell;
    }
    else
    {
        static NSString *identifer = @"CenterCustomCell";
        CenterCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[CenterCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        EditStructM *model = self.dataSource[indexPath.section][indexPath.row];
        [cell reloadUIWithModel:model];
        WeakSelf(self);
        cell.BeginEdit = ^{
            weakself.indexPath=indexPath;
        };
        cell.textFieldChangeBlock = ^(NSString *text) {
            model.content=text;
        };
        return cell;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        static NSString *identifer = @"UITableViewHeaderFooterView";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
        if(!headerView)
        {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifer];
            [headerView.backgroundView setBackgroundColor:[UIColor clearColor]];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.textColor =  [UIColor colorWithHexString:@"#FF6600"];
            titleLabel.tag=100;
            titleLabel.font=[UIFont systemFontOfSize:14];
            [headerView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headerView).offset(0);
                make.centerX.mas_equalTo(headerView).offset(0);
            }];
            
            UIImageView *imageV = [[UIImageView alloc]init];
            imageV.image =[UIImage imageNamed:@"LR_promt"];
            imageV.tag=101;
            [headerView addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headerView).offset(0);
                make.right.mas_equalTo(titleLabel.mas_left).offset(-5);
            }];
        }
        UILabel *lab = (UILabel*)[headerView viewWithTag:100];
        lab.text = @"以下信息填写后不可更改，请准确填写。";
        
        return headerView;
    }
    else
    {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EditStructM *model = self.dataSource[indexPath.section][indexPath.row];
    WeakSelf(self);
    if (model.type==UserInfoTypeRegion) {  //所在地
        RegionChooseVC *regionVC=[[RegionChooseVC alloc]init];
        [self.navigationController pushViewController:regionVC animated:YES];
        regionVC.selectCity = ^(NSString *city) {
            model.content=city;
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
    else if (model.type==UserInfoTypeOccupation||model.type==UserInfoTypeSex || model.type==UserInfoTypeMastery)  //职业
    {
        PublicPickerView *pickerV = [[PublicPickerView alloc] init];
        pickerV.title=model.title;
        pickerV.didSelectBlock = ^(NSString *select) {
            model.content=select;
            if (model.type==UserInfoTypeOccupation) {
                [weakself reloadMasteryDataWithContent:select];
            }
            [weakself.tableV reloadData];
        };
        if (model.type==UserInfoTypeOccupation) {
            [pickerV showWithPickerType:PickerTypeOccupation withDesc:model.content];
        }
        else if (model.type==UserInfoTypeSex)
        {
            [pickerV showWithPickerType:PickerTypeSex withDesc:model.content];
        }
        else if (model.type==UserInfoTypeNationtitly)
        {
            [pickerV showWithPickerType:PickerTypeNationality withDesc:model.content];
        }
        else if (model.type==UserInfoTypeMastery)
        {
            [pickerV showWithPickerType:PickerTypeMastery withDesc:model.content];
        }
    }
    else if (model.type==UserInfoTypeBirth)
    {
        BirthSelectV *birthV = [[BirthSelectV alloc] init];
        birthV.didSelectDate = ^(NSString *dateStr){
            model.content=dateStr;
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [birthV showWithString:model.content withType:DateTypeDay];
    }
    else if ( model.type==UserInfoTypeNationtitly )
    {
        CountryChooseVC *countryVC=[[CountryChooseVC alloc]init];
        [self.navigationController pushViewController:countryVC animated:YES];
        countryVC.selectCountry = ^(NSString *city) {
            model.content=city;
            [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
}

//是否显示专精一栏
-(void)reloadMasteryDataWithContent:(NSString*)content
{
    NSInteger occupation=0;
    NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"occupationType"];
    for (int i=0; i<array1.count; i++) {
        NSDictionary *dic = array1[i];
        if ([dic[@"attrname"] isEqualToString:content]) {
            occupation = [dic[@"attrid"] integerValue];
        }
    }
    
    NSMutableArray *sec = [self.dataSource lastObject];
    if (occupation==1) {
        if (sec.count==5)
        {
            NSDictionary *dic=@{@"title":@"专精",@"content":@"",@"placeholder":@"请选择专精",@"isShowArrow":@(YES),@"IsMustInput":@(NO),@"type":@(UserInfoTypeMastery)};
            EditStructM *model = [[EditStructM alloc]initWithDic:dic];
            [sec addObject:model];
        }
    }
    else
    {
        if (sec.count==6) {
            [sec removeLastObject];
        }
    }
}

//上传头像
-(void)uploadHead
{
    UploadHeadVC *uploadVC=[[UploadHeadVC alloc]init];
    WeakSelf(self);
    uploadVC.addHeadBlock = ^(UIImage *image) {
        weakself.head=image;
        [weakself.tableV reloadData];
    };
    [self.navigationController pushViewController:uploadVC animated:YES];
}

//上传背景图
-(void)uploadBG
{
    UploadPersonBGVC *uploadVC=[[UploadPersonBGVC alloc]init];
    WeakSelf(self);
    uploadVC.addHeadBGBlock = ^(UIImage *image) {
        weakself.iconBG=image;
        [weakself.tableV reloadData];
    };
    [self.navigationController pushViewController:uploadVC animated:YES];
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark--keyboard Noti
- (void)keyboardFrameWillChange:(NSNotification*)notification
{
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //当前Cell在屏幕中的坐标值
    CGRect rectInTableView = [self.tableV rectForRowAtIndexPath:self.indexPath];
    CGRect cellRect = [self.tableV convertRect:rectInTableView toView:[self.tableV superview]];
    
    NSLog(@"--%@--%@",NSStringFromCGRect(rectInTableView),NSStringFromCGRect(cellRect));
    
    if (rect.origin.y-120-cellRect.origin.y<0) {
        [self.tableV setContentOffset:CGPointMake(0,-rect.origin.y+cellRect.origin.y+cellRect.size.height+120+self.tableV.contentOffset.y) animated:YES];
    }
    else
    {
        //        [self.tableV setContentOffset:CGPointMake(rectInTableView.origin.x, rectInTableView.origin.y) animated:YES];
    }
}


@end
