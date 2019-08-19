//
//  UploadWorksCellB.m
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadWorksCellB.h"

@interface UploadWorksCellB ()
@property(nonatomic,strong)UILabel *desc;
@property(nonatomic,assign)WorkType type;
@property(nonatomic,strong)UIButton *timeBtn;

@end

@implementation UploadWorksCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(AddSubButton*)addBtn
{
    if (!_addBtn) {
        _addBtn=[[AddSubButton alloc]init];
        [self.contentView addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(24);
            make.centerX.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.height.mas_equalTo(210);
        }];
        WeakSelf(self);
        _addBtn.addAction = ^{
            [weakself addACtion];
        };

    }
    return _addBtn;
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
            make.left.mas_equalTo(self.addBtn).offset(6);
            make.bottom.mas_equalTo(self.addBtn).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}

-(UILabel*)desc
{
    if (!_desc) {
        _desc=[[UILabel alloc]init];
        _desc.font=[UIFont systemFontOfSize:13.0];
        _desc.numberOfLines=0;
        _desc.textAlignment=NSTextAlignmentCenter;
        _desc.text=@"要求：视频时长60s，大小50M以内。";
        _desc.textColor=[UIColor colorWithHexString:@"#9B9B9B"];
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView).offset(0);
            make.top.mas_equalTo(self.addBtn.mas_bottom).offset(9);
        }];
    }
    return _desc;
}

//添加按钮事件
-(void)addACtion
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addVideoAndPhotoWithType:)]) {
        [self.delegate addVideoAndPhotoWithType:self.type];
    }
}

-(void)reloadUIType:(WorkType)type withImage:(UIImage *)image withTime:(NSString *)time
{
    self.type=type;
    [self desc];
    if (type==WorkTypePerformance) {
        self.addBtn.imageN=@"works_video_icon";
        self.addBtn.title=@"添加试戏作品";
        self.desc.hidden=NO;
    }
    else if(type==WorkTypePastworks)
    {
        self.addBtn.imageN=@"works_photo_icon";
        self.addBtn.title=@"添加过往作品";
        self.desc.hidden=NO;
    }
    else if(type==WorkTypeIntroduction)
    {
        self.addBtn.imageN=@"works_video_icon";
        self.addBtn.title=@"添加自我介绍";
        self.desc.hidden=YES;
    }
    else if(type==WorkTypeMordCard)
    {
        self.addBtn.imageN=@"works_model_icon";
        if ([UserInfoManager getUserMastery]==2)
        {
            self.addBtn.title=@"添加剧照";
        }
        else
        {
            self.addBtn.title=@"添加模特卡";
        }
        self.desc.hidden=YES;
    }

    CGImageRef cgref = [image CGImage];
    CIImage *cim = [image CIImage];
    if (cim == nil && cgref == NULL)   //判断图片是空
    {
    }
    else
    {
        self.addBtn.iconImage=image;
    }
    
    if (time.length>0) {
        self.timeBtn.hidden=NO;
        [self.timeBtn setTitle:time forState:UIControlStateNormal];
    }
    else
    {
        self.timeBtn.hidden=YES;
    }
}
@end
