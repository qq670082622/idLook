//
//  PlaceAuditCellA.m
//  IDLook
//
//  Created by HYH on 2018/6/19.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PlaceAuditCellA.h"

@interface PlaceAuditCellA ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSArray *dataSource;
@end


@implementation PlaceAuditCellA

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self tableV];
    }
    return self;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.showsVerticalScrollIndicator = NO;
//        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableV.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _tableV.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 115);
        [self.contentView addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor whiteColor];
        
    }
    return _tableV;
}

-(void)reloadUIWithArray:(NSArray *)array
{
    self.dataSource = array;
    [self.tableV reloadData];
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
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"UITableViewCell";
    PlaceAuditSubCellA *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[PlaceAuditSubCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.transform = CGAffineTransformMakeRotation(M_PI_2);

    }
    WeakSelf(self);
    cell.ArtistDelect = ^{
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(delectArtistWithIndex:)]) {
            [weakself.delegate delectArtistWithIndex:indexPath.row];
        }
    };
    
    if (indexPath.row<self.dataSource.count) {
        [cell reloadUIWithUserInfo:self.dataSource[indexPath.row] WithIndex:indexPath.row];
    }
    else
    {
        [cell reloadUIWithUserInfo:nil WithIndex:indexPath.row];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==self.dataSource.count) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(addArtist)]) {
            [self.delegate addArtist];
        }
    }
}


@end

@interface PlaceAuditSubCellA ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *delectBtn;

@end

@implementation PlaceAuditSubCellA

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.cornerRadius=27.5;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(20);
            make.top.mas_equalTo(self.contentView).offset(20);
            make.size.mas_equalTo(CGSizeMake(55, 55));
        }];
    }
    return _icon;
}


-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:12.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.icon.mas_bottom).offset(10);
        }];
    }
    return _titleLab;
}

-(UIButton*)delectBtn
{
    if (!_delectBtn) {
        _delectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_delectBtn setBackgroundImage:[UIImage imageNamed:@"order_artist_delect"] forState:UIControlStateNormal];
        [_delectBtn setBackgroundImage:[UIImage imageNamed:@"order_artist_delect"] forState:UIControlStateSelected];
        [self.contentView addSubview:_delectBtn];
        [_delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon.mas_top).offset(5);
            make.centerX.mas_equalTo(self.icon.mas_right);
        }];
        [_delectBtn addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectBtn;
}


-(void)reloadUIWithUserInfo:(UserInfoM *)info WithIndex:(NSInteger)index
{
    if (info==nil) {
        self.icon.image=[UIImage imageNamed:@"order_artist_add"];
        self.titleLab.text=@"添加其他艺人";
        self.titleLab.textColor=[UIColor colorWithHexString:@"#999999"];
        self.delectBtn.hidden=YES;
    }
    else
    {
        
        [self.icon sd_setImageWithUrlStr:info.head placeholderImage:[UIImage imageNamed:@"default_icon"]];
        self.titleLab.text = info.nick;
        self.titleLab.textColor=Public_Text_Color;
        if (index==0) {
            self.delectBtn.hidden=YES;
        }
        else
        {
            self.delectBtn.hidden=NO;
        }
    }
}

-(void)delectAction
{
    self.ArtistDelect();
}

@end

