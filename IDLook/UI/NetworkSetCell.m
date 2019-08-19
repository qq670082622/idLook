/*
 @header  NetworkSetCell.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/29
 @description
 
 */

#import "NetworkSetCell.h"

@interface NetworkSetCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *selectV;

@end

@implementation NetworkSetCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

-(UIImageView*)selectV
{
    if (!_selectV) {
        _selectV=[[UIImageView alloc]init];
        [self.contentView addSubview:_selectV];
        _selectV.image=[UIImage imageNamed:@"works_noChoose"];
        [_selectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
    }
    return _selectV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:15.0];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(void)reloadUIWithRow:(NSInteger)row
{
    if (row==0) {
        self.titleLab.text = @"使用2G/3G/4G网络自动播放";
        if ([UserInfoManager getWWanAuthPlay]==YES) {
            self.selectV.image=[UIImage imageNamed:@"works_choose"];
        }
        else
        {
            self.selectV.image=[UIImage imageNamed:@"works_noChoose"];
        }
    }
    else if (row==1)
    {
        self.titleLab.text = @"使用2G/3G/4G网络每次播放前询问我";
        if ([UserInfoManager getWWanAuthPlay]==YES) {
            self.selectV.image=[UIImage imageNamed:@"works_noChoose"];
        }
        else
        {
            self.selectV.image=[UIImage imageNamed:@"works_choose"];
        }
    }
}

@end