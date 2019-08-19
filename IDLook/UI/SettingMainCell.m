//
//  SettingMainCell.m
//  IDLook
//
//  Created by HYH on 2018/5/16.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "SettingMainCell.h"
#import "VIMediaCache.h"

@interface SettingMainCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UILabel *desc;
@end

@implementation SettingMainCell

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

-(UIImageView*)arrow
{
    if (!_arrow) {
        _arrow=[[UIImageView alloc]init];
        [self.contentView addSubview:_arrow];
        _arrow.image=[UIImage imageNamed:@"center_arror_icon"];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
    }
    return _arrow;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:13.0];
        _desc.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-37);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _desc;
}

-(void)reloadUIWithTitle:(NSString *)title withDesc:(NSString *)desc
{
    self.titleLab.text=title;
    [self arrow];
    
    if ([title isEqualToString:@"清理缓存"]) {
        unsigned long long fileSize = [VICacheManager calculateCachedSizeWithError:nil];
        NSLog(@"file cache size: %@", @(fileSize));
        
        double convertedValue = fileSize;
        int multiplyFactor = 0;
        
        NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB",nil];
        
        while (convertedValue > 1024) {
            convertedValue /= 1024;
            multiplyFactor++;
        }
        if (multiplyFactor==0) {
            self.desc.text=@"暂无缓存";
        }
        else
        {
            NSString *format= [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
            NSLog(@"file cache size: %@", format);
            self.desc.text=format;
        }
    }
    else
    {
        self.desc.text=desc;
    }
    
}

@end
