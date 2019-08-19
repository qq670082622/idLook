//
//  LastPhotoView.m
//  IDLook
//
//  Created by Mr Hu on 2019/6/19.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "LastPhotoView.h"

@interface LastPhotoView ()
@property(nonatomic,strong)UILabel *titleLabel;  //标题
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UIView *photoV;

@end

@implementation LastPhotoView

-(id)init
{
    if (self=[super init]) {
        self.userInteractionEnabled=YES;
    }
    return self;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor=Public_Text_Color;
        _titleLabel.text=@"最新照片";
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(15);
            make.top.mas_equalTo(self).offset(13);
        }];
    }
    return _titleLabel;
}

-(UIView*)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor=Public_LineGray_Color;
        [self addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineV;
}

-(UIView*)photoV
{
    if (!_photoV) {
        _photoV = [[UIView alloc]init];
        _photoV.userInteractionEnabled=YES;
        [self addSubview:_photoV];
        [_photoV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(40);
            make.bottom.mas_equalTo(self);
        }];
    }
    return _photoV;
}

-(void)reloadUIWithArray:(NSArray*)array
{
    if (array.count==0) return;

    for (UIView *view in self.photoV.subviews) {
        [view removeFromSuperview];
    }
    [self titleLabel];
    [self lineV];

    CGFloat width = (UI_SCREEN_WIDTH-30-30)/4;
    for (int i=0; i<array.count; i++) {
        
        NSDictionary *dic = array[i];
        NSString *url = (NSString*)safeObjectForKey(dic, @"url");
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.userInteractionEnabled=YES;
        imageV.layer.cornerRadius=4.0;
        imageV.layer.masksToBounds=YES;
        imageV.tag=1100+i;
        imageV.contentMode=UIViewContentModeScaleAspectFill;
        imageV.backgroundColor=[UIColor grayColor];
        [self.photoV addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.photoV).offset(10+(width+10)*(i/4));
            make.left.mas_equalTo(self.photoV).offset(15+(width+8)*(i%4));
            make.size.mas_equalTo(CGSizeMake(width, width));
        }];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookScript:)];
        [imageV addGestureRecognizer:tap];
        
        [imageV sd_setImageWithUrlStr:url placeholderImage:[UIImage imageNamed:@"default_home"]];
    }
}

-(void)lookScript:(UITapGestureRecognizer*)tap
{
    NSLog(@"tag--%ld",tap.view.tag-1100);
    if (self.lookPhotoBlock) {
        self.lookPhotoBlock(tap.view.tag-1100);
    }
}


@end
