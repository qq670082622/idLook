//
//  CheckGradeSectionView.h
//  IDLook
//
//  Created by 吴铭 on 2019/1/24.
//  Copyright © 2019年 HYH. All rights reserved.
//查看评价sectionheaderview

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckGradeSectionView : UIView
@property(nonatomic,assign)NSInteger type;//1试镜 2拍摄
@property(nonatomic,copy) NSString *pjName;
@end

NS_ASSUME_NONNULL_END
