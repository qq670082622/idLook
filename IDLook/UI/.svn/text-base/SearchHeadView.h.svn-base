//
//  SearchHeadView.h
//  IDLook
//
//  Created by HYH on 2018/5/3.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchStrucM.h"

@protocol SearchHeadViewDelegate<NSObject>

//按类别名称筛选
-(void)searchWithCategory:(NSString*)content;

//按条件筛选
-(void)searchWithConditionWithDic:(NSDictionary*)dic withSelect:(BOOL)select;

@end

@interface SearchHeadView : UIView

-(instancetype)initUIWithArtistType:(ArtistType)type withSCM:(SearchStrucM*)scm;

@property(nonatomic,weak)id<SearchHeadViewDelegate>delegate;

-(void)reloadConditWithContent:(NSString*)string withSearchConditionType:(SearchConditionType)type;

@end
