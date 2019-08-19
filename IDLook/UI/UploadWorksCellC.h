//
//  UploadWorksCellC.h
//  IDLook
//
//  Created by HYH on 2018/6/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@protocol UploadWorksCellCDelegate <NSObject>
-(void)addVideAction;
-(void)delectActionWithRow:(NSInteger)row;
@end

@interface UploadWorksCellC : UITableViewCell
@property(nonatomic,weak)id<UploadWorksCellCDelegate>delegate;

-(void)reloadUIWithArray:(NSArray *)array withTimes:(NSArray *)times;

@end


@protocol  UploadWorkSubCellDelegate <NSObject>
-(void)delectWorksWithRow:(NSInteger)row;
-(void)addWorksAction;
@end

@interface UploadSubCellA : UICollectionViewCell
@property(nonatomic,weak)id<UploadWorkSubCellDelegate>delegate;

-(void)reloadUIWithImage:(UIImage*)image withTime:(NSString*)time withAdd:(BOOL)add withRow:(NSInteger)row;

@end
