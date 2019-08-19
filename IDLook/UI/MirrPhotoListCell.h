//
//  MirrPhotoListCell.h
//  IDLook
//
//  Created by HYH on 2018/5/11.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define mirrPhotoWidth (UI_SCREEN_WIDTH-15*3)/2

@interface MirrPhotoListCell : UICollectionViewCell
@property(nonatomic,copy)void(^buyPhotoBlock)(void);     //购买微出镜视频

-(void)reloadUIWithModel:(WorksModel*)model;

@end
