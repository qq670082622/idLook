//
//  UploadVideoCell.m
//  IDLook
//
//  Created by HYH on 2018/6/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadVideoCell.h"

@interface UploadVideoCell ()
@property(nonatomic,strong)UIImageView *videIcon;
@property(nonatomic,strong)UIButton *timeBtn;

@end

@implementation UploadVideoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.layer.borderColor=Public_LineGray_Color.CGColor;
        self.contentView.layer.borderWidth=0.5;
    }
    return self;
}

-(UIImageView*)videIcon
{
    if (!_videIcon) {
        _videIcon=[[UIImageView alloc]init];
        _videIcon.layer.masksToBounds=YES;
        _videIcon.contentMode=UIViewContentModeScaleAspectFill;
        _videIcon.layer.cornerRadius=5.0;
        _videIcon.backgroundColor=[UIColor blackColor];
        [self.contentView addSubview:_videIcon];
        [_videIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(20);
            make.centerY.mas_equalTo(self.contentView);
        }];
        _videIcon.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_videIcon addGestureRecognizer:tap];
    }
    return _videIcon;
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
            make.left.mas_equalTo(self.videIcon).offset(6);
            make.bottom.mas_equalTo(self.videIcon).offset(-6);
            make.size.mas_equalTo(CGSizeMake(54, 18));
        }];
        _timeBtn.titleEdgeInsets=UIEdgeInsetsMake(0,2, 0, -2);
    }
    return _timeBtn;
}


-(void)reloadUIWithDic:(NSDictionary *)dic
{
    self.videIcon.image=dic[@"image"];
    [self.timeBtn setTitle:dic[@"time"] forState:UIControlStateNormal];

}

-(void)tapAction
{
    self.addVideoAction();
}

@end
