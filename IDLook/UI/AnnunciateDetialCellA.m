//
//  AnnunciateDetialCellA.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "AnnunciateDetialCellA.h"

@interface AnnunciateDetialCellA ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UILabel *rewardLab;  //片酬

@end

@implementation AnnunciateDetialCellA

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:18];
        _titleLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _titleLab;
}

-(UILabel*)rewardLab
{
    if (!_rewardLab) {
        _rewardLab=[[UILabel alloc]init];
        _rewardLab.font=[UIFont systemFontOfSize:13];
        _rewardLab.textColor=Public_Text_Color;
        [self.contentView addSubview:_rewardLab];
        [_rewardLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _rewardLab;
}


-(void)reloadUIWithDic:(NSDictionary*)dic
{
    NSString *str=[NSString stringWithFormat:@"期待片酬￥%@",dic[@"myApplyInfo"][@"price"]];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attStr addAttributes:@{NSForegroundColorAttributeName:Public_Red_Color,NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]} range:NSMakeRange(4,str.length-4)];
    self.rewardLab.attributedText=attStr;
    
    NSInteger statusss = [dic[@"myApplyInfo"][@"status"]integerValue];
    NSString *status = @"";
    switch (statusss) {
        case 1:
            status=@"已选中";
            break;
        case 2:
            status=@"未入选";
            break;
        case 3:
            status=@"进行中";
            break;
        default:
            break;
    }
    self.titleLab.text=status;
}

@end
