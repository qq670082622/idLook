//
//  UserInfoCellB.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserInfoCellB.h"
#import "WorksModel.h"

@interface UserInfoCellB ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSArray *dataSource;

@end

@implementation UserInfoCellB

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont boldSystemFontOfSize:13.0];
        _titleLab.textColor=Public_Text_Color;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _titleLab;
}

-(CustomTableV*)tableV
{
    if (!_tableV) {
        _tableV = [[CustomTableV alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableV.showsVerticalScrollIndicator = NO;
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(46);
        }];
    }
    return _tableV;
}

-(void)reloadUIWithArray:(NSArray *)array withMastery:(NSInteger)mastery
{
    NSString *title =@"";
    if (mastery==2) {
        title = @"剧照";
    }
    else
    {
        title =@"模特卡";
    }
    
    NSString *str=[NSString stringWithFormat:@"%@(%ld张)",title,array.count];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]} range:NSMakeRange(0,title.length)];
    self.titleLab.attributedText=attStr;
    
    self.dataSource=array;
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
    return (UI_SCREEN_WIDTH-30)/1.4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"UserInfoModelCardSubCell";
    UserInfoModelCardSubCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell)
    {
        cell = [[UserInfoModelCardSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    [cell reloadUIWithModel:self.dataSource[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = [NSMutableArray new];
    for (int i =0; i<self.dataSource.count; i++) {
        WorksModel *model = self.dataSource[i];
        [array addObject:model.imageurl];
    }
    
    if (self.lookBigModelCardPhoto) {
        self.lookBigModelCardPhoto(array, indexPath.row);
    }
}

@end

@interface UserInfoModelCardSubCell ()
@property(nonatomic,strong)UIImageView *icon;
@end

@implementation UserInfoModelCardSubCell

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.cornerRadius=5.0;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.contentView).offset(5);
            make.bottom.mas_equalTo(self.contentView).offset(-5);
        }];
    }
    return _icon;
}

-(void)reloadUIWithModel:(WorksModel*)model
{
    [self.icon sd_setImageWithUrlStr:model.imageurl placeholderImage:[UIImage imageNamed:@"default_video"]];
}

@end
