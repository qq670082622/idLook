//
//  EditMainCellD.m
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "EditMainCellD.h"
#import "EditHeadV.h"

@interface EditMainCellD ()
@property(nonatomic,strong)EditHeadV *headV;

@end

@implementation EditMainCellD

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    for (int i =0; i<2;i++) {
        UILabel *titleLab=[[UILabel alloc]init];
        titleLab.font=[UIFont systemFontOfSize:14.0];
        titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        titleLab.tag=100+i;
        [self.contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self.headV.mas_bottom).offset(30+30*i);
        }];
        
        MLLabel *descLab=[[MLLabel alloc]init];
        descLab.font=[UIFont systemFontOfSize:14.0];
        descLab.numberOfLines=0;
        descLab.textColor=Public_Text_Color;
        descLab.tag=1000+i;
        descLab.lineBreakMode = NSLineBreakByWordWrapping;
        descLab.lineSpacing = 10;

        [self.contentView addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(137);
            make.right.mas_equalTo(self.contentView).offset(-20);
            make.top.mas_equalTo(self.headV.mas_bottom).offset(30+30*i);
        }];
        
    }
}


-(EditHeadV*)headV
{
    if (!_headV) {
        _headV =[[EditHeadV alloc]init];
        [self.contentView addSubview:_headV];
        [_headV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(44);
        }];
        WeakSelf(self);
        _headV.editActionBlock = ^{
            weakself.EditMainCellDEditBlock();
        };
    }
    return _headV;
}


-(void)reloadUIWithTitle:(NSString *)title withType:(EditCellType)type
{
    self.headV.title=title;
    
    
    UILabel *lab1 = (UILabel*)[self.contentView viewWithTag:100];
    UILabel *lab2 = (UILabel*)[self.contentView viewWithTag:101];
    
    lab1.text = [self getTitleWithType:type withIndex:0];
    lab2.text = [self getTitleWithType:type withIndex:1];

    
    MLLabel *lab3 = (MLLabel*)[self.contentView viewWithTag:1000];
    MLLabel *lab4 = (MLLabel*)[self.contentView viewWithTag:1001];
    
    lab3.text = [self getDescWithType:type withIndex:0];
    lab4.text = [self getDescWithType:type withIndex:1];

}

-(NSString*)getDescWithType:(EditCellType)type withIndex:(NSInteger)index
{
    NSString *content = @"";
    if (type==EditCellTypeCooperation) {
        if (index==0) {
            
            NSDictionary *dic =[UserInfoManager getPublicConfig];
            NSArray *array1 = dic[@"categoryType"];
            for (int i=0; i<array1.count; i++) {
                NSDictionary *dicA = array1[i];
                NSInteger cateid =[[dicA objectForKey:@"cateid"] integerValue];
                if (cateid==[UserInfoManager getUserAgeType]) {
                    NSString *age= dicA[@"attribute"][@"ageGroupType"][@"attrname"];
                    content=[NSString stringWithFormat:@"%@（%@岁）",dicA[@"catename"],age];
                }
            }
        }
        else
        {
            content = [[UserInfoManager getPerformingTypes] stringByReplacingOccurrencesOfString:@"|" withString:@"、"];
        }
    }
    else if(type==EditCellTypeMirror)
    {
        if (index==0) {
            content = [[UserInfoManager getExploitableMirrPhotos] stringByReplacingOccurrencesOfString:@"|" withString:@"、"];
        }
        else
        {
            content = [[UserInfoManager getExploitableMirrVideos] stringByReplacingOccurrencesOfString:@"|" withString:@"、"];
        }
    }
    
    if (content.length==0) {
        content=@"暂未设置～";
    }
    
    return content;
}

-(NSString*)getTitleWithType:(EditCellType)type withIndex:(NSInteger)index
{
    NSString *title = @"" ;
    if (type==EditCellTypeCooperation) {
        if (index==0) {
            title=@"身 份 年 龄 段";
        }
        else
        {
            title = @"擅长表演类型";
        }
    }
    else if(type==EditCellTypeMirror)
    {
        if (index==0) {
            title=@"独家授权照片";
        }
        else
        {
            title=@"独家授权视频 ";
        }
    }

    return title;
}

@end
