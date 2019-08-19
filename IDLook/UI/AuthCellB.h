//
//  AuthCellB.h
//  IDLook
//
//  Created by HYH on 2018/5/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthCellB : UITableViewCell
@property(nonatomic,copy)void(^addPhotoBlock)(void);
-(void)reloadUIWithDic:(NSDictionary*)dic;
@property(nonatomic,strong)UIImage *image;
@end
