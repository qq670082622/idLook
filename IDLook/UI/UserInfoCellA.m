//
//  UserInfoCellA.m
//  IDLook
//
//  Created by Mr Hu on 2018/10/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UserInfoCellA.h"

@interface UserInfoCellA ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)CustomTableV *tableV;
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,assign)UserInfoCellType type;
@property(nonatomic,assign)NSInteger pastworkType;
@property(nonatomic,strong)UIButton *videoBtn;
@property(nonatomic,strong)UIButton *photoBtn;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UILabel *lineLab;

@end

@implementation UserInfoCellA

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

-(UIButton*)videoBtn
{
    if (!_videoBtn) {
        _videoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_videoBtn];
        _videoBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [_videoBtn setTitle:@"视频" forState:UIControlStateNormal];
        [_videoBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
        [_videoBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [_videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.photoBtn.mas_left).offset(-32);
            make.centerY.mas_equalTo(self.titleLab);
        }];
        [_videoBtn addTarget:self action:@selector(buttionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoBtn;
}

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"btn_select_1_h1"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.videoBtn);
            make.top.mas_equalTo(self.videoBtn.mas_bottom).offset(-5);
        }];
    }
    return _arrow;
}

-(UILabel*)lineLab
{
    if (!_lineLab) {
        _lineLab=[[UILabel alloc]init];
        [self.contentView addSubview:_lineLab];
        _lineLab.font=[UIFont boldSystemFontOfSize:13.0];
        _lineLab.text=@"/";
        _lineLab.textColor=[UIColor colorWithHexString:@"#CCCCCC"];
        [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.left.mas_equalTo(self.photoBtn.mas_left).offset(-15);
        }];
    }
    return _lineLab;
}

-(UIButton*)photoBtn
{
    if (!_photoBtn) {
        _photoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_photoBtn];
        _photoBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [_photoBtn setTitle:@"图片" forState:UIControlStateNormal];
        [_photoBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
        [_photoBtn setTitleColor:Public_Red_Color forState:UIControlStateSelected];
        [_photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.titleLab);
        }];
        [_photoBtn addTarget:self action:@selector(buttionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoBtn;
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
        _tableV.frame = CGRectMake(0,46, UI_SCREEN_WIDTH, 145);
        [self.contentView addSubview:_tableV];
        _tableV.estimatedRowHeight = 0;
        _tableV.alwaysBounceVertical=YES;
        _tableV.estimatedSectionHeaderHeight = 0;
        _tableV.estimatedSectionFooterHeight = 0;
        _tableV.backgroundColor=[UIColor clearColor];
    }
    return _tableV;
}

-(void)reloadUIWithArray:(NSArray *)array withType:(UserInfoCellType)type witPastworkType:(NSInteger)pastworkType
{
    self.type=type;
    self.pastworkType=pastworkType;
    if (type==UserInfoCellTypePerformType) {
        self.dataSource = array;
        NSString *str=[NSString stringWithFormat:@"试戏视频(%ld个)",array.count];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]} range:NSMakeRange(0,4)];
        self.titleLab.attributedText=attStr;
        self.arrow.hidden=YES;
        self.photoBtn.hidden=YES;
        self.videoBtn.hidden=YES;
        self.lineLab.hidden=YES;
    }
    else if (type==UserInfoCellTypeIntroduce)
    {
        self.dataSource = array;
        NSString *str=[NSString stringWithFormat:@"自我介绍(%ld个)",array.count];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]} range:NSMakeRange(0,4)];
        self.titleLab.attributedText=attStr;
        self.arrow.hidden=YES;
        self.photoBtn.hidden=YES;
        self.videoBtn.hidden=YES;
        self.lineLab.hidden=YES;
    }
    else if (type==UserInfoCellTypePastWorkVideo)
    {
        self.arrow.hidden=NO;
        self.photoBtn.hidden=NO;
        self.videoBtn.hidden=NO;
        self.lineLab.hidden=NO;
        
        NSInteger count=0;
        if (array.count==1) {
            self.arrow.hidden=YES;
            self.photoBtn.hidden=YES;
            self.videoBtn.hidden=YES;
            self.lineLab.hidden=YES;
            self.pastworkType = [[array firstObject][@"type"]integerValue];
            self.dataSource = [array firstObject][@"data"];
            count =self.dataSource.count;
        }
        else
        {
            if (self.pastworkType==0) {
                self.dataSource = [array firstObject][@"data"];
                self.tableV.frame = CGRectMake(0,46, UI_SCREEN_WIDTH, 145);
            }
            else
            {
                self.dataSource = [array lastObject][@"data"];
                self.tableV.frame = CGRectMake(0,46, UI_SCREEN_WIDTH, 145);
            }
            count= [[array firstObject][@"data"]count]+[[array lastObject][@"data"]count];
        }
        
        NSString *str=[NSString stringWithFormat:@"过往作品(%ld个)",count];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]} range:NSMakeRange(0,4)];
        self.titleLab.attributedText=attStr;
        
    }
    
    [self getPastwotkUI];
    [self.tableV reloadData];
}

-(void)buttionClick:(UIButton*)sender
{
    if (sender.selected) {
        return;
    }
    
    if ([sender isEqual:self.videoBtn]) {
        self.pastworkType=0;
    }
    else
    {
        self.pastworkType=1;
    }
    
    if (self.pastworkCutPhotoAndVideo) {
        self.pastworkCutPhotoAndVideo(self.pastworkType);
    }
}

-(void)getPastwotkUI
{
    if (self.pastworkType==0) {
        self.videoBtn.selected=YES;
        self.photoBtn.selected=NO;
        [self.arrow mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.videoBtn);
            make.top.mas_equalTo(self.videoBtn.mas_bottom).offset(-5);
        }];
    }
    else
    {
        self.videoBtn.selected=NO;
        self.photoBtn.selected=YES;
        [self.arrow mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.photoBtn);
            make.top.mas_equalTo(self.photoBtn.mas_bottom).offset(-5);
        }];
    }
}

#pragma mark -
#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
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
    return 255;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==UserInfoCellTypePastWorkVideo && self.pastworkType==1) {
        static NSString *identifer = @"UserInfoPhotoSubCell";
        UserInfoPhotoSubCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[UserInfoPhotoSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        [cell reloadUIWithPastworkModel:self.dataSource[indexPath.row]];
        return cell;
    }
    else
    {
        static NSString *identifer = @"VideoSubCell";
        UserInfoVideoSubCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(!cell)
        {
            cell = [[UserInfoVideoSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        [cell reloadUIWithWorksModel:self.dataSource[indexPath.row]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==UserInfoCellTypePerformType || self.type==UserInfoCellTypeIntroduce) {
        NSMutableArray *array = [NSMutableArray new];
        for (int i =0; i<self.dataSource.count; i++) {
            WorksModel *model = self.dataSource[indexPath.row];
            if (self.type==UserInfoCellTypePerformType) {
                model.workType=WorkTypePerformance;
            }
            else
            {
                model.workType=WorkTypeIntroduction;
            }
            [array addObject:model];
        }
        
        if (self.playVideoWithArray) {
            self.playVideoWithArray(array, indexPath.row);
        }
    }
    else
    {
        WorksModel *model = self.dataSource[indexPath.row];
        NSMutableArray *array = [NSMutableArray new];
        for (int i =0; i<self.dataSource.count; i++) {
            WorksModel *model1 = self.dataSource[i];
            model1.workType=WorkTypePastworks;
            [array addObject:model1];
        }
        
        if (model.microtype==1) { //图片
            if (self.lookPastworkBigPhoto) {
                self.lookPastworkBigPhoto(array, indexPath.row);
            }
        }
        else if(model.microtype==2) //视频
        {
            if (self.playVideoWithArray) {
                self.playVideoWithArray(array, indexPath.row);
            }
        }
    }
}

@end


@interface UserInfoVideoSubCell ()
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *totalLab;
@property(nonatomic,strong)UIButton *timeBtn;
@end

@implementation UserInfoVideoSubCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.cornerRadius=5.0;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-6);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(0);
        }];
        
    }
    return _icon;
}


-(UILabel*)totalLab
{
    if (!_totalLab) {
        _totalLab=[[UILabel alloc]init];
        [self.contentView addSubview:_totalLab];
        _totalLab.font=[UIFont systemFontOfSize:12];
        _totalLab.textColor=[UIColor whiteColor];
        [_totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.timeBtn).offset(0);
        }];
    }
    return _totalLab;
}

-(UIButton*)timeBtn
{
    if (!_timeBtn) {
        _timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_timeBtn];
        _timeBtn.layer.masksToBounds=YES;
        _timeBtn.layer.cornerRadius=9;
        _timeBtn.backgroundColor=[[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.5];
        _timeBtn.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [_timeBtn setTitle:@"00:00" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeBtn setImage:[UIImage imageNamed:@"u_video_s"] forState:UIControlStateNormal];
        [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.icon).offset(-8);
            make.bottom.mas_equalTo(self.icon).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}

-(void)reloadUIWithWorksModel:(WorksModel *)model
{
    [self.icon sd_setImageWithUrlStr:model.cutvideo placeholderImage:[UIImage imageNamed:@"default_video"]];
    [self.timeBtn setTitle:model.timevideo forState:UIControlStateNormal];
//    self.totalLab.text=[NSString stringWithFormat:@"893次观看  |  15次下载"];
}

-(void)reloadUIWithPastworkModel:(WorksModel *)model
{
    [self.icon sd_setImageWithUrlStr:model.cutvideo placeholderImage:[UIImage imageNamed:@"default_video"]];
    [self.timeBtn setTitle:model.timevideo forState:UIControlStateNormal];
//    self.totalLab.text=[NSString stringWithFormat:@"893次观看  |  15次下载"];
}
@end

@interface UserInfoPhotoSubCell ()
@property(nonatomic,strong)UIImageView *icon;
@end

@implementation UserInfoPhotoSubCell
-(UIImageView*)icon
{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        [self.contentView addSubview:_icon];
        _icon.layer.cornerRadius=5.0;
        _icon.layer.masksToBounds=YES;
        _icon.contentMode=UIViewContentModeScaleAspectFill;
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-6);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).offset(0);
        }];
        
    }
    return _icon;
}

-(void)reloadUIWithPastworkModel:(WorksModel *)model
{
    [self.icon sd_setImageWithUrlStr:model.url placeholderImage:[UIImage imageNamed:@"default_video"]];
}

@end
