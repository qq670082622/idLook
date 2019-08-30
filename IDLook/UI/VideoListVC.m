//
//  VideoListVC.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoListVC.h"
#import "HomeMainCellD.h"
#import "VideoPlayer.h"
#import "VideoListTopV.h"
#import "VideoListPopV.h"
#import "ScreenPopV.h"
#import "LookPricePopV2.h"
#import "AuthBuyerVC.h"
#import "MyAuthStateVC.h"
#import "PlaceShotOrderVC.h"
#import "PlaceAuditionOrderVC.h"
#import "WorksModel.h"
#import "VideoListHeadView.h"
#import "WordSearchVC.h"
#import "ActorCell.h"
#import "UserModel.h"
#import "ActorVideoView.h"
@interface VideoListVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    VideoPlayer *_player;
}
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableDictionary *screenConditionDic;  //筛选条件类容

@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger comprSelect;  //综合0，竞争力1，颜值2
@property(nonatomic,assign)NSInteger topSelect;     //综合0，报价1，年龄2
@property(nonatomic,assign)BOOL offerLowToHigh;    //报价是否低到高，默认no倒序高到低
@property(nonatomic,assign)BOOL ageLowToHigh;    //年龄是否低到高，默认no倒序高到低
@property(nonatomic,strong)NSIndexPath *currentIndexPath;
@property(nonatomic,assign)NSInteger sortPage;//页码
@end

@implementation VideoListVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player destroyPlayer];
    _player = nil;
   
    VideoListPopV *popV = [[VideoListPopV alloc]init];
    [popV showWithLoad:NO withMasteryType:self.masteryType withType:0 withVideoType:self.type withOffY:self.tableV.contentOffset.y withSelectDic:self.screenConditionDic];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    self.screenConditionDic = [NSMutableDictionary new];
    

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:[CustomNavVC getRightBarButtonItem2WithTarget:self action:@selector(onSearch) normalImg:@"home_search" hilightImg:@"home_search"]]];

    if (self.masteryType==1) {
        NSArray *list = self.dic[@"lists"];
        [self.navigationItem setTitleView:[CustomNavVC setAttributeNavgationItemTitle1:self.dic[@"catename"] withTitle2:[NSString stringWithFormat:@"_%@",list[self.subType][@"attrname"]]]];
    }
    else if (self.masteryType==2)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"影视剧演员"]];
    }
    else if (self.masteryType==3)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"外籍模特"]];
    } else if (self.masteryType==4)
    {
        [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"前景演员"]];
    }
    if (_isHomeSearch) {
         [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"搜索结果"]];
    }
    
    self.dataSource= [NSMutableArray new];
    [self tableV];
    _sortPage = 1;
    [self refreshDataWithSortPage:_sortPage withRefreshType:RefreshTypePullDown];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onSearch
{
    WordSearchVC *searchVC=[[WordSearchVC alloc]init];
    if (self.masteryType==1) {
        searchVC.mastery = 1;
    }
    else if (self.masteryType==2)
    {
       searchVC.mastery = 2;
    }
    else if (self.masteryType==3)
    {
       searchVC.mastery = 3;
    }
    [self.navigationController pushViewController:searchVC animated:YES];
}
-(NSMutableDictionary *)dicWithRule:(NSMutableArray *)rules andKey:(NSString *)key
{
    NSMutableDictionary *conditionDic = [NSMutableDictionary dictionary];
     [conditionDic setObject:key forKey:@"conditionName"];
    [conditionDic setObject:rules forKey:@"rules"];
    return conditionDic;
}
-(void)refreshDataWithSortPage:(NSInteger)sortpage withRefreshType:(RefreshType)type
{
    if (_isHomeSearch) {
        //点击的价格
        NSArray *prices = @[@"0-2000",@"2000-4000",@"4000-8000",@"8000-30000"];
        NSString *priceStr = [_screenConditionDic objectForKey:@"price"];
        NSMutableArray *priceA = [NSMutableArray new];
        if (priceStr.length>0) {
            _conditionModel.price_min = -1;
            _conditionModel.price_max = -1;
            NSArray *priceArr = [priceStr componentsSeparatedByString:@","];
            for(int i = 0 ;i<priceArr.count;i++){
                NSInteger index = [priceArr[i] integerValue];
                NSString *indexStr = prices[index+1];
                [priceA addObject:indexStr];
            }
            }
    
        //自填的价格
        NSInteger pricestar = [[_screenConditionDic objectForKey:@"pricestart"] integerValue];
         NSInteger priceend = [[_screenConditionDic objectForKey:@"priceend"] integerValue];
        if (pricestar>0) {
            _conditionModel.price_min = pricestar;
            _conditionModel.price_max = priceend>0?priceend:20000;
        }
        if (priceend>0) {
            _conditionModel.price_max = priceend;
            _conditionModel.price_min = pricestar>0?pricestar:0;
        }
        //性别
        NSInteger sex = [[_screenConditionDic objectForKey:@"sex"] integerValue];
        _conditionModel.sex = sex;
         // 点击的年龄
       NSArray *ages = @[@"0-11",@"12-19",@"20-29",@"30-39",@"40-100"];
        NSString *ageStr = [_screenConditionDic objectForKey:@"age"];
        NSMutableArray *ageeA = [NSMutableArray new];
        if (ageStr.length>0) {
            _conditionModel.age_min = -1;
            _conditionModel.age_max = -1;
            NSArray *ageArr = [priceStr componentsSeparatedByString:@","];
            for(int i = 0 ;i<ageArr.count;i++){
                NSInteger index = [ageArr[i] integerValue];
                NSString *indexStr = ages[index+1];
                [ageeA addObject:indexStr];
            }
        }
        //自填的年龄
        NSInteger agestar = [[_screenConditionDic objectForKey:@"agestart"] integerValue];
        NSInteger ageend = [[_screenConditionDic objectForKey:@"ageend"] integerValue];
        if (agestar>0) {
            _conditionModel.age_min = agestar;
            _conditionModel.age_max = ageend>0?ageend:100;
        }
        if (ageend>0) {
            _conditionModel.age_max = ageend;
            _conditionModel.age_min = agestar>0?agestar:0;
        }
        // 点击的身高
        NSArray *heights = @[@"0-160",@"160-170",@"170-180",@"180-250"];
      NSString *heightStr = [_screenConditionDic objectForKey:@"height"];
        NSMutableArray *heightA = [NSMutableArray new];
        if (ageStr.length>0) {
            _conditionModel.hei_min = -1;
            _conditionModel.hei_max = -1;
            NSArray *heiArr = [heightStr componentsSeparatedByString:@","];
            for(int i = 0 ;i<heiArr.count;i++){
                NSInteger index = [heiArr[i] integerValue];
                NSString *indexStr = heights[index+1];
                [heightA addObject:indexStr];
            }
        }
        //自填的身高
        NSInteger heistar = [[_screenConditionDic objectForKey:@"heightstart"] integerValue];
        NSInteger heiend = [[_screenConditionDic objectForKey:@"heightend"] integerValue];
        if (heistar>0) {
            _conditionModel.hei_min = heistar;
            _conditionModel.hei_max = heiend>0?heiend:250;
        }
        if (heiend>0) {
            _conditionModel.hei_max = heiend;
            _conditionModel.hei_min = heistar>0?heistar:0;
        }
        // 点击的体重
        NSArray *weights = @[@"0-50",@"50-60",@"60-70",@"70-120"];
        NSString *weightStr = [_screenConditionDic objectForKey:@"weight"];
        NSMutableArray *weightA = [NSMutableArray new];
        if (weightStr.length>0) {
            _conditionModel.wei_min = -1;
            _conditionModel.wei_max = -1;
            NSArray *weiArr = [heightStr componentsSeparatedByString:@","];
            for(int i = 0 ;i<weiArr.count;i++){
                NSInteger index = [weiArr[i] integerValue];
                NSString *indexStr = weights[index+1];
                [weightA addObject:indexStr];
            }
        }
        //自填的体重
        NSInteger weistar = [[_screenConditionDic objectForKey:@"weightstart"] integerValue];
        NSInteger weiend = [[_screenConditionDic objectForKey:@"weightend"] integerValue];
        if (weistar>0) {
            _conditionModel.wei_min = weistar;
            _conditionModel.wei_max = heiend>0?heiend:250;
        }
        if (weiend>0) {
            _conditionModel.wei_max = weiend;
            _conditionModel.wei_min = weistar>0?weistar:0;
        }
        NSMutableString *ageMuStr = [NSMutableString new];
        if (_conditionModel.age_max>0 || _conditionModel.age_min>0) {
            ageMuStr = [NSMutableString stringWithFormat:@"%ld-%ld",_conditionModel.age_min,_conditionModel.age_max];
        }
        if (ageeA.count>0) {
            ageMuStr = [NSMutableString stringWithString:[ageeA componentsJoinedByString:@","]];
        }
        NSMutableString *priceMuStr = [NSMutableString new];
        if (_conditionModel.price_min>0 || _conditionModel.price_max>0) {
            priceMuStr = [NSMutableString stringWithFormat:@"%ld-%ld",_conditionModel.price_min,_conditionModel.price_max];
        }
        if (priceA.count>0) {
            priceMuStr = [NSMutableString stringWithString:[priceA componentsJoinedByString:@","]];
        }
        NSMutableString *heiMuStr = [NSMutableString new];
        if (_conditionModel.hei_min>0 || _conditionModel.hei_max>0) {
            heiMuStr = [NSMutableString stringWithFormat:@"%ld-%ld",_conditionModel.hei_min,_conditionModel.hei_max];
        }
        if (heightA.count>0) {
            heiMuStr = [NSMutableString stringWithString:[heightA componentsJoinedByString:@","]];
        }
        NSMutableString *weiMuStr = [NSMutableString new];
        if (_conditionModel.wei_min>0 || _conditionModel.wei_max>0) {
            weiMuStr = [NSMutableString stringWithFormat:@"%ld-%ld",_conditionModel.wei_min,_conditionModel.wei_max];
        }
        if (weightA.count>0) {
            weiMuStr = [NSMutableString stringWithString:[weightA componentsJoinedByString:@","]];
        }
        //topselect 0 综合 1价格高到低
      
        NSDictionary *arg = @{
                              @"ageMax":[ageMuStr copy],
                              @"height":[heiMuStr copy],
                              @"keyword":_conditionModel.keyWord,
                              @"occupation":@(0),
                              @"price":[priceMuStr copy],
                             @"region":_conditionModel.region,
                              @"sex":@(_conditionModel.sex==3?0:_conditionModel.sex),
                              @"weight":[weiMuStr copy],
                              @"pageCount":@(25),
                              @"pageNumber":@(sortpage),
                              @"order":@(_topSelect), //_topSelect==0是综合 ==1是价格
                              @"desc":@(_offerLowToHigh==YES?0:1)  //0降序 1升序
                              };
        [AFWebAPI_JAVA searchActorWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
            self.tableV.animatedStyle = TABTableViewAnimationEnd;
            if (success) {
                NSArray *array= [object objectForKey:@"body"];
                if (type==RefreshTypePullDown) {
                    [self.dataSource removeAllObjects];
                    _sortPage=2;
                }else if (type==RefreshTypePullUp){
                    _sortPage++;
                }
                for(int i=0;i<array.count;i++){
                    NSDictionary *modelDic = array[i];
                    UserModel *model = [UserModel yy_modelWithDictionary:modelDic];
                    if (self.masteryType==1) {//广告演员  解决从广告点击标签进来没有排序的问题
                        NSArray *list = self.dic[@"lists"];
                        NSString *typeString = list[self.subType][@"attrname"];
                        NSMutableArray *newList = [NSMutableArray new];
                        for(int i = 0 ;i<model.showList.count;i++){
                            NSDictionary *showDic = model.showList[i];
                            if ([showDic[@"cateName"] isEqualToString:typeString]) {
                                [newList insertObject:showDic atIndex:0];
                            }else{
                                [newList addObject:showDic];
                            }
                        }
                        model.showList = [newList copy];
                    }
                    
                    [self.dataSource addObject:model];
                }
                [self.tableV reloadData];
                [self.tableV hideNoDataScene];
                if (self.dataSource.count==0) {
                    [self.tableV showWithNoDataType:NoDataTypeSearchResult];
                }
            }else{
                
                [SVProgressHUD showErrorWithStatus:object];
                [self.tableV hideNoDataScene];
                if (self.dataSource.count==0) {
                    [self.tableV showWithNoDataType:NoDataTypeNetwork];
                }
            }
            [self.tableV headerEndRefreshing];
            [self.tableV footerEndRefreshing];
        }];
        return;
    }
      if ([UserInfoManager getIsJavaService]) {//java后台
          NSArray *actorConditions;//演员筛选条件
          NSArray *priceConditions;//价格筛选条件
          self.screenConditionDic = [PublicManager deleteAllNullValueFrom:_screenConditionDic];
    
        NSMutableArray *actor_age = [NSMutableArray new];
          NSMutableArray *ageRangeList = [NSMutableArray new];
          if ([self.screenConditionDic objectForKey:@"agestart"] && [self.screenConditionDic objectForKey:@"ageend"]) {//填的
           [actor_age addObject:[NSDictionary dictionaryWithObjectsAndKeys:@([_screenConditionDic[@"agestart"]integerValue ]),@"min",@([_screenConditionDic[@"ageend"] integerValue]),@"max", nil]];
          }else if ([self.screenConditionDic objectForKey:@"agestart"] && ![self.screenConditionDic objectForKey:@"ageend"])
          {
             [actor_age addObject:[NSDictionary dictionaryWithObjectsAndKeys:@([_screenConditionDic[@"agestart"]integerValue ]),@"min",@(9999999),@"max", nil]];
          }else if (![self.screenConditionDic objectForKey:@"agestart"] && [self.screenConditionDic objectForKey:@"ageend"])
          {
              [actor_age addObject:[NSDictionary dictionaryWithObjectsAndKeys:@(0),@"min",@([_screenConditionDic[@"ageend"] integerValue]),@"max", nil]];
          }

          if ([self.screenConditionDic objectForKey:@"age"]) {//选的
              NSString *ageId = _screenConditionDic[@"age"];
              NSArray *ageids = [ageId componentsSeparatedByString:@","];
              for(int i=0;i<ageids.count;i++){
                  NSString *aid = ageids[i];
                  NSDictionary *typeDic = [NSDictionary dictionaryWithObject:@([aid integerValue]) forKey:@"id"];
                  [ageRangeList addObject:typeDic];
              }
            }
          NSMutableDictionary *actor_age_dic = [self dicWithRule:actor_age andKey:@"actor_age"];
          NSMutableDictionary *ageRangeList_dic;
          if (_masteryType== 2 || _masteryType==3 || _masteryType==4) {
              ageRangeList_dic = [self dicWithRule:ageRangeList andKey:@"filmActorAgeGroup"];
          }else if (_masteryType== 1 )
          {
             ageRangeList_dic = [self dicWithRule:ageRangeList andKey:@"ageRangeList"];
          }

          //actor_sex
            NSMutableArray *sexRule = [NSMutableArray new];
          if ([self.screenConditionDic objectForKey:@"sex"]) {//填的
              NSString *sex = _screenConditionDic[@"sex"];
              NSArray *sexArr = [sex componentsSeparatedByString:@","];
              for(int i = 0;i<sexArr.count;i++){
                  NSString *sexStr = sexArr[i];
                     [sexRule addObject:[NSDictionary dictionaryWithObject:@([sexStr integerValue]) forKey:@"id"]];
              }
           }
        NSMutableDictionary *actor_sex = [self dicWithRule:sexRule andKey:@"a.actor_sex"];
            //actor_perform_type 关键字，比如文艺
#warning -type此处还要验证一下老接口
          NSMutableDictionary *actor_perform_type;
          NSMutableDictionary *actor_age_identity;
          if (self.masteryType==1) {//广告演员
              NSArray *list = self.dic[@"lists"];
              NSString *typeString = list[self.subType][@"attrname"];
             NSMutableArray *typeRule = [NSMutableArray new];
                [typeRule addObject:[NSDictionary dictionaryWithObject:typeString forKey:@"val"]];
                actor_perform_type = [self dicWithRule:typeRule andKey:@"actor_perform_type"];
              
              NSMutableArray *identy = [NSMutableArray new];
              [identy addObject:[NSDictionary dictionaryWithObject:@(_type) forKey:@"id"]];//
              actor_age_identity = [self dicWithRule:identy andKey:@"actor_age_identity"];
          }
       //actor_nationality 国籍
           NSMutableArray *natRule = [NSMutableArray new];
          if ([self.screenConditionDic objectForKey:@"nat"]) {//填的
              NSString *nat = _screenConditionDic[@"nat"];
              NSArray *natArr= [nat componentsSeparatedByString:@","];
              for (NSString *natStr in natArr) {
                   [natRule addObject:[NSDictionary dictionaryWithObject:natStr forKey:@"val"]];
              }
             
          }
          NSMutableDictionary *actor_nationality = [self dicWithRule:natRule andKey:@"actor_nationality"];
          //actor_height
          NSMutableArray *actor_height = [NSMutableArray new];
           NSMutableArray *heightType = [NSMutableArray new];
          if ([self.screenConditionDic objectForKey:@"heightstart"] && [self.screenConditionDic objectForKey:@"heightend"]) {//填的
[actor_height addObject:[NSDictionary dictionaryWithObjectsAndKeys:@([_screenConditionDic[@"heightstart"]integerValue ]),@"min",@([_screenConditionDic[@"heightend"] integerValue]),@"max", nil]];
          }else  if (![self.screenConditionDic objectForKey:@"heightstart"] && [self.screenConditionDic objectForKey:@"heightend"]) {
              [actor_height addObject:[NSDictionary dictionaryWithObjectsAndKeys:@(0),@"min",@([_screenConditionDic[@"heightend"] integerValue]),@"max", nil]];
          }else  if ([self.screenConditionDic objectForKey:@"heightstart"] && ![self.screenConditionDic objectForKey:@"heightend"]) {
             [actor_height addObject:[NSDictionary dictionaryWithObjectsAndKeys:@([_screenConditionDic[@"heightstart"]integerValue ]),@"min",@(9999999),@"max", nil]];
          }
               if ([self.screenConditionDic objectForKey:@"height"]) {//选的
              NSString *height = _screenConditionDic[@"height"];
            NSArray *heiids = [height componentsSeparatedByString:@","];
                   for(int i=0;i<heiids.count;i++){
                      NSString *hid = heiids[i];
                NSDictionary *typeDic = [NSDictionary dictionaryWithObject:@([hid integerValue]) forKey:@"id"];
                  [heightType addObject:typeDic];
             }
        }
          
          
          NSMutableDictionary *actor_height_dic = [self dicWithRule:actor_height andKey:@"actor_height"];
           NSMutableDictionary *heightType_dic = [self dicWithRule:heightType andKey:@"heightType"];
//          actor_weight
          NSMutableArray *actor_weight = [NSMutableArray new];
           NSMutableArray *weightType = [NSMutableArray new];
          if ([self.screenConditionDic objectForKey:@"weightstart"] && [self.screenConditionDic objectForKey:@"weightend"]) {//填的
             [actor_weight addObject:[NSDictionary dictionaryWithObjectsAndKeys:@([_screenConditionDic[@"weightstart"]integerValue ]),@"min",@([_screenConditionDic[@"weightend"] integerValue]),@"max", nil]];
          }else if(![self.screenConditionDic objectForKey:@"weightstart"] && [self.screenConditionDic objectForKey:@"weightend"]) {
               [actor_weight addObject:[NSDictionary dictionaryWithObjectsAndKeys:@(0),@"min",@([_screenConditionDic[@"weightend"] integerValue]),@"max", nil]];
          }else if([self.screenConditionDic objectForKey:@"weightstart"] && ![self.screenConditionDic objectForKey:@"weightend"]) {
            [actor_weight addObject:[NSDictionary dictionaryWithObjectsAndKeys:@([_screenConditionDic[@"weightstart"]integerValue ]),@"min",@(9999999),@"max", nil]];
          }
     
          if ([self.screenConditionDic objectForKey:@"weight"]) {//选的
              NSString *weight = _screenConditionDic[@"weight"];
              NSArray *weiids = [weight componentsSeparatedByString:@","];
              for(int i=0;i<weiids.count;i++){
                  NSString *wid = weiids[i];
                  NSDictionary *typeDic = [NSDictionary dictionaryWithObject:@([wid integerValue]) forKey:@"id"];
                  [heightType addObject:typeDic];
              }
            }
          NSMutableDictionary *actor_weight_dic = [self dicWithRule:actor_weight andKey:@"actor_weight"];
            NSMutableDictionary *weightType_dic = [self dicWithRule:weightType andKey:@"weightType"];
//          actor_single_type 视频 平面类型
          NSMutableArray *typeRules = [NSMutableArray new];
          NSMutableArray *typeRules2 = [NSMutableArray new];
          if ([self.screenConditionDic objectForKey:@"video"]) {//填的
              NSString *video = [self.screenConditionDic objectForKey:@"video"];
              NSArray *videoArray = [video componentsSeparatedByString:@","];
              [typeRules addObjectsFromArray:videoArray];
          }
          if ([self.screenConditionDic objectForKey:@"print"]) {//填的
              NSString *print = [self.screenConditionDic objectForKey:@"print"];
              NSArray *printArray = [print componentsSeparatedByString:@","];
              [typeRules addObjectsFromArray:printArray];
          }
          for(int i=0;i<typeRules.count;i++){
              NSString *typeid = typeRules[i];
              NSDictionary *typeDic = [NSDictionary dictionaryWithObject:@([typeid integerValue]) forKey:@"id"];
              [typeRules2 addObject:typeDic];
          }
          NSMutableDictionary *actor_single_type = [self dicWithRule:typeRules2 andKey:@"actor_single_type"];
          if (!actor_age_identity) {
              actor_age_identity = [self dicWithRule:[NSMutableArray new] andKey:@"actor_age_identity"];
          }
          if (!actor_perform_type) {
              actor_perform_type = [self dicWithRule:[NSMutableArray new] andKey:@"actor_perform_type"];
          }
          if (!actor_single_type) {
            actor_single_type = [self dicWithRule:[NSMutableArray new] andKey:@"actor_single_type"];
          }
          actorConditions = [NSArray arrayWithObjects:actor_age_identity,actor_age_dic,ageRangeList_dic,actor_sex,actor_perform_type,actor_nationality,actor_height_dic,heightType_dic,actor_weight_dic,weightType_dic,actor_single_type,nil];
         //*******price*********************
          //actor_single_price
          NSMutableArray *actor_single_price = [NSMutableArray new];
            NSMutableArray *priceGroup = [NSMutableArray new];//价格id分三种：广告演员价格段位，影视剧演员价格段位，外籍模特价格段位
          if ([self.screenConditionDic objectForKey:@"pricestart"] && [self.screenConditionDic objectForKey:@"priceend"]) {//填的
            [actor_single_price addObject:[NSDictionary dictionaryWithObjectsAndKeys:@([_screenConditionDic[@"pricestart"]integerValue ]),@"min",@([_screenConditionDic[@"priceend"] integerValue]),@"max", nil]];
          }else if ([self.screenConditionDic objectForKey:@"pricestart"] && ![self.screenConditionDic objectForKey:@"priceend"]){
            [actor_single_price addObject:[NSDictionary dictionaryWithObjectsAndKeys:@([_screenConditionDic[@"pricestart"]integerValue ]),@"min",@(9999999),@"max", nil]];
          }else if (![self.screenConditionDic objectForKey:@"pricestart"] && [self.screenConditionDic objectForKey:@"priceend"]){
              [actor_single_price addObject:[NSDictionary dictionaryWithObjectsAndKeys:@(0),@"min",@([_screenConditionDic[@"priceend"] integerValue]),@"max", nil]];
          }
      if ([self.screenConditionDic objectForKey:@"price"]) {//选的
              NSString *priceId = _screenConditionDic[@"price"];
          NSArray *priceIds = [priceId componentsSeparatedByString:@","];
          for(int i =0;i<priceIds.count;i++){
              NSString *pId = priceIds[i];
              [priceGroup addObject:[NSDictionary dictionaryWithObject:@([pId integerValue]) forKey:@"id"]];
          }
          }
          NSMutableDictionary *actor_single_price_dic = [self dicWithRule:actor_single_price andKey:@"actor_single_price"];
          NSMutableDictionary *priceGroup_dic ;
          if (self.masteryType==1) {
              priceGroup_dic = [self dicWithRule:priceGroup andKey:@"priceGroup"];
          }
          else if (self.masteryType==2 || self.masteryType==4)
          {
              priceGroup_dic = [self dicWithRule:priceGroup andKey:@"filmActorpriceGroup"];
          }
          else if (self.masteryType==3 )
          {
               priceGroup_dic = [self dicWithRule:priceGroup andKey:@"foreignModelpriceGroup"];
          }
          priceConditions = [NSArray arrayWithObjects:actor_single_price_dic,priceGroup_dic,nil];
          BOOL isDesc = false;
          if (self.offerLowToHigh==YES){
              isDesc = YES;
          }
          NSString *sortType;
          if (self.topSelect==0) {  //综合
              sortType = @"work_score";
              isDesc = YES;//综合默认就是高到低
          }
          else if (self.topSelect==1) {  //报价
             sortType = @"actor_single_price";
          }
          NSDictionary *param = @{@"pageCount":@(30),
                                   @"pageNumber":@(sortpage),
                                   @"source":@(2),
                                  @"orderBy":sortType,//排序字段
                                  @"mastery":@(_masteryType),//1=广告演员，2=影视演员，3=外模'
                                  @"desc":@(isDesc),//是否倒叙 高到低true 低到高false
                                  @"actorConditions":[self cleanNullDicWithArray:actorConditions],//演员筛选条件
                                  @"priceConditions":[self cleanNullDicWithArray:priceConditions]//价格筛选条件
                                   };
          [AFWebAPI_JAVA getHomeRecommendWithArg:param callBack:^(BOOL success, id  _Nonnull object) {
               self.tableV.animatedStyle = TABTableViewAnimationEnd;
              if (success) {
                NSArray *array= [object objectForKey:@"body"];
                  if (type==RefreshTypePullDown) {
                      [self.dataSource removeAllObjects];
                      _sortPage=2;
                  }else if (type==RefreshTypePullUp){
                      _sortPage++;
                  }
                for(int i=0;i<array.count;i++){
                      NSDictionary *modelDic = array[i];
                      UserModel *model = [UserModel yy_modelWithDictionary:modelDic];
                    if (self.masteryType==1) {//广告演员  解决从广告点击标签进来没有排序的问题
                        NSArray *list = self.dic[@"lists"];
                        NSString *typeString = list[self.subType][@"attrname"];
                        NSMutableArray *newList = [NSMutableArray new];
                        for(int i = 0 ;i<model.showList.count;i++){
                            NSDictionary *showDic = model.showList[i];
                            if ([showDic[@"cateName"] isEqualToString:typeString]) {
                                [newList insertObject:showDic atIndex:0];
                            }else{
                                 [newList addObject:showDic];
                            }
                        }
                        model.showList = [newList copy];
                    }
                  
                      [self.dataSource addObject:model];
                      }
                  [self.tableV reloadData];
                  [self.tableV hideNoDataScene];
                  if (self.dataSource.count==0) {
                      [self.tableV showWithNoDataType:NoDataTypeSearchResult];
                  }
              }else{
                  
                  [SVProgressHUD showErrorWithStatus:object];
                  [self.tableV hideNoDataScene];
                  if (self.dataSource.count==0) {
                      [self.tableV showWithNoDataType:NoDataTypeNetwork];
                  }
              }
              [self.tableV headerEndRefreshing];
              [self.tableV footerEndRefreshing];
          }];


      }else{
    
    
    NSMutableDictionary *dicArg = [[NSMutableDictionary alloc]initWithDictionary:self.screenConditionDic];
    [dicArg setObject:@(1)forKey:@"occupation"];
    [dicArg setObject:@(sortpage) forKey:@"sortpage"];
    [dicArg setObject:@"30" forKey:@"pagenumber"];
    [dicArg setObject:[UserInfoManager getUserUID] forKey:@"userid"];
    [dicArg setObject:@"30" forKey:@"pagenumber"];
    
    if (self.topSelect==0) {
        [dicArg setObject:@"desc" forKey:@"colligate"];   //综合
    }
    else if (self.topSelect==1) {
        [dicArg setObject:self.offerLowToHigh==YES?@"asc":@"desc" forKey:@"quote"];    //报价
    }
    
    NSString *service=@"";
    if (self.masteryType==1) {
        NSArray *list = self.dic[@"lists"];
        [dicArg setObject:list[self.subType][@"attrname"] forKey:@"figuretype"];
        [dicArg setObject:@(self.type) forKey:@"ageidentity"];
        service=@"Home.videoActorList";
    }
    else if (self.masteryType==2)
    {
        service=@"Home.filmActorList";
    }
    else if (self.masteryType==3)
    {
        service=@"Home.foreignModelList";
    }
    
    [AFWebAPI getScreenVideoListWithArg:dicArg withService:service callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            if (type==RefreshTypePullDown) {
                [self.dataSource removeAllObjects];
            }
            NSArray *array= (NSArray*)safeObjectForKey(object, JSON_data);;
            
            for (int i = 0; i<array.count; i++) {
                UserInfoM *info = [[UserInfoM alloc]initWithDic:array[i]];
                [self.dataSource addObject:info];
            }
            self.tableV.animatedStyle = TABTableViewAnimationEnd;
            [self.tableV reloadData];
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeSearchResult];
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR
            [self.tableV hideNoDataScene];
            if (self.dataSource.count==0) {
                [self.tableV showWithNoDataType:NoDataTypeNetwork];
            }
        }
        [self.tableV headerEndRefreshing];
        [self.tableV footerEndRefreshing];
    }];
      }
}
-(NSArray *)cleanNullDicWithArray:(NSArray *)conditionArray
{
    NSMutableArray *conditionNew = [NSMutableArray new];
    for(int i = 0 ;i<conditionArray.count;i++){
        NSDictionary *conditionDic = conditionArray[i];
        NSArray *rule = conditionDic[@"rules"];
        if (rule.count>0) {
            [conditionNew addObject:conditionDic];
        }
    }
    return [conditionNew copy];
}
-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectMake(0,0,UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableV.showsVerticalScrollIndicator=NO;
        _tableV.showsHorizontalScrollIndicator=NO;
        [self.view addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        [_tableV addHeaderWithTarget:self action:@selector(pullDownToRefresh:)];
        [_tableV addFooterWithTarget:self action:@selector(pullUpToRefresh:)];
        _tableV.tableHeaderView=[self tableVHead];
        _tableV.animatedStyle = TABTableViewAnimationStart;
    
    }
    return _tableV;
}

-(void)pullDownToRefresh:(id)sender
{
    [self refreshDataWithSortPage:1 withRefreshType:RefreshTypePullDown];
}

-(void)pullUpToRefresh:(id)sender
{
  //  UserInfoM *info = [self.dataSource lastObject];
    [self refreshDataWithSortPage:_sortPage withRefreshType:RefreshTypePullUp];
}

-(UIView*)tableVHead
{
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
    
    VideoListTopV *topV=[[VideoListTopV alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 48)];
    [bg addSubview:topV];
    WeakSelf(self);
    topV.selectWithType = ^(NSInteger type) {
        if (type==0) {
            if (weakself.topSelect==type) {
                return ;
            }
        }
        else
        {
            if (weakself.topSelect==0) {
                weakself.offerLowToHigh=YES;
            }
            else
            {
                weakself.offerLowToHigh=!weakself.offerLowToHigh;
            }
        }
        weakself.topSelect=type;
        [weakself.tableV setContentOffset:CGPointMake(0, 0)];
        [weakself.tableV headerBeginRefreshing];
        
        VideoListPopV *popV = [[VideoListPopV alloc]init];
        [popV showWithLoad:NO withMasteryType:weakself.masteryType withType:0 withVideoType:weakself.type withOffY:weakself.tableV.contentOffset.y withSelectDic:weakself.screenConditionDic];
        
        VideoListHeadView *headV = (VideoListHeadView*)[weakself.tableV headerViewForSection:0];
        [headV hideReloadUI];
        
    };
    topV.screenAction = ^{
        ScreenPopV *spopV = [[ScreenPopV alloc]init];
        spopV.selectDic=weakself.screenConditionDic;
        [spopV showWithType:weakself.masteryType];
        spopV.confrimBlock = ^(NSDictionary *dic) {
            [weakself.screenConditionDic addEntriesFromDictionary:dic]; //可变字典添加字典
            [weakself.tableV setContentOffset:CGPointMake(0, 0)];
            [weakself.tableV headerBeginRefreshing];
        };
        
        VideoListPopV *popV = [[VideoListPopV alloc]init];
        [popV showWithLoad:NO withMasteryType:weakself.masteryType withType:0 withVideoType:weakself.type withOffY:weakself.tableV.contentOffset.y withSelectDic:weakself.screenConditionDic];

        VideoListHeadView *headV = (VideoListHeadView*)[weakself.tableV headerViewForSection:0];
        [headV hideReloadUI];
    };
    
    return bg;
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48.f;
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
    return 340;// return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *identifer = @"HomeMainCellD";
//
//    HomeMainCellD *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
//    if(!cell)
//    {
//        cell = [[HomeMainCellD alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor=[UIColor clearColor];
//    }
//    NSString *select =@"";
//    if (self.masteryType==1) {
//        NSArray *list = self.dic[@"lists"];
//        select = list[self.subType][@"attrname"];
//    }
//    if (tableView.animatedStyle != TABTableViewAnimationStart) {
//        UserInfoM *info = self.dataSource[indexPath.row];
//        [cell reloadUIWithModel:info withSelect:select];
//
//        WeakSelf(self);
//        cell.lookUserOffer = ^{
//            [weakself lookUserPriceInfo:info];
//        };
//
//        cell.playVideWithUrl = ^(WorksModel *workModel, NSInteger videoPage) {
//            [weakself playVideoWithModel:workModel withIndexPath:indexPath andPage:videoPage];
//        };
//        cell.endDeceleratingBlock = ^{
//            [weakself endDeceleratingPlay];
//        };
//    }
//    return cell;
    ActorCell *cell = [ActorCell cellWithTableView:tableView];
    if (tableView.animatedStyle != TABTableViewAnimationStart) {
        UserModel *info = self.dataSource[indexPath.row];
        cell.model = info;
        cell.index_row = indexPath.row;
                WeakSelf(self);
//                cell.lookUserOffer = ^{
//                    [weakself lookUserPriceInfo:info];
//                };
        
                cell.playVideWithUrl = ^(WorksModel *workModel, NSInteger videoPage) {
                    [weakself playVideoWithModel:workModel withIndexPath:indexPath andPage:videoPage];
                };
                cell.endDeceleratingBlock = ^{
                    [weakself endDeceleratingPlay];
                };
        cell.lookPicture = ^(WorksModel *workModel, NSInteger index) {
            [weakself lookPictureWuthModel:workModel andIndex:index];
        };
    }
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"VideoListHeadView";
    VideoListHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    if(!headerView)
    {
        headerView = [[VideoListHeadView alloc] initWithReuseIdentifier:identifer];
        [headerView.backgroundView setBackgroundColor:[UIColor whiteColor]];
        [headerView reloadUIWithType:self.masteryType];
    }
    WeakSelf(self);
    WeakSelf(headerView);
    headerView.screenConditionBlock = ^(ScreenCellType type, BOOL isSelect) {
        VideoListPopV *popV = [[VideoListPopV alloc]init];
        [popV showWithLoad:isSelect withMasteryType:weakself.masteryType withType:type withVideoType:weakself.type withOffY:weakself.tableV.contentOffset.y withSelectDic:weakself.screenConditionDic];
        popV.compClickBlock = ^(NSDictionary * _Nonnull dic, NSString * _Nonnull title) {
            [weakself.screenConditionDic addEntriesFromDictionary:dic];
            [weakheaderView reloadButtonWithType:type withTitle:title];
            [weakself.tableV setContentOffset:CGPointMake(0, 0)];
            [weakself.tableV headerBeginRefreshing];
        };
        popV.hideBlock = ^{
            [weakheaderView hideReloadUI];
        };
    };
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActorCell *cell = [self.tableV cellForRowAtIndexPath:indexPath];
    UserModel *model = self.dataSource[indexPath.row];
    UserInfoVC *userInfoVC=[[UserInfoVC alloc]init];
    UserDetialInfoM *uInfo = [[UserDetialInfoM alloc]init];
    uInfo.actorId =model.actorId;
    userInfoVC.info =uInfo;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}
-(void)lookPictureWuthModel:(WorksModel *)model andIndex:(NSInteger)index
{
    LookBigImageVC *lookImage=[[LookBigImageVC alloc]init];
    lookImage.isShowDown=YES;
    [lookImage showWithImageArray:[NSArray arrayWithObject:model.cutvideo] curImgIndex:0 AbsRect:CGRectMake(0, 0,0,0)];
    [self.navigationController pushViewController:lookImage animated:YES];
    lookImage.downPhotoBlock = ^(NSInteger index) {  //下载回掉
        [self VideostatisticsWithWorkModel:model withType:2];
    };
}
-(void)playVideoWithModel:(WorksModel *)model withIndexPath:(NSIndexPath *)indexPath andPage:(NSInteger)page
{
    self.currentIndexPath=indexPath;
    ActorCell *cell = [self.tableV cellForRowAtIndexPath:indexPath];
    if (page==100) {//说明是滑动table，
        if(_player.currentIndexPath == indexPath){//说明此次滚动并没有触发播放其他cell视频
            return;
        }
        //需要播放其他cell视频。则销毁c重来,page置0
        [self endDeceleratingPlay];
        page = 0;
    }else if(page<100){//是当前cell横向画滚动
        [self endDeceleratingPlay];;
    }
    _player = [[VideoPlayer alloc] init];
    UIScrollView *scr = [cell.contentView viewWithTag:555];
    ActorVideoView *videoIcon = [scr viewWithTag:4000+page];
    CGRect playerFrame = CGRectMake(videoIcon.x+15, 0, videoIcon.width-30, videoIcon.height);
    _player.frame = playerFrame;
    _player.isMute=[UserInfoManager getListPlayIsMute];
    _player.videoUrl =model.video;
    _player.playerLayer.masksToBounds=YES;
    _player.playerLayer.cornerRadius=5.0;
    _player.layer.masksToBounds=YES;
    _player.layer.cornerRadius=5.0;
    [_player playerBindTableView:self.tableV currentIndexPath:indexPath];
    
    [scr addSubview:_player];
    
    _player.completedPlayingBlock = ^(VideoPlayer *player) {
        [player destroyPlayer];
        player = nil;
    };
    WeakSelf(self);
    _player.dowmLoadBlock = ^{
        [weakself VideostatisticsWithWorkModel:model withType:2];
    };
    [self VideostatisticsWithWorkModel:model withType:1];
}

//结束播放
-(void)endDeceleratingPlay
{
    [_player.player.currentItem cancelPendingSeeks];
    [_player.player.currentItem.asset cancelLoading];
    [_player destroyPlayer];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [_player removeFromSuperview];
    _player =nil;
}

-(void)scrollViewEndScrollView
{
    if ([[NetworkNoti shareInstance]getNetworkStatus]==AFNetworkReachabilityStatusReachableViaWWAN && [UserInfoManager getWWanAuthPlay]==NO) {
        return;
    }
    else if ([[NetworkNoti shareInstance]getNetworkStatus]==AFNetworkReachabilityStatusReachableViaWiFi && [UserInfoManager getWifiAuthPlay]==NO)
    {
        return;
    }
    
    NSArray<NSIndexPath *> * cellArr = [self.tableV indexPathsForVisibleRows];
    if (cellArr.count>=2) {
        NSIndexPath * currentIndexPath = cellArr[cellArr.count - 2];
        if (self.currentIndexPath==currentIndexPath) {
            return;
        }
        if (cellArr.count==2 &&currentIndexPath.section==0) {
            return;
        }
        UserModel *userModel = self.dataSource[currentIndexPath.row];
        
        if (userModel.showList.count==0) {
            return;
        }
        
        long timeNow = (long)[[NSDate date] timeIntervalSince1970];
        long timeBefore = [UserInfoManager getLastedVideoPlayTime];
        if ((timeNow - timeBefore)>videoPlayMergin) {
         WorksModel *model = [[WorksModel alloc]init];
        NSDictionary *dic = userModel.showList[0];
        ActorVideoViewModel *videoModel = [ActorVideoViewModel yy_modelWithDictionary:dic];
       model.workType = videoModel.vtype;
        model.creativeid = [NSString stringWithFormat:@"%ld",videoModel.id];
        model.video = videoModel.videoUrl;
            if (videoModel.videoUrl.length<2) {
                return;
            }
         [UserInfoManager setLastestVideoPlayTime:timeNow];
        [self playVideoWithModel:model withIndexPath:currentIndexPath andPage:100];
    }
    }
}



//查看报价
-(void)lookUserPriceInfo:(UserInfoM *)info
{
    if ([UserInfoManager getUserLoginType]==UserLoginTypeTourist) {
        [SVProgressHUD showImage:nil status:@"登录后可查看报价！"];
        return;
    }
    
    //未认证成功，跳到认证界面
    if ([UserInfoManager getUserAuthState]!=1) {
        [SVProgressHUD showImage:nil status:@"认证后可查看报价！"];
        return;
    }
    
    [SVProgressHUD showImage:nil status:@"正在读取报价信息"];
    NSDictionary *dicArg = @{@"userid":info.UID};
    [AFWebAPI getQuotaListWithArg:dicArg callBack:^(BOOL success, id object) {
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *array =[object objectForKey:JSON_data];
            if (array.count>0) {
                LookPricePopV2 *popV= [[LookPricePopV2 alloc]init];
                [popV showWithArray:array];
                popV.placeActionBlockWithAudition = ^(PriceModel * _Nonnull model) {
                    PlaceShotOrderVC *shotVC=[[PlaceShotOrderVC alloc]init];
                    model.day=1;
                    shotVC.info=info;
                    shotVC.pModel=model;
                    [self.navigationController pushViewController:shotVC animated:YES];
                };
                popV.placeActionBlockWithScreening = ^(OrderStructM * _Nonnull model) {
                    PlaceAuditionOrderVC *auditVC = [[PlaceAuditionOrderVC alloc]init];
                    auditVC.info=info;
                    auditVC.sModel=model;
                    auditVC.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:auditVC animated:YES];
                };
            }
            else
            {
                [SVProgressHUD showImage:nil status:@"暂无报价！"];
                return;
            }
        }
        else
        {
            AF_SHOW_RESULT_ERROR
        }
    }];
}

#pragma mark --未认证，先去认证
-(void)goAuth
{
    if ([UserInfoManager getUserAuthState]==3){  //审核中
        [SVProgressHUD showImage:nil status:@"你的认证信息正在审核中，通过后才能查看报价！"];
        return;
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"去认证" message:@"认证通过之后您才能查看报价！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"去认证"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        
                                                        if ([UserInfoManager getUserAuthState]==0) {
                                                            AuthBuyerVC *authVC=[[AuthBuyerVC alloc]init];
                                                            authVC.hidesBottomBarWhenPushed=YES;
                                                            [self.navigationController pushViewController:authVC animated:YES];
                                                        }
                                                        else if ([UserInfoManager getUserAuthState]==2 || [UserInfoManager getUserAuthState]==3)
                                                        {
                                                            MyAuthStateVC *stateVC=[[MyAuthStateVC alloc]init];
                                                            stateVC.authState=[UserInfoManager getUserAuthState];
                                                            stateVC.hidesBottomBarWhenPushed=YES;
                                                            [self.navigationController pushViewController:stateVC animated:YES];
                                                        }
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_player playerScrollIsSupportSmallWindowPlay:NO];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSArray *subViews = scrollView.subviews;
    for (id sub in subViews) {
        if ([sub isKindOfClass:[ActorCell class]]) {
            ActorCell *cell = (ActorCell *)sub;
            [cell reloadOtherVideoViews];
        }
    }
    [self scrollViewEndScrollView];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSArray *subViews = scrollView.subviews;
    for (id sub in subViews) {
        if ([sub isKindOfClass:[ActorCell class]]) {
            ActorCell *cell = (ActorCell *)sub;
            [cell reloadOtherVideoViews];
        }
    }
    [self scrollViewEndScrollView];
}

//视频浏览量埋点统计
-(void)VideostatisticsWithWorkModel:(WorksModel*)model withType:(NSInteger)type
{
    if ([UserInfoManager getIsJavaService]) {
        NSDictionary *dicArg = @{@"vid":model.creativeid,
                                 @"vType":@(model.workType),
                                 @"numType":@(type),
                                 @"num":@(1)
                                 };
        [AFWebAPI_JAVA getVideoStatisticalWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
            }
            else{}
        }];
    }
    else
    {
        
        NSDictionary *dicArg = @{@"vid":model.creativeid,
                                 @"vtype":@(model.workType),
                                 @"type":@(type)};
        [AFWebAPI getVideoStatisticalWithArg:dicArg callBack:^(BOOL success, id object) {
            if (success) {
            }
            else{}
        }];
    }
}

@end
