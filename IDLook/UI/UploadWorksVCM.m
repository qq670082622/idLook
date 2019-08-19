//
//  UploadWorksVCM.m
//  IDLook
//
//  Created by HYH on 2018/6/25.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "UploadWorksVCM.h"

NSString * const UploadWorksVCMCellClass =  @"UploadWorksVCMCellClass";
NSString * const UploadWorksVCMCellHeight = @"UploadWorksVCMCellHeight";
NSString * const UploadWorksVCMCellType =   @"UploadWorksVCMCellType";
NSString * const UploadWorksVCMCellData =   @"UploadWorksVCMCellData";

@implementation UploadWorksVCM

- (NSMutableArray *)ds
{
    if(!_ds)
    {
        _ds = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _ds;
}

-(void)refreshDataWithType:(WorkType)type
{
    [self.ds removeAllObjects];
    
    if (type==WorkTypePerformance) {
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"image":[[UIImage alloc]init],@"time":@""},
                             UploadWorksVCMCellClass:@"UploadWorksCellB",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:282],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"作品标题",@"content":@"",@"placeholder":@"请填写作品标题",@"isEdit":@(YES)},
                             UploadWorksVCMCellClass:@"UploadWorksCellA",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"作品类型",@"content":@"",@"placeholder":@"请选择作品类型",@"isEdit":@(NO)},
                             UploadWorksVCMCellClass:@"UploadWorksCellA",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"作品关键词",@"content":@"",@"placeholder":@"请选择作品关键词",@"isEdit":@(NO)},
                             UploadWorksVCMCellClass:@"UploadWorksCellA",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        if ([UserInfoManager getUserMastery]==2) {
            [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"作品角色",@"content":@"",@"placeholder":@"请选择作品角色",@"isEdit":@(NO)},
                                 UploadWorksVCMCellClass:@"UploadWorksCellA",
                                 UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                                 UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        }
    }
    
    else if (type ==WorkTypePastworks)
    {
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"image":[[UIImage alloc]init],@"time":@""},
                             UploadWorksVCMCellClass:@"UploadWorksCellB",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:282],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"作品标题",@"content":@"",@"placeholder":@"请填写作品标题",@"isEdit":@(YES)},
                             UploadWorksVCMCellClass:@"UploadWorksCellA",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"作品类型",@"content":@"",@"placeholder":@"请选择作品类型",@"isEdit":@(NO)},
                             UploadWorksVCMCellClass:@"UploadWorksCellA",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"作品关键词",@"content":@"",@"placeholder":@"请选择作品关键词",@"isEdit":@(NO)},
                             UploadWorksVCMCellClass:@"UploadWorksCellA",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        if ([UserInfoManager getUserMastery]==2) {
            [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"作品角色",@"content":@"",@"placeholder":@"请选择作品角色",@"isEdit":@(NO)},
                                 UploadWorksVCMCellClass:@"UploadWorksCellA",
                                 UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                                 UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        }
        
    }
    else if (type==WorkTypeIntroduction)
    {
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"image":[[UIImage alloc]init],@"time":@""},
                             UploadWorksVCMCellClass:@"UploadWorksCellB",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:258],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"形象类型",@"content":@"",@"placeholder":@"请选择形象类型",@"isEdit":@(NO)},
                             UploadWorksVCMCellClass:@"UploadWorksCellA",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"形象关键词",@"content":@"",@"placeholder":@"请选择形象关键词",@"isEdit":@(NO)},
                             UploadWorksVCMCellClass:@"UploadWorksCellA",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];


    }
    else if (type==WorkTypeMordCard)
    {
        [self.ds addObject:@{UploadWorksVCMCellData:@{@"image":[[UIImage alloc]init],@"time":@""},
                             UploadWorksVCMCellClass:@"UploadWorksCellB",
                             UploadWorksVCMCellHeight:[NSNumber numberWithFloat:258],
                             UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        

        
        if ([UserInfoManager getUserMastery]==2) {
            [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"剧照类型",@"content":@"",@"placeholder":@"请选择剧照类型",@"isEdit":@(NO)},
                                 UploadWorksVCMCellClass:@"UploadWorksCellA",
                                 UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                                 UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
            
            [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"剧照关键词",@"content":@"",@"placeholder":@"请选择剧照关键词",@"isEdit":@(NO)},
                                 UploadWorksVCMCellClass:@"UploadWorksCellA",
                                 UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                                 UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
            [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"剧照角色",@"content":@"",@"placeholder":@"请选择剧照角色",@"isEdit":@(NO)},
                                 UploadWorksVCMCellClass:@"UploadWorksCellA",
                                 UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                                 UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        }
        else
        {
            [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"形象类型",@"content":@"",@"placeholder":@"请选择形象类型",@"isEdit":@(NO)},
                                 UploadWorksVCMCellClass:@"UploadWorksCellA",
                                 UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                                 UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
            
            [self.ds addObject:@{UploadWorksVCMCellData:@{@"title":@"形象关键词",@"content":@"",@"placeholder":@"请选择形象关键词",@"isEdit":@(NO)},
                                 UploadWorksVCMCellClass:@"UploadWorksCellA",
                                 UploadWorksVCMCellHeight:[NSNumber numberWithFloat:48],
                                 UploadWorksVCMCellType:[NSNumber numberWithInteger:0]}];
        }

    }

}

//添加图片时改变高度
-(void)changeHeightWithPhotos:(NSArray*)photos
{
    CGFloat height =0.0;

    if (photos.count<6) {
       height=10+70+(UploadSubCellAWidth+10)*((photos.count)/3+1);
    }
    else
    {
        height = 10+70+(UploadSubCellAWidth+10)*2;
    }

    NSDictionary *dicA =@{UploadWorksVCMCellData:photos,
                          UploadWorksVCMCellClass:@"UploadWorksCellC",
                          UploadWorksVCMCellHeight:[NSNumber numberWithFloat:height],
                          UploadWorksVCMCellType:[NSNumber numberWithInteger:0]};
    
    [self.ds replaceObjectAtIndex:0 withObject:dicA];
}

//添加单张图片，视频时改变数据源
-(void)addVideoOrPhotoChangeData:(UIImage*)image withTime:(NSString *)time withType:(WorkType)type
{
    NSDictionary *dicA ;
    NSDictionary *data= @{@"image":image,@"time":time};
    CGFloat height = 0;
    if (type==WorkTypePerformance|| type==WorkTypePastworks) {
        height=282;
    }
    else
    {
        height=258;
    }
    
    dicA =@{UploadWorksVCMCellData:data,
            UploadWorksVCMCellClass:@"UploadWorksCellB",
            UploadWorksVCMCellHeight:[NSNumber numberWithFloat:height],
            UploadWorksVCMCellType:[NSNumber numberWithInteger:0]};
    
    [self.ds replaceObjectAtIndex:0 withObject:dicA];
}


@end
