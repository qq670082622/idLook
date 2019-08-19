//
//  LastPhotoView.h
//  IDLook
//
//  Created by Mr Hu on 2019/6/19.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LastPhotoView : UIView

@property(nonatomic,copy)void(^lookPhotoBlock)(NSInteger tag);  //查看图片

-(void)reloadUIWithArray:(NSArray*)array;

@end

NS_ASSUME_NONNULL_END
