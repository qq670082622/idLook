//
//  PhotoSelCellA.m
//  miyue
//
//  Created by wsz on 16/5/3.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import "PhotoSelCellA.h"
#import <Photos/Photos.h>

@interface PhotoSelCellA ()

@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel     *desc;
@property (nonatomic,strong)UILabel     *num;

@end

@implementation PhotoSelCellA

- (UIImageView *)icon
{
    if(!_icon)
    {
        _icon = [[UIImageView alloc] init];
        _icon.layer.cornerRadius = 6.f;
        _icon.layer.masksToBounds = YES;
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 70));
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _icon;
}

- (UILabel *)desc
{
    if(!_desc)
    {
        _desc = [[UILabel alloc] init];
        _desc.text = @"相机胶卷";
        [self.contentView addSubview:_desc];
        [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(15);
            make.right.lessThanOrEqualTo(self.num.mas_left);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _desc;
}

- (UILabel *)num
{
    if(!_num)
    {
        _num = [[UILabel alloc] init];
        _num.text = @"5";
        _num.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_num];
        [_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _num;
}

- (void)reloadUIWithDic:(NSDictionary *)dic
{
    if(![dic count])return;
    
    self.desc.text = [dic objectForKey:@"name"];
    
    PHFetchResult *result = [dic objectForKey:@"result"];
    if(result)
    {
        self.num.text = [NSString stringWithFormat:@"%d",(int)result.count];
        
        PHAsset *asset = result[0];
        
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        [[PHCachingImageManager defaultManager] requestImageForAsset:asset
                                                          targetSize:CGSizeMake(70*2, 70*2)
                                                         contentMode:PHImageContentModeAspectFill
                                                             options:option
                                                       resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
                                                           self.icon.image = image;
                                                       }];
    }
}

@end
