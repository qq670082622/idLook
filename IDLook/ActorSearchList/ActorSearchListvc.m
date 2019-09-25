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
#import "NoVipPopV.h"
@interface ActorSearchListvc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet CustomTableV *tableV;
@property (weak, nonatomic) IBOutlet UILabel *searchResult;

@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger sortPage;//页码
@end

@implementation ActorSearchListvc

- (void)viewDidLoad {
    [super viewDidLoad];
    _sortPage = 1;
      _dataSource = [NSMutableArray new];
    _tableV.tableFooterView = [UIView new];

   [_tableV addFooterWithTarget:self action:@selector(footSearch)];
    [self searchWithType:RefreshTypePullDown];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"搜索结果"]];
    }
-(void)searchWithType:(RefreshType)type
{
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
            if (type==RefreshTypePullDown) {
                [self.dataSource removeAllObjects];
            }
            NSArray *list = object[@"body"];
            for (NSDictionary *actorDic in list) {
                ActorSearchModel *asModel = [ActorSearchModel yy_modelWithDictionary:actorDic];
                [_dataSource addObject:asModel];
            }
            [self.tableV footerEndRefreshing];
            self.searchResult.text = [NSString stringWithFormat:@"共%ld个搜索结果",_dataSource.count];
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
    NSInteger level = [UserInfoManager getUserVip];
    if (level != 301) {
        NoVipPopV *pop = [[NoVipPopV alloc] init];
        [pop show];
        pop.selectType = ^(NSString * _Nonnull type) {
            if ([type isEqualToString:@"contact"]) {//联系客服
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",@"400-833-6969"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                });
            }else{//继续逛逛
                
            }
        };
        return;
    }
   
    
    ActorHomePage *hmpg = [ActorHomePage new];
    ActorSearchModel *model = _dataSource[indexPath.row];
    hmpg.actorId = model.userId;
    hmpg.reloadCell = ^(NSInteger index) {
        [weakself.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    hmpg.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hmpg animated:YES];
}
- (void)onGoback
{
  
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
