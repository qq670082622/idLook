//
//  ActorSearchListvc.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/12.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ActorSearchListvc.h"
#import "ActorSearchCell.h"
#import "ActorSearchModel.h"
#import "ActorHomePage.h"
#import "NoVipPopV2.h"
#import "SearchHeaderView.h"
@interface ActorSearchListvc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet CustomTableV *tableV;
@property (weak, nonatomic) IBOutlet UILabel *searchResult;

@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSMutableArray *agencyList;
@property(nonatomic,assign)NSInteger sortPage;//页码
@end

@implementation ActorSearchListvc

- (void)viewDidLoad {
    [super viewDidLoad];
    _sortPage = 1;
      _dataSource = [NSMutableArray new];
    _agencyList = [NSMutableArray new];
    _tableV.tableFooterView = [UIView new];

   [_tableV addFooterWithTarget:self action:@selector(footSearch)];
    [self searchWithType:RefreshTypePullDown];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"搜索结果"]];
    }
-(void)searchWithType:(RefreshType)type
{
    WeakSelf(self);
    NSInteger sex = 0;
    if (_conditionModel.sex==0) {
        sex = 1;
    }else if (_conditionModel.sex==1){
        sex = 2;
    }
    if (type==RefreshTypePullUp) {//上拉
        _sortPage++;
    }else{//下拉
        _sortPage = 1;
        
    }
  
    NSDictionary *arg = @{
                          @"age":[NSString stringWithFormat:@"%ld-%ld",_conditionModel.age_min,_conditionModel.age_max],
                          @"height":[NSString stringWithFormat:@"%ld-%ld",_conditionModel.hei_min,_conditionModel.hei_max==0?200:_conditionModel.hei_max],
                          @"keyword":[_conditionModel.tags componentsJoinedByString:@","],
                          //@"occupation":@(0),
                         // @"price":[priceMuStr copy],
                          @"region":[_conditionModel.regions componentsJoinedByString:@","],
                          @"sex":@(sex),
                          @"platform":[_conditionModel.platTypes componentsJoinedByString:@","],
                          @"weight":[NSString stringWithFormat:@"%ld-%ld",_conditionModel.wei_min,_conditionModel.wei_max==0?120:_conditionModel.wei_max],
                          @"pageCount":@(25),
                          @"pageNumber":@(_sortPage),
                       //   @"order":@(_topSelect), //_topSelect==0是综合 ==1是价格
                        //  @"desc":@(_offerLowToHigh==YES?0:1)  //0降序 1升序
                          };
    [AFWebAPI_JAVA searchActorListWithArg:arg callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
             [_agencyList removeAllObjects];
            if (type==RefreshTypePullDown) {
                [self.dataSource removeAllObjects];
               }
            [_tableV hideNoDataScene];
            NSDictionary *body = object[@"body"];
            NSArray *infos = body[@"infos"];
            NSArray *agencys = body[@"agencyInfos"];
            for (NSDictionary *actorDic in infos) {
                ActorSearchModel *asModel = [ActorSearchModel yy_modelWithDictionary:actorDic];
                [_dataSource addObject:asModel];
            }
            for (NSDictionary *actorDic in agencys) {
                           ActorSearchModel *asModel = [ActorSearchModel yy_modelWithDictionary:actorDic];
                           [_agencyList addObject:asModel];
                       }
            if (_agencyList.count>0) {
                SearchHeaderView *head = [[SearchHeaderView alloc] init];
                head.list = _agencyList;
                head.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, head.headerHei);
                self.tableV.tableHeaderView = head;
                head.selectCell = ^(ActorSearchModel * _Nonnull model) {
                   ActorHomePage *hmpg = [ActorHomePage new];
                   
                     hmpg.actorId = model.userId;
                     hmpg.searchTag = [weakself.conditionModel.tags firstObject];
                     hmpg.reModel = ^(NSString * _Nonnull type, BOOL isTure) {//主页的点赞收藏回调
//                           ActorSearchModel *asModel = weakself.dataSource[indexPath.row];
//                         if ([type isEqualToString:@"收藏"]) {
//                             if (isTure) {
//                               asModel.isCollect = YES;
//                             }else{
//                                 asModel.isCollect = NO;
//                             }
//                         }else{//点赞
//                             asModel.isPraise = YES;
//                         }
                     };
                     hmpg.hidesBottomBarWhenPushed = YES;
                     [weakself.navigationController pushViewController:hmpg animated:YES];
                };
            }
            [self.tableV footerEndRefreshing];
            self.searchResult.text = [NSString stringWithFormat:@"共%ld个搜索结果",_dataSource.count+_agencyList.count];
            if (_dataSource.count==0 && _agencyList.count==0) {
                [_tableV showWithNoDataType:NoDataTypeSearchResult];
            }
            [self.tableV reloadData];
        }
    } ];
}

-(void)footSearch
{
    [self searchWithType:RefreshTypePullUp];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActorSearchCell *cell = [ActorSearchCell cellWithTableView:tableView];
    cell.model = _dataSource[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
//    NSInteger level = [UserInfoManager getUserVip];
//    level=300;
//    if (level != 301) {
//        NoVipPopV2 *pop = [[NoVipPopV2 alloc] init];
//        [pop show];
//        pop.apply = ^(NSString * _Nonnull name, NSString * _Nonnull phoneNum, NSString * _Nonnull remrak) {
//            NSInteger f = 6;
//        };
        
        
//        pop.selectType = ^(NSString * _Nonnull type) {
//            if ([type isEqualToString:@"contact"]) {//联系客服
//                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//                });
//            }else{//继续逛逛
//
//            }
//        };
//        return;
//    }
   
    
    ActorHomePage *hmpg = [ActorHomePage new];
    ActorSearchModel *model = _dataSource[indexPath.row];
    hmpg.actorId = model.userId;
    hmpg.searchTag = [_conditionModel.tags firstObject];
    hmpg.reModel = ^(NSString * _Nonnull type, BOOL isTure) {
          ActorSearchModel *asModel = weakself.dataSource[indexPath.row];
        if ([type isEqualToString:@"收藏"]) {
            if (isTure) {
              asModel.isCollect = YES;
            }else{
                asModel.isCollect = NO;
            }
        }else{//点赞
            asModel.isPraise = YES;
        }
    };
    hmpg.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hmpg animated:YES];
}
- (void)onGoback
{
  
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
