//
//  ProjectOrderDetialCellE.m
//  IDLook
//
//  Created by Mr Hu on 2019/4/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "ProjectOrderDetialCellE.h"
#import "PlayRoleView.h"
#import "LastPhotoView.h"

@interface ProjectOrderDetialCellE ()
@property(nonatomic,strong)UILabel *titleLab;  //标题
@property(nonatomic,strong)UIView *centerView;  //中间视图
@property(nonatomic,strong)PlayRoleView *roleView;  //饰演角色
@property(nonatomic,strong)LastPhotoView *photoView;  //图片试图

@end

@implementation ProjectOrderDetialCellE

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        _titleLab.textColor=Public_Text_Color;
        _titleLab.text=@"询档信息";
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(12);
        }];
    }
    return _titleLab;
}

-(UIView*)centerView
{
    if (!_centerView) {
        _centerView = [[UIView alloc]init];
        [self.contentView addSubview:_centerView];
        [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(43);
            make.bottom.mas_equalTo(self.roleView.mas_top).offset(-5);
        }];
    }
    return _centerView;
}

-(PlayRoleView*)roleView
{
    if (!_roleView) {
        _roleView = [[PlayRoleView alloc]init];
        [self.contentView addSubview:_roleView];
        [_roleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.photoView.mas_top).offset(-15);
            make.height.mas_equalTo(80);
        }];
    }
    return _roleView;
}

-(LastPhotoView*)photoView
{
    if (!_photoView) {
        _photoView = [[LastPhotoView alloc]init];
        [self.contentView addSubview:_photoView];
//        _photoView.backgroundColor=[UIColor redColor];
        [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(100);
        }];
        WeakSelf(self);
        _photoView.lookPhotoBlock = ^(NSInteger tag) {
            if (weakself.lookLastPhotoBlock) {
                weakself.lookLastPhotoBlock(tag);
            }
        };
    }
    return _photoView;
}


-(void)reloadUIWithInfo:(ProjectOrderInfoM *)info withDic:(NSDictionary *)dic
{
    
    NSArray *latestPhotoList = (NSArray*)safeObjectForKey(info.askScheduleInfo, @"latestPhotoList");
    CGFloat pWidth = (UI_SCREEN_WIDTH-30-30)/4;
    CGFloat photoH = 0 ;
    if (latestPhotoList.count>0 && info.orderType==0) {
        photoH = (pWidth+10)*((latestPhotoList.count-1)/4+1)+55;
        [self.photoView reloadUIWithArray:latestPhotoList];
    }

    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(photoH);
    }];
    
    NSString *title = dic[@"title"];
    NSArray *array = dic[@"list"];
    
    self.titleLab.text=title;
    
    for (UIView *view in self.centerView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat totalH = 43;
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic =array[i];
        CGFloat contentH = [dic[@"height"]integerValue];
        CGFloat titleWidth = [self widthOfString:dic[@"title"] font:[UIFont systemFontOfSize:13] height:200];

        UILabel *titleLab=[[UILabel alloc]init];
        titleLab.font=[UIFont systemFontOfSize:13];
        titleLab.textColor=Public_DetailTextLabelColor;
        titleLab.text=dic[@"title"];
        [self.centerView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(totalH);
        }];
        
        MLLabel *contentLab=[[MLLabel alloc]init];
        contentLab.font=[UIFont systemFontOfSize:13];
        contentLab.numberOfLines=0;
        contentLab.lineSpacing=3;
        contentLab.textColor=Public_Text_Color;
        contentLab.text=dic[@"content"];
        contentLab.textAlignment=NSTextAlignmentLeft;
        [self.centerView addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(titleWidth+15);
            make.right.mas_equalTo(self.contentView).offset(-20);
            make.top.mas_equalTo(self.contentView).offset(totalH);
        }];
        totalH = totalH+contentH+3;
    }
    [self.roleView reloadUIWithDic:info.roleInfo];
}

//文字宽度
-(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    UILabel *contentLab = [[UILabel alloc] init];
    contentLab.font = font;
    contentLab.numberOfLines = 0;
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    contentLab.text = string;
    CGSize size = [contentLab sizeThatFits:CGSizeMake(0,height)];
    size.height = fmin(0, size.height);
    return ceilf(size.width)<60?60.0:ceilf(size.width);
}

@end
