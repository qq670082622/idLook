//
//  AdvertTypeSelectPopV.h
//  IDLook
//
//  Created by 吴铭 on 2019/3/20.
//  Copyright © 2019年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdvertTypeSelectPopV : UIView
@property(nonatomic,copy)void(^typeSelectAction)(NSInteger advSubType);


/**
 根据type得到选择的内容
 @param type 类型
 @param selectArray 已选中的内容
 @param isMuilSel  是否多选
 */
- (void)showWithSelect:(NSInteger)selectType withMultiSel:(BOOL)isMuilSel withEnableArray:(NSArray *)enableArray;
@end

NS_ASSUME_NONNULL_END
