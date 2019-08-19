//
//  SelectConditionV.h
//  IDLook
//
//  Created by HYH on 2018/5/8.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchStrucM.h"


@interface SelectConditionV : UIView
@property(nonatomic,copy)void(^SelectConditionVBlock)(NSString *content,SearchConditionType type);
-(void)reloadUIWithArtistType:(ArtistType)type withSearchConditionType:(SearchConditionType)subType withSCM:(SearchStrucM*)scm;

@end
