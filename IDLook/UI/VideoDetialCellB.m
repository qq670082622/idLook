//
//  VideoDetialCell.m
//  IDLook
//
//  Created by HYH on 2018/6/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "VideoDetialCellB.h"

@interface VideoDetialCellB ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollV;
@end

@implementation VideoDetialCellB

-(UIScrollView*)scrollV
{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollV.delegate = self;
        _scrollV.pagingEnabled=NO;
        _scrollV.scrollEnabled = YES;
        _scrollV.backgroundColor = Public_Background_Color;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_scrollV];
        
        if ([UserInfoManager getUserType]==UserTypeResourcer) {
            _scrollV.frame=CGRectMake(0,0,UI_SCREEN_WIDTH,(UI_SCREEN_HEIGHT-250+20));

        }
        else
        {
            _scrollV.frame=CGRectMake(0,0,UI_SCREEN_WIDTH,(UI_SCREEN_HEIGHT-250-50+20));

        }
    }
    return _scrollV;
}

-(void)reloadUIWithModel:(WorksModel *)model  withCertUrl:(NSString *)url
{
    self.scrollV.contentSize=CGSizeMake(UI_SCREEN_WIDTH,480);
    
    [self initUIWithModel:model withUrl:url];

}

-(void)initUIWithModel:(WorksModel*)model withUrl:(NSString*)url
{
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0,0, UI_SCREEN_WIDTH, 155)];
    bgV.backgroundColor=[UIColor whiteColor];
    [self.scrollV addSubview:bgV];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15,15,UI_SCREEN_WIDTH-30,25)];
    title.text = model.title;
    title.font = [UIFont boldSystemFontOfSize:16.0];
    title.textColor = Public_Text_Color;
    [bgV addSubview:title];
    
    NSArray *array = @[[NSString stringWithFormat:@"作品编码：%@",model.creativeid],[NSString stringWithFormat:@"格        式：%@",model.format],[NSString stringWithFormat:@"像        素：%.fX%.f",model.widthpx,model.heightpx],[NSString stringWithFormat:@"时        长：%@",model.timevideo],[NSString stringWithFormat:@"大        小：%.2fMB",model.size]];
    
    for (int i =0; i<array.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15,45+20*i,UI_SCREEN_WIDTH-30,20)];
        lab.text = array[i];
        lab.font = [UIFont systemFontOfSize:13.0];
        lab.textColor = [UIColor colorWithHexString:@"#666666"];
        [bgV addSubview:lab];
    }
    
    //微出镜视频,试葩间授权书
    UIImageView *cerifBG = [[UIImageView alloc]initWithFrame:CGRectMake(15,178, UI_SCREEN_WIDTH-30,240)];
    //    cerifBG.contentMode=UIViewContentModeScaleAspectFill;
    [self.scrollV addSubview:cerifBG];
    [cerifBG sd_setImageWithUrlStr:url placeholderImage:[UIImage imageNamed:@"default_photo"]];
    
    MLLabel *desc = [[MLLabel alloc] initWithFrame:CGRectMake(30,420,UI_SCREEN_WIDTH-60,60)];
    desc.text = @"*脸探肖像独家销售权，可转签肖像使用权（同品类独家）可用于品牌商业用途，请提交下单获取报价信息 。";
    desc.font = [UIFont systemFontOfSize:11.0];
    desc.numberOfLines=0;
    desc.lineSpacing=5.0;
    desc.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    desc.textAlignment=NSTextAlignmentCenter;
    [self.scrollV addSubview:desc];
}


@end
