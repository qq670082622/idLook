//
//  AuthSuccCellB.h
//  IDLook
//
//  Created by HYH on 2018/6/6.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthSuccCellB : UITableViewCell
@property(nonatomic,copy)void(^LookBigPhotoWithIndex)(NSInteger index);
-(void)reloadUIWithDic:(NSDictionary*)dic;
@end
