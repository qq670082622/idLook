//
//  ChoseIdentityTypeV.m
//  IDLook
//
//  Created by HYH on 2018/5/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "ChoseIdentityTypeV.h"
#import "IdentitySubCell.h"

@interface ChoseIdentityTypeV ()<IdentitySubViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)IdentitySubView *step1V;   //第一步选择视图
@property(nonatomic,strong)UITableView *step2V;  //第二步选择视图
@property(nonatomic,strong)IdentitySubView *step3V;       //第三步选择视图

@property(nonatomic,strong)NSArray *userTypeDataS;
@property(nonatomic,strong)NSArray *userSubTypeDataS;

@property(nonatomic,assign)NSInteger step1Index;   //第一步选择的什么
@property(nonatomic,assign)NSInteger step2Index;  //第二步选择的什么
@property(nonatomic,assign)NSInteger step3Index;  //第三步选择的什么

@property(nonatomic,assign)NSInteger step;    //第几步

@end

@implementation ChoseIdentityTypeV

-(void)layoutIfNeeded
{
    [super layoutIfNeeded];
    
//    self.backgroundColor=[UIColor redColor];
    
    self.step=0;
    self.step1Index=0;
    self.step2Index=0;
    self.step3Index=0;
    
    self.userTypeDataS =@[@{@"UserType":@(UserTypePurchaser),@"UserTypeName":@"购买方"},
                          @{@"UserType":@(UserTypeResourcer),@"UserTypeName":@"资源方"}];
    
    self.userSubTypeDataS = @[
                              @[
                                  @{@"UserSubTypeName":@"个人",@"subType":
                                        @[@{@"UserSubType":@(UserSubTypePurPersonal),@"UserSubTypeName":@"个人"}]},
                                  @{@"UserSubTypeName":@"制作公司",@"subType":
                                        @[@{@"UserSubType":@(UserSubTypePurProductionCompanyPhotography),@"UserSubTypeName":@"平面摄影"},
                                          @{@"UserSubType":@(UserSubTypePurProductionCompanyFilm),@"UserSubTypeName":@"影视制作"},
                                          @{@"UserSubType":@(UserSubTypePurProductionCompanyDesign),@"UserSubTypeName":@"设计公司"}]},
                                  @{@"UserSubTypeName":@"广告代理商",@"subType":
                                        @[@{@"UserSubType":@(UserSubTypePurAdvertisingAgent),@"UserSubTypeName":@"广告代理"},
                                          @{@"UserSubType":@(UserSubTypePurAdvertisingAgentDigital),@"UserSubTypeName":@"digital数字营销"}]},
                                  @{@"UserSubTypeName":@"公关公司",@"subType":
                                        @[@{@"UserSubType":@(UserSubTypePurRelationsService),@"UserSubTypeName":@"公关服务"},
                                          @{@"UserSubType":@(UserSubTypePurRelationsEconomy),@"UserSubTypeName":@"公关经纪"}]},
                                  @{@"UserSubTypeName":@"活动公司",@"subType":
                                        @[@{@"UserSubType":@(UserSubTypePurEventPlanning),@"UserSubTypeName":@"活动策划"},
                                          @{@"UserSubType":@(UserSubTypePurActivityService),@"UserSubTypeName":@"活动服务"}]},
                                  @{@"UserSubTypeName":@"企业品牌部/策划部/市场部",@"subType":
                                        @[@{@"UserSubType":@(UserSubTypePurBusinessBrand),@"UserSubTypeName":@"企业品牌部/策划部/市场部"}]}
                                  ],
                              
                              @[
                                  @{@"UserSubTypeName":@"演员模特",@"subType":
                                        @[@{@"UserSubType":@(UserSubTypeResActorModel),@"UserSubTypeName":@"演员模特"}]}
//                                  @{@"UserSubTypeName":@"明星艺人",@"subType":
//                                        @[@{@"UserSubType":@(UserSubTypeResStarArtistPersonal),@"UserSubTypeName":@"个人"},
//                                          @{@"UserSubType":@(UserSubTypeResStarArtistCompany),@"UserSubTypeName":@"经纪公司"}]},
//                                  @{@"UserSubTypeName":@"网络红人",@"subType":
//                                        @[@{@"UserSubType":@(UserSubTypeResICPersonal),@"UserSubTypeName":@"个人"},
//                                          @{@"UserSubType":@(UserSubTypeResICCompany),@"UserSubTypeName":@"经纪公司"}]},
//                                  @{@"UserSubTypeName":@"体育明星",@"subType":
//                                        @[@{@"UserSubType":@(UserSubTypeResSportsStarsPersonal),@"UserSubTypeName":@"个人"},
//                                          @{@"UserSubType":@(UserSubTypeResSportsStarsCompany),@"UserSubTypeName":@"机构"}]}
                                  ]
                              ];
}

-(IdentitySubView*)step1V
{
    if (!_step1V) {
        _step1V=[[IdentitySubView alloc]init];
        [self addSubview:_step1V];
        _step1V.delegate=self;
        [_step1V mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
    }
    return _step1V;
}

-(UITableView*)step2V
{
    if (!_step2V) {
        _step2V=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:_step2V];
        _step2V.delegate=self;
        _step2V.dataSource=self;
        _step2V.estimatedRowHeight = 0;
        _step2V.estimatedSectionHeaderHeight = 0;
        _step2V.estimatedSectionFooterHeight = 0;
        _step2V.separatorStyle=UITableViewCellSeparatorStyleNone;
        _step2V.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _step2V.backgroundColor=[UIColor redColor];
        [_step2V mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];

    }
    return _step2V;
}


-(IdentitySubView*)step3V
{
    if (!_step3V) {
        _step3V=[[IdentitySubView alloc]init];
        [self addSubview:_step3V];
        _step3V.delegate=self;
        [_step3V mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
        }];
        _step3V.hidden=YES;
    }
    return _step3V;
}

-(void)reloadUI
{
     [self.step1V initUIWithArray:[self getDataWithStep:self.step]];
}

#pragma mark --- IdentitySubViewDelegate
-(void)choseidentitywithtype:(NSInteger)type
{
    if (self.step==0)
    {
        self.step1Index=type;
        self.step1V.hidden=YES;
        self.step2V.hidden=NO;
        self.step3V.hidden=YES;
        
        self.step++;
        [self.step2V reloadData];
    }
    else if (self.step==1)
    {
        self.step2Index=type;
        
        NSArray *array = [self getDataWithStep:self.step+1];
        if (array.count==1) {
            
            NSString *str1 = self.userTypeDataS[self.step1Index][@"UserTypeName"];
            NSString *str2= self.userSubTypeDataS[self.step1Index][self.step2Index][@"UserSubTypeName"];
            NSInteger subType = [self.userSubTypeDataS[self.step1Index][self.step2Index][@"subType"][self.step3Index][@"UserSubType"] integerValue];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(choseIdentityWithType:withSubType:withContent:)]) {
                [self.delegate choseIdentityWithType:self.step1Index withSubType:subType withContent:[NSString stringWithFormat:@"%@(%@)",str1,str2]];
            }
            return;
        }
        
        self.step1V.hidden=YES;
        self.step2V.hidden=YES;
        self.step3V.hidden=NO;
        
        self.step++;
        [self.step3V initUIWithArray:[self getDataWithStep:self.step]];
        
    }
    else if (self.step==2)
    {
        self.step3Index=type;

        NSString *str1 = self.userTypeDataS[self.step1Index][@"UserTypeName"];
        NSString *str2= self.userSubTypeDataS[self.step1Index][self.step2Index][@"UserSubTypeName"];
        NSString *str3 = self.userSubTypeDataS[self.step1Index][self.step2Index][@"subType"][self.step3Index][@"UserSubTypeName"];
        NSInteger subType = [self.userSubTypeDataS[self.step1Index][self.step2Index][@"subType"][self.step3Index][@"UserSubType"] integerValue];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(choseIdentityWithType:withSubType:withContent:)]) {
            [self.delegate choseIdentityWithType:self.step1Index withSubType:subType withContent:[NSString stringWithFormat:@"%@(%@)",str2,str3]];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(isShowLastStep:)]) {
        [self.delegate isShowLastStep:self.step];
    }
    

    
}

//上一步
-(void)lastStepAction
{

    if (self.step==1) {
        self.step--;
        self.step1V.hidden=NO;
        self.step2V.hidden=YES;
        self.step3V.hidden=YES;
    }
    else if (self.step==2)
    {
        self.step--;

        self.step1V.hidden=YES;
        self.step2V.hidden=NO;
        self.step3V.hidden=YES;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(isShowLastStep:)]) {
        [self.delegate isShowLastStep:self.step];
    }
}

-(void)cancle
{
    if (self.step<=1) {
        return;
    }
    if (self.step==1) {
        self.step2Index=0;
    }
    else if (self.step==2)
    {
        self.step3Index=0;
    }
//    self.step--;
}

-(NSArray*)getDataWithStep:(NSInteger)step
{
    NSMutableArray *dataS = [[NSMutableArray alloc]initWithCapacity:0];

    if (step==0) {
        NSArray *array = self.userTypeDataS;
        for (int i =0 ; i<array.count; i++) {
            NSDictionary *dic = array[i];
            [dataS addObject:dic[@"UserTypeName"]];
        }
        
    }
    else if(step==1)
    {
        NSArray *array = self.userSubTypeDataS[self.step1Index];
        for (int i =0 ; i<array.count; i++) {
            NSDictionary *dic = array[i];
            [dataS addObject:dic[@"UserSubTypeName"]];
        }
    }
    else if (step==2)
    {
        NSArray *array = self.userSubTypeDataS[self.step1Index][self.step2Index][@"subType"];
        for (int i =0 ; i<array.count; i++) {
            NSDictionary *dic = array[i];
            [dataS addObject:dic[@"UserSubTypeName"]];
        }
    }
    return dataS;
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
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getDataWithStep:self.step].count * 80 + 30; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"IdentitySubCell";
    IdentitySubCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[IdentitySubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        __weak __typeof(self)ws=self;
        cell.IdentitySubCellBlock = ^(NSInteger Type) {
            [ws choseidentitywithtype:Type];
        };
    }
    [cell reloadUIWithArray:[self getDataWithStep:self.step]];
    return cell;
}

@end

@interface IdentitySubView ()
@property(nonatomic,strong)NSArray *dataS;
@end

@implementation IdentitySubView

-(void)initUIWithArray:(NSArray*)array
{
    self.dataS=array;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIImage *image = [UIImage imageNamed:@"chose_type_n"];
    CGFloat height =image.size.height;
    CGFloat width =image.size.width;
    for (int i =0 ; i<array.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        
        [self addSubview:button];
        
        button.layer.cornerRadius=5.0;
        button.layer.masksToBounds=YES;
        button.layer.borderColor=[UIColor colorWithHexString:@"#E2E2E2"].CGColor;
        button.layer.borderWidth=0.5;
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#FBFBFB"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"chose_type_n"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"chose_type_h"] forState:UIControlStateHighlighted];

        [button setTitle:array[i] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(85+(height+25)*i);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        [button addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)clickType:(UIButton*)sender
{
    
//    for (int i =0 ; i<self.dataS.count; i++)
//    {
//        UIButton * button = (UIButton*)[self viewWithTag:100+i];
//        if (i==(sender.tag-100)) {
//            button.selected=YES;
//        }
//        else
//        {
//            button.selected=NO;
//        }
//    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseidentitywithtype:)]) {
        [self.delegate choseidentitywithtype:sender.tag-100];
    }
}

@end
