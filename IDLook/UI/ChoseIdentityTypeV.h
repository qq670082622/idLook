//
//  ChoseIdentityTypeV.h
//  IDLook
//
//  Created by HYH on 2018/5/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoseIdentityTypeVDelegate <NSObject>

-(void)choseIdentityWithType:(NSInteger)type withSubType:(NSInteger)subType withContent:(NSString*)content;
-(void)isShowLastStep:(NSInteger)step;
@end

@interface ChoseIdentityTypeV : UIView

@property (nonatomic,weak)id<ChoseIdentityTypeVDelegate>delegate;

//选择身份
-(void)reloadUI;

//上一步
-(void)lastStepAction;

//取消
-(void)cancle;

@end


@protocol IdentitySubViewDelegate <NSObject>
-(void)choseidentitywithtype:(NSInteger)type;
@end

@interface IdentitySubView : UIView
@property (nonatomic,weak)id<IdentitySubViewDelegate>delegate;
-(void)initUIWithArray:(NSArray*)array;
@end
