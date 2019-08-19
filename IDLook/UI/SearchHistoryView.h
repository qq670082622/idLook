//
//  SearchHistoryView.h
//  IDLook
//
//  Created by HYH on 2018/4/28.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchHistoryViewDelegate <NSObject>
-(void)didClickType:(NSString*)type;
@end

@interface SearchHistoryView : UIView

@property (nonatomic,weak)id<SearchHistoryViewDelegate>delegate;

-(void)refreshUI;

@end
