//
//  PhotoSel2CellA.m
//  miyue
//
//  Created by wsz on 16/5/3.
//  Copyright © 2016年 wsz. All rights reserved.
//

#import "PhotoSel2CellA.h"

@interface PhotoSel2CellA ()

@property (nonatomic,strong)UIImageView *icon;

@end

@implementation PhotoSel2CellA

- (UIImageView  *)icon
{
    if(!_icon)
    {
        _icon = [[UIImageView alloc] init];
        _icon.layer.cornerRadius = 6.f;
        _icon.layer.masksToBounds = YES;
        _icon.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClicked)];
        [_icon addGestureRecognizer:tap];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return _icon;
}

- (UIButton *)btn
{
    if(!_btn)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setBackgroundImage:[UIImage imageNamed:@"works_noChoose"] forState:UIControlStateNormal];
        [_btn setBackgroundImage:[UIImage imageNamed:@"works_choose"] forState:UIControlStateSelected];

        [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(23, 23));
            make.right.equalTo(self.contentView).offset(-5);
            make.top.equalTo(self.contentView).offset(5);
        }];
    }
    return _btn;
}

- (void)reloadWithAsset:(PHAsset *)asset;
{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset
                                                      targetSize:CGSizeMake(PhotoSel2CellA_slide*2, PhotoSel2CellA_slide*2)
                                                     contentMode:PHImageContentModeAspectFill
                                                         options:option
                                                   resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
                                                       self.icon.image = image;
                                                   }];
    
     [self btn];
}

#pragma mark -
#pragma mark - others

- (void)btnClicked
{
    self.btn.selected=!self.btn.selected;
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    ani.fromValue =@1.0;
    ani.toValue =@1.3;
    ani.duration =.1f;
    ani.autoreverses = YES;
    [self.btn.layer addAnimation:ani forKey:@"scale"];
    
    self.didSelected(self.btn.selected);

}

- (void)setbtnStateHilight:(BOOL)hilight
{
    if(hilight)
    {
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
        ani.fromValue =@1.0;
        ani.toValue =@1.3;
        ani.duration =.1f;
        ani.autoreverses = YES;
        [self.btn.layer addAnimation:ani forKey:@"scale"];
        
        self.didSelected(YES);
    }
    else
    {
         [self.btn.layer removeAnimationForKey:@"scale"];
        
        self.didSelected(NO);
    }
}

@end
