//
//  MyOrderMainVC+Action.h
//  IDLook
//
//  Created by Mr Hu on 2019/6/10.
//  Copyright © 2019 HYH. All rights reserved.
//

#import "MyOrderMainVC.h"
#import "ProjectOrderInfoM.h"
#import "TZImagePickerController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderMainVC (Action)<TZImagePickerControllerDelegate>

/**
 cell底部按钮点击事件
 @param type 按钮类型
 @param info 项目信息
 */
-(void)BottomButtonAction:(NSInteger)type withProjectInfo:(ProjectOrderInfoM*)info;

@end

NS_ASSUME_NONNULL_END
