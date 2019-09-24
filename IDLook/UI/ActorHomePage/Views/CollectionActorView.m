//
//  CollectionActorView.m
//  IDLook
//
//  Created by 吴铭 on 2019/9/20.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "CollectionActorView.h"
#import "CollectionActorCell.h"
#import "ActorSearchModel.h"
@interface CollectionActorView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *maskV;
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableArray *selectArr;
@property(nonatomic,assign)NSInteger noSystemId;
@end
@implementation CollectionActorView

- (id)init
{
    if(self=[super init])
    {
        self.data = [NSMutableArray new];
        self.selectArr = [NSMutableArray new];
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
     
    }
    return self;
}
-(void)showWithSelectActors:(NSArray *)actorArr noSystemId:(NSInteger)Id
{
    _noSystemId = Id;
    [self.selectArr addObjectsFromArray:actorArr];
    UIWindow *showWindow = nil;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            showWindow = window;
            break;
        }
    }
    if(!showWindow)return;
    
    UIView *maskV = [[UIView alloc] initWithFrame:showWindow.bounds];
    maskV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
    maskV.alpha = 0.f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.numberOfTapsRequired = 1;
    [maskV addGestureRecognizer:tap];
    
    
    [showWindow addSubview:maskV];
    self.frame=CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-55);
    [showWindow addSubview:self];
    self.maskV=maskV;
    [self initUI];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    maskV.alpha = 1.f;
    self.frame = CGRectMake(0, 55, UI_SCREEN_WIDTH,UI_SCREEN_HEIGHT-55);
    
    [UIView commitAnimations];
}

- (void)initUI
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"收藏夹";
    titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    titleLabel.textColor = Public_Text_Color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 12, UI_SCREEN_WIDTH, 24);
    [self addSubview:titleLabel];
    
    UIButton *closeBtn = [UIButton buttonWithType:0];
    [closeBtn setImage:[UIImage imageNamed:@"customized_pupup_close_icon"] forState:0];
    //[closeBtn setBackgroundImage:[UIImage imageNamed:@"icon_huangclose"] forState:0];
    closeBtn.frame = CGRectMake(UI_SCREEN_WIDTH-35, 0, 35, 35);
    [closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    _tableV = [CustomTableV new];
    _tableV.frame = CGRectMake(0, 50, UI_SCREEN_WIDTH, self.height-50-83);
    _tableV.tableFooterView = [UIView new];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self addSubview:_tableV];
    
    UIButton *sureBtn = [UIButton buttonWithType:0];
    [sureBtn setTitle:@"确定" forState:0];
    [sureBtn setTintColor:[UIColor whiteColor]];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [sureBtn setBackgroundColor:Public_Red_Color];
    sureBtn.layer.cornerRadius = 6;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.frame = CGRectMake(19, _tableV.bottom+15, UI_SCREEN_WIDTH-38, 48);
    [sureBtn addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
    [AFWebAPI_JAVA checkCollectionActorsWithArg:[NSDictionary new] callBack:^(BOOL success, id  _Nonnull object) {
        if (success) {
            NSArray *list = object[@"body"];
            for (NSDictionary *actorDic in list) {
                ActorSearchModel *model = [ActorSearchModel yy_modelWithDictionary:actorDic];
                for ( ActorSearchModel *selectModel in _selectArr) {
                    if (selectModel.userId == model.userId) {
                        model.isSelected = YES;
                    }
                  }
              [self.data addObject:model];
            }
            [self.tableV reloadData];
        }
    }];
}
-(void)ensure
{
    [_selectArr removeAllObjects];
    for (ActorSearchModel *model in _data) {
        if (model.isSelected) {
            [_selectArr addObject:model];
        }
    }
    self.selectActors(_selectArr);
    [self hide];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionActorCell *cell = [CollectionActorCell cellWithTableView:tableView];
    ActorSearchModel *model = _data[indexPath.row];
    if ( model.userId == _noSystemId) {
        cell.noSystem = YES;
    }
   cell.model = _data[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActorSearchModel *model = _data[indexPath.row];
    if ( model.userId == _noSystemId) {
        return;
    }
    if (model.isSelected) {
        model.isSelected = NO;
    }else{
        model.isSelected = YES;
    }
    [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)hide
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.25];
    [UIView setAnimationCurve:7];
    
    [UIView setAnimationDelegate:self];
    //   [UIView setAnimationDidStopSelector:@selector(clearSubV)];
    self.maskV.alpha = 0.f;
    [self.maskV removeFromSuperview];
    [self.tableV removeFromSuperview];
    [self removeFromSuperview];
    [UIView commitAnimations];
}
@end
