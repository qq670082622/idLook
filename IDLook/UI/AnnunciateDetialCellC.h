//
//  AnnunciateDetialCellC.h
//  IDLook
//
//  Created by Mr Hu on 2019/4/24.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AnnunciateDetialCellC : UITableViewCell
@property(nonatomic,copy)void(^clickSourceWithInfoBlock)(NSDictionary *dic);

-(void)reloadUIWithDic:(NSDictionary*)dic;

@end

@interface AnnunciateDetialSubV : UIView
-(void)reloadUIWithDic:(NSDictionary*)dic;

@end
