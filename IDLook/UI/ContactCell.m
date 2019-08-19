/*
 @header  ContactCell.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/10/30
 @description
 
 */

#import "ContactCell.h"

@interface ContactCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *desc;
@end

@implementation ContactCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
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


-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:15.0];
        _desc.textColor=[UIColor colorWithHexString:@"#666666"];
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _desc;
}

-(void)reloadUIWithDic:(NSDictionary *)dic
{
    self.titleLab.text=dic[@"title"];
    self.desc.text=dic[@"desc"];
}


@end
