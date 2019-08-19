//
//  CustomCollectV.h
//  IDLook
//
//  Created by HYH on 2018/6/5.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCollectViewDelegate <NSObject>
- (void)CustomCollectViewNoDataSceneClicked:(id)sender;
@end

@interface CustomCollectV : UICollectionView

@property (nonatomic,assign)id<CustomCollectViewDelegate>dele;

-(void)startLoading;    //开始加载

- (void)showWithNoDataType:(NoDataType)type;   //显示缺省图

-(void)hideNoDataScene;         //隐藏缺省图

@end
