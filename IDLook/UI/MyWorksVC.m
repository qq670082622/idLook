//
//  MyWorksVC.m
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "MyWorksVC.h"
#import "MyworksTopV.h"
#import "MyworksBottomV.h"
#import "WorksManager.h"
#import "WorkCellA.h"
#import "WorkCellB.h"
#import "MyWorkHeadView.h"
#import "UploadWorksVC.h"
#import "WorksVCM.h"
#import "ModifyWorksVC.h"

@interface MyWorksVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)MyworksTopV *topV;
@property (nonatomic,strong)MyworksBottomV *bottomV;
@property (nonatomic,strong)UIScrollView *scrollV;
@property(nonatomic,strong)UIButton *addBtn;
@property (nonatomic,assign)NSInteger currIndex;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)WorksManager *manager;
@property (nonatomic,strong)WorksVCM *dataM;
@end

@implementation MyWorksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=Public_Background_Color;
    [self.navigationItem setTitleView:[CustomNavVC setDefaultNavgationItemTitle:@"作品上传"]];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[CustomNavVC getLeftDefaultButtonWithTarget:self action:@selector(onGoback)]]];
    
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:self.rightBtn]];
    
    [self.dataM refreshWorksInfo];
    [self manager];
    [self topV];
    [self scrollV];
    [self addBtn];
    [self bottomV];
}

-(void)onGoback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//查看作品
-(void)lookWorksWithInfo:(WorksModel*)model
{
    ModifyWorksVC *lookVC=[[ModifyWorksVC alloc]init];
    lookVC.model=model;
    WeakSelf(self);
    lookVC.saveRefreshUI = ^{
        [weakself.dataM refreshWorksInfo];
    };
    [self.navigationController pushViewController:lookVC animated:YES];
}

-(WorksVCM*)dataM
{
    if (!_dataM) {
        _dataM  = [[WorksVCM alloc]init];
        WeakSelf(self);
        _dataM.refreshUIAction = ^(BOOL isAll) {
            if (isAll) {  //刷新全部collectionview
                [weakself reloadCollectionWithType:0];
                [weakself reloadCollectionWithType:1];
                [weakself reloadCollectionWithType:2];
                [weakself reloadCollectionWithType:3];

            }
            else  //刷新一个
            {
                [weakself reloadCollectionWithType:weakself.currIndex];
                [weakself managerAction:weakself.rightBtn];
            }
            [weakself isShowRightBtn];
        };
    }
    return _dataM;
}

//管理
-(void)managerAction:(UIButton*)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.addBtn.hidden=YES;
        self.bottomV.hidden=NO;
        self.scrollV.frame=CGRectMake(0, 40, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight-40-50);
        self.bottomV.allBtn.selected = [self.dataM isAllChooseWithTag:self.currIndex];

    }
    else
    {
        self.addBtn.hidden=NO;
        self.bottomV.hidden=YES;
        self.scrollV.frame=CGRectMake(0, 40, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight-40);
    }
    
    [self.dataM allChooseWithTag:self.currIndex withSelect:NO];

    [self.dataM getEditStateWithTag:self.currIndex withEdit:sender.selected];
    [[self correspondingCollectionViewWithTag:self.currIndex] reloadData];
}

-(WorksManager*)manager
{
    if (!_manager) {
        _manager=[[WorksManager alloc]init];
        _manager.dataM=self.dataM;
        WeakSelf(self);
        _manager.chooseAction = ^(BOOL select, NSIndexPath *indexPath) {
            [weakself.dataM changeoneDataWithTag:weakself.currIndex withIndaxPath:indexPath withSelect:select];
            [[weakself correspondingCollectionViewWithTag:weakself.currIndex] reloadData];
            weakself.bottomV.allBtn.selected = [weakself.dataM isAllChooseWithTag:weakself.currIndex];
        };
        _manager.playAction = ^(WorksModel *model) {
            [weakself lookWorksWithInfo:model];
        };
    }
    return _manager;
}

-(UIButton*)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(0, 0, 48, 48);
        [_rightBtn setTitle:@"管理" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"完成" forState:UIControlStateSelected];
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_rightBtn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(managerAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rightBtn;
}

-(MyworksTopV*)topV
{
    if (!_topV) {
        _topV=[[MyworksTopV alloc]init];
        [self.view addSubview:_topV];
        [_topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(1);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(45);
        }];
        WeakSelf(self);
        _topV.worksClickTypeBlock = ^(NSInteger type) {
            if (weakself.currIndex!=type) {
                [weakself.scrollV setContentOffset:CGPointMake(UI_SCREEN_WIDTH*type, 0) animated:YES];
                weakself.currIndex=type;
                [weakself.topV slideWithTag:type];
            }
        };
    }
    return _topV;
}

-(MyworksBottomV*)bottomV
{
    if (!_bottomV) {
        _bottomV=[[MyworksBottomV alloc]init];
        [self.view addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(50);
        }];
        _bottomV.hidden=YES;
        WeakSelf(self);
        _bottomV.chooseAllBlock = ^(BOOL select) { //全选，取消
            [weakself.dataM allChooseWithTag:weakself.currIndex withSelect:select];
            [[weakself correspondingCollectionViewWithTag:weakself.currIndex] reloadData];
        };
        _bottomV.delectBlock = ^{    //删除
            [weakself delectAction];
        };
    }
    return _bottomV;
}

-(UIButton*)addBtn
{
    if (!_addBtn) {
        _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"works_add_btn"] forState:UIControlStateNormal];
        [self.view addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
        [_addBtn addTarget:self action:@selector(addworks) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIScrollView *)scrollV
{
    if(!_scrollV)
    {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 55, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-SafeAreaTopHeight-55)];
        _scrollV.delegate = self;
        _scrollV.pagingEnabled=YES;
        _scrollV.scrollEnabled = NO;
        _scrollV.backgroundColor = [UIColor clearColor];
        _scrollV.showsHorizontalScrollIndicator = YES;
        _scrollV.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollV];
        _scrollV.contentSize = CGSizeMake(UI_SCREEN_WIDTH*4, 0);
        
        for (int i =0; i<4; i++) {
            UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            
            CustomCollectV *collectV = [[CustomCollectV alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*i, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-55-SafeAreaTopHeight)
                                                            collectionViewLayout:flowLayout];
            collectV.dataSource=self.manager;
            collectV.delegate=self.manager;
            collectV.tag=i+100;
            [collectV setBackgroundColor:[UIColor whiteColor]];
            collectV.alwaysBounceVertical = YES; //当contentsize小于collectionview尺寸时，垂直方向添加弹簧效果

            [collectV registerClass:[WorkCellA class] forCellWithReuseIdentifier:@"WorkCellA"];
            [collectV registerClass:[WorkCellB class] forCellWithReuseIdentifier:@"WorkCellB"];
            [collectV registerClass:[MyWorkHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];

            [_scrollV addSubview:collectV];
        
        }
    }
    return _scrollV;
}

//是否显示管理按钮
-(void)isShowRightBtn
{
    if ([self.dataM.ds[self.currIndex]count]==0) {
        [self.navigationItem setRightBarButtonItem:nil];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:self.rightBtn]];

    }
}

//刷新一个collectiov
-(void)reloadCollectionWithType:(NSInteger)type
{
    CustomCollectV *collectV = [self correspondingCollectionViewWithTag:type];
    
    if ([self.dataM.ds[type]count]==0) {
        [collectV showWithNoDataType:NoDataTypeWorks];
        collectV.backgroundColor = [UIColor clearColor];
    }
    else
    {
        [collectV hideNoDataScene];
        collectV.backgroundColor = [UIColor whiteColor];
    }
    [collectV reloadData];

}

//根据tag得到当前collectionview
-(CustomCollectV*)correspondingCollectionViewWithTag:(NSInteger)tag
{
    CustomCollectV *collectionView=[self.scrollV viewWithTag:tag+100];
    return collectionView;
}

#pragma mark----Action
//添加新作品
-(void)addworks
{
    UploadWorksVC *uploadVC = [[UploadWorksVC alloc]init];
    uploadVC.type=self.currIndex;
    WeakSelf(self);
    uploadVC.saveRefreshUI = ^{
        [weakself.dataM refreshWorksInfo];
    };
    [self.navigationController pushViewController:uploadVC animated:YES];
}

//删除
-(void)delectAction
{
    if (self.dataM.selectDatasource.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择要删除的作品"];
        return;
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"删除" message:@"确定要删除作品吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self delectWorks];
                                                    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{}];
}

//确认删除
-(void)delectWorks
{
     [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    [self.dataM delectWorksWithType:self.currIndex];
}

@end