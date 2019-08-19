//
//  AuditApplyViewA.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/9.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuditApplyViewA : UIView
@property(nonatomic,copy)void(^auditTypeSelectBlock)(NSInteger type);  //试镜类型选择
@end

@interface AuditDescSubV : UIView
-(void)reloadUIWithArray:(NSArray*)array withTitle:(NSString*)title;
@end
