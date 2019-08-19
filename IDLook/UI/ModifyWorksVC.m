//
//  ModifyWorksVC.m
//  IDLook
//
//  Created by HYH on 2018/6/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ModifyWorksVC.h"
#import "UploadWorksCellA.h"
#import "ModifyWorksCellA.h"
#import "ModifyWorksCellB.h"
#import "VideoPlayer.h"
#import "WorkTypeSelectV.h"
#import "LookBigImageVC.h"

@interface ModifyWorksVC ()<UITableViewDelegate,UITableViewDataSource,TableVTouchDelegate>
{
    NSIndexPath *_indexPath;
    VideoPlayer *_player;
    CGRect _currentPlayCellRect;
}
@property(nonatomic,strong)TouchTableV *tableV;
@property(nonatomic,strong)NSMutableArray *dataS;
@end

@implementation ModifyWorksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightDefaultButtionWithTitle:@"修改" Target:self action:@selector(modifyAction)]]];
    
    if (self.model.workType==WorkTypePerformance) {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改试戏作品"]];
        
        self.dataS = [[NSMutableArray alloc]initWithArray:@[@{@"title":@"",@"content":@"",@"placeholder":@"",@"isEdit":@(YES)},
                                                            @{@"title":@"作品标题",@"content":self.model.title,@"placeholder":@"请输入作品标题",@"isEdit":@(YES)},
                                                            @{@"title":@"作品类型",@"content":self.model.type,@"placeholder":@"请选择作品类型",@"isEdit":@(NO)},
                                                            @{@"title":@"作品关键词",@"content":[self.model.keyword stringByReplacingOccurrencesOfString:@"|" withString:@"、"],@"placeholder":@"请选择作品关键词",@"isEdit":@(NO)}]];
        if ([UserInfoManager getUserMastery]==2) {
            NSString *role = @"";
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if (self.model.role == [dic[@"attrid"] integerValue]) {
                    role = dic[@"attrname"];
                }
            }
            [self.dataS addObject:@{@"title":@"作品角色",@"content":role,@"placeholder":@"请选择作品角色",@"isEdit":@(NO)}];
        }
        
    }
    else if (self.model.workType==WorkTypePastworks)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改过往作品"]];
        self.dataS = [[NSMutableArray alloc]initWithArray:@[@{@"title":@"",@"content":@"",@"placeholder":@"",@"isEdit":@(YES)},
                                                            @{@"title":@"作品标题",@"content":self.model.title,@"placeholder":@"请输入作品标题",@"isEdit":@(YES)},
                                                            @{@"title":@"作品类型",@"content":self.model.type,@"placeholder":@"请选择作品类型",@"isEdit":@(NO)},
                                                            @{@"title":@"作品关键词",@"content":[self.model.keyword stringByReplacingOccurrencesOfString:@"|" withString:@"、"],@"placeholder":@"请选择作品关键词",@"isEdit":@(NO)}]];
        
        if ([UserInfoManager getUserMastery]==2) {
            NSString *role = @"";
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if (self.model.role == [dic[@"attrid"] integerValue]) {
                    role = dic[@"attrname"];
                }
            }
            [self.dataS addObject:@{@"title":@"作品角色",@"content":role,@"placeholder":@"请选择作品角色",@"isEdit":@(NO)}];
        }

    }
    else if (self.model.workType==WorkTypeIntroduction)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改自我介绍"]];
        self.dataS = [[NSMutableArray alloc]initWithArray:@[@{@"title":@"",@"content":@"",@"placeholder":@"",@"isEdit":@(YES)},
                                                            @{@"title":@"形象类型",@"content":self.model.type,@"placeholder":@"请选择形象类型",@"isEdit":@(NO)},
                                                            @{@"title":@"形象关键词",@"content":[self.model.keyword stringByReplacingOccurrencesOfString:@"|" withString:@"、"],@"placeholder":@"请选择形象关键词",@"isEdit":@(NO)}]];
    }
    else if (self.model.workType==WorkTypeMordCard)
    {
        if ([UserInfoManager getUserMastery]==2) {
            [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改剧照"]];
            NSString *role = @"";
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if (self.model.role == [dic[@"attrid"] integerValue]) {
                    role = dic[@"attrname"];
                }
            }
            
            self.dataS = [[NSMutableArray alloc]initWithArray:@[@{@"title":@"",@"content":@"",@"placeholder":@"",@"isEdit":@(YES)},
                                                                @{@"title":@"剧照类型",@"content":self.model.type,@"placeholder":@"请选择剧照类型",@"isEdit":@(NO)},
                                                                @{@"title":@"剧照关键词",@"content":[self.model.keyword stringByReplacingOccurrencesOfString:@"|" withString:@"、"],@"placeholder":@"请选择剧照关键词",@"isEdit":@(NO)},
                                                                @{@"title":@"剧照角色",@"content":role,@"placeholder":@"请选择剧照角色",@"isEdit":@(NO)},
                                                                ]];
        }
        else
        {
            [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"修改模特卡"]];
            self.dataS = [[NSMutableArray alloc]initWithArray:@[@{@"title":@"",@"content":@"",@"placeholder":@"",@"isEdit":@(YES)},
                                                                @{@"title":@"形象类型",@"content":self.model.type,@"placeholder":@"请选择形象类型",@"isEdit":@(NO)},
                                                                @{@"title":@"形象关键词",@"content":[self.model.keyword stringByReplacingOccurrencesOfString:@"|" withString:@"、"],@"placeholder":@"请选择形象关键词",@"isEdit":@(NO)}]];
        }
    }
    
    [self tableV];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player destroyPlayer];
    _player=nil;
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)modifyAction
{
    
    if (self.model.workType==WorkTypePerformance) {  //修改表演类型
        NSDictionary *dic1 = self.dataS[1];
        NSDictionary *dic2 = self.dataS[2];
        NSDictionary *dic3 = self.dataS[3];

        if ([dic1[@"content"]length]==0) {
            [SVProgressHUD showImage:nil status:dic1[@"placeholder"]];
            return;
        }
        
        if ([dic2[@"content"]length]==0) {
            [SVProgressHUD showImage:nil status:dic2[@"placeholder"]];
            return;
        }
        
        if ([dic3[@"content"]length]==0) {
            [SVProgressHUD showImage:nil status:dic3[@"placeholder"]];
            return;
        }
        
        NSDictionary *dic = @{@"creativeid":self.model.creativeid,
                                 @"type":@(1),
                                 @"title":dic1[@"content"],
                                 @"videotype":dic2[@"content"],
                                 @"keyword":[dic3[@"content"] stringByReplacingOccurrencesOfString:@"、" withString:@"|"]};
        NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        if ([UserInfoManager getUserMastery]==2) {
            NSDictionary *dic4 = self.dataS[4];
            
//            if ([dic4[@"content"]length]==0) {
//                [SVProgressHUD showImage:nil status:dic4[@"placeholder"]];
//                return;
//            }
            
            NSInteger mastery=0;
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if ([dic[@"attrname"] isEqualToString:dic4[@"content"]]) {
                    mastery = [dic[@"attrid"] integerValue];
                }
            }
            [dicArg setObject:@(mastery) forKey:@"role"];
        }
        
        [SVProgressHUD showWithStatus:@"正在修改，请稍等!" maskType:SVProgressHUDMaskTypeClear];

        [AFWebAPI getModifyWorks:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self onGoback];
                self.saveRefreshUI();
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
        
    }
    else if (self.model.workType==WorkTypePastworks)  //修改过往作品
    {
        NSDictionary *dic1 = self.dataS[1];
        NSDictionary *dic2 = self.dataS[2];
        NSDictionary *dic3 = self.dataS[3];
        
        if ([dic1[@"content"]length]==0) {
            [SVProgressHUD showImage:nil status:dic1[@"placeholder"]];
            return;
        }
        
        if ([dic2[@"content"]length]==0) {
            [SVProgressHUD showImage:nil status:dic2[@"placeholder"]];
            return;
        }
        
        if ([dic3[@"content"]length]==0) {
            [SVProgressHUD showImage:nil status:dic3[@"placeholder"]];
            return;
        }
        
        [SVProgressHUD showWithStatus:@"正在修改，请稍等!" maskType:SVProgressHUDMaskTypeClear];
        NSDictionary *dic = @{@"userid":[UserInfoManager getUserUID],
                                 @"creativeid":self.model.creativeid,
                                 @"type":@(self.model.microtype),
                                 @"title":dic1[@"content"],
                                 @"producetype":dic2[@"content"],
                                 @"keyword":[dic3[@"content"] stringByReplacingOccurrencesOfString:@"、" withString:@"|"]};
        
        NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        if ([UserInfoManager getUserMastery]==2) {
            NSDictionary *dic4 = self.dataS[4];
            
//            if ([dic4[@"content"]length]==0) {
//                [SVProgressHUD showImage:nil status:dic4[@"placeholder"]];
//                return;
//            }
            
            NSInteger mastery=0;
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if ([dic[@"attrname"] isEqualToString:dic4[@"content"]]) {
                    mastery = [dic[@"attrid"] integerValue];
                }
            }
            [dicArg setObject:@(mastery) forKey:@"role"];
        }
        
        [AFWebAPI getUploadPastworkWithArg:dicArg data:nil callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self onGoback];
                self.saveRefreshUI();
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }
    else if (self.model.workType==WorkTypeIntroduction || self.model.workType==WorkTypeMordCard)  //修改自我介绍和模特卡
    {
        NSDictionary *dic1 = self.dataS[1];
        NSDictionary *dic2 = self.dataS[2];
        
        if ([dic1[@"content"]length]==0) {
            [SVProgressHUD showImage:nil status:dic1[@"placeholder"]];
            return;
        }
        
        if ([dic2[@"content"]length]==0) {
            [SVProgressHUD showImage:nil status:dic2[@"placeholder"]];
            return;
        }


        NSDictionary *dic = @{@"creativeid":self.model.creativeid,
                                 @"type":@(3),
                                 @"modeltype":dic1[@"content"],
                                 @"keyword":[dic2[@"content"] stringByReplacingOccurrencesOfString:@"、" withString:@"|"]};
        
        [SVProgressHUD showWithStatus:@"正在修改，请稍等!" maskType:SVProgressHUDMaskTypeClear];
        
        NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        if ([UserInfoManager getUserMastery]==2&&self.model.workType==WorkTypeMordCard) {
            NSDictionary *dic3 = self.dataS[3];
//            if ([dic3[@"content"]length]==0) {
//                [SVProgressHUD showImage:nil status:dic3[@"placeholder"]];
//                return;
//            }
            
            NSInteger mastery=0;
            NSArray *array1 = [[UserInfoManager getPublicConfig] objectForKey:@"filmActorRole"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dic = array1[i];
                if ([dic[@"attrname"] isEqualToString:dic3[@"content"]]) {
                    mastery = [dic[@"attrid"] integerValue];
                }
            }
            [dicArg setObject:@(mastery) forKey:@"role"];
        }
        
        [AFWebAPI getModifyWorks:dicArg callBack:^(BOOL success, id object) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self onGoback];
                self.saveRefreshUI();
            }
            else
            {
                AF_SHOW_RESULT_ERROR
            }
        }];
    }

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
    return self.dataS.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if ((self.model.workType==WorkTypePastworks &&self.model.microtype==1) || self.model.workType==WorkTypeMordCard)
        {
            return (UI_SCREEN_WIDTH-30)/1.4+20;
        }
        return (UI_SCREEN_WIDTH-30)/1.78+20;
    }
    else
    {
        return 48;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if ((self.model.workType==WorkTypePastworks &&self.model.microtype==1) || self.model.workType==WorkTypeMordCard)
        {
            static NSString *identifer = @"ModifyWorksCellB";
            ModifyWorksCellB *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if(!cell)
            {
                cell = [[ModifyWorksCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=[UIColor whiteColor];
            }
            if(self.model.workType==WorkTypePastworks)
            {
                [cell reloadUIWithUrl:self.model.url];
            }
            else
            {
                [cell reloadUIWithUrl:self.model.imageurl];
            }
            return cell;
        }
        else
        {
            static NSString *identifer = @"ModifyWorksCellA";
            ModifyWorksCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if(!cell)
            {
                cell = [[ModifyWorksCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=[UIColor whiteColor];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
                [cell addGestureRecognizer:tap];
                cell.tag=indexPath.row+100;
            }
            [cell reloadUIWithUrl:self.model.cutvideo];
            return cell;
        }
    }
    else
    {
        static NSString *identifer = @"UploadWorksCellA";
        UploadWorksCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[UploadWorksCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        WeakSelf(self);
        NSDictionary *dic = self.dataS[indexPath.row];
        cell.textFieldChangeBlock = ^(NSString *text) {
            NSDictionary *dicB= [[NSDictionary alloc]init];
            dicB = @{@"title":dic[@"title"],@"content":text,@"placeholder":dic[@"placeholder"],@"isEdit":dic[@"isEdit"]};
            [weakself.dataS replaceObjectAtIndex:indexPath.row withObject:dicB];
        };
        [cell reloadUIWithDic:dic];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if ((self.model.workType==WorkTypePastworks &&self.model.microtype==1) || self.model.workType==WorkTypeMordCard)
        {
            NSString *url;
            if(self.model.workType==WorkTypePastworks)
            {
                url=self.model.url;
            }
            else
            {
                url=self.model.imageurl;
            }
            ModifyWorksCellB *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
            [lookImage showWithImageArray:@[url] curImgIndex:0 AbsRect:cell.contentView.bounds];
            [self.navigationController pushViewController:lookImage animated:YES];
            lookImage.downPhotoBlock = ^(NSInteger index) {};

        }
    }
    else
    {
        NSDictionary *dicA = self.dataS[indexPath.row];
        BOOL isEdit = [dicA [@"isEdit"] boolValue];
        NSString *title = dicA[@"title"];
        if (isEdit==NO) {
            
            NSInteger type=0;
            if ([title isEqualToString:@"作品类型"]||[title isEqualToString:@"形象类型"]||[title isEqualToString:@"剧照类型"]) {
                type=0;
            }
            else if ([title isEqualToString:@"作品角色"]||[title isEqualToString:@"剧照角色"])
            {
                type=2;
            }
            else
            {
                type=1;
            }
            
            WeakSelf(self);
            WorkTypeSelectV *selectV=[[WorkTypeSelectV alloc]init];
            selectV.keywordSelectAction = ^(NSString *content) {
                NSDictionary *dicB= [[NSDictionary alloc]init];
                dicB = @{@"title":dicA[@"title"],@"content":content,@"placeholder":dicA[@"placeholder"],@"isEdit":dicA[@"isEdit"]};
                [weakself.dataS replaceObjectAtIndex:indexPath.row withObject:dicB];
                [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            NSArray* array;
            if ([dicA[@"content"] length]) {
                array=[dicA[@"content"] componentsSeparatedByString:@"、"];
            }
            [selectV showWithSelectArray:array withType:type withTitle:title];
        }
    }
}

- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
    [_player destroyPlayer];
    _player = nil;

    UIView *view = tapGesture.view;

    _indexPath = [NSIndexPath indexPathForRow:view.tag - 100 inSection:0];
    UITableViewCell *cell = [self.tableV cellForRowAtIndexPath:_indexPath];

    _player = [[VideoPlayer alloc] init];
    _player.layer.masksToBounds=YES;
    _player.layer.cornerRadius=5.0;
    if (self.model.workType==WorkTypePastworks) {
        _player.videoUrl=self.model.url;
    }
    else
    {
        _player.videoUrl=self.model.video;
    }
    [_player playerBindTableView:self.tableV currentIndexPath:_indexPath];
    _player.frame = CGRectMake(15, 20, view.bounds.size.width-30, view.bounds.size.height-40);

    [cell.contentView addSubview:_player];

    _player.completedPlayingBlock = ^(VideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
    _player.dowmLoadBlock = ^{};
}

#pragma mark -
#pragma mark - TableVTouchDelegate
- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
