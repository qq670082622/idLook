//
//  WorksManager.m
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "WorksManager.h"
#import "WorkCellA.h"
#import "WorkCellB.h"
#import "MyWorkHeadView.h"

@implementation WorksManager

#pragma mark -
#pragma mark -UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataM.ds[collectionView.tag-100][section]count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataM.ds[collectionView.tag-100]count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WorksModel *model = (WorksModel*) self.dataM.ds[collectionView.tag-100] [indexPath.section][indexPath.row];
    if (collectionView.tag==100 || collectionView.tag==101)
    {
        WorkCellA *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WorkCellA" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        [cell reloadUIWithModel:model];
        WeakSelf(self);
        cell.chooseAction = ^(BOOL select) {
            weakself.chooseAction(select, indexPath);
        };
        cell.playAction = ^{
            weakself.playAction(model);
        };
        return cell;
    }
    else
    {
        WorkCellB *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WorkCellB" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor clearColor];
        [cell reloadUIWithModel:model];
        WeakSelf(self);
        cell.chooseAction = ^(BOOL select) {
            weakself.chooseAction(select, indexPath);
        };
        cell.playAction = ^{
            weakself.playAction(model);
        };
        return cell;
    }
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MyWorkHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        
        WorksModel *model = (WorksModel*) self.dataM.ds[collectionView.tag-100] [indexPath.section][indexPath.row];
        
        NSInteger type = 0;
        NSInteger subType =0;
        if (collectionView.tag==101)
        {
            if (indexPath.section==0 || indexPath.section==self.dataM.pastworkVideoCount)
            {
                if (self.dataM.pastworkVideoCount==0)
                {
                    type=1;  //图片
                }
                else
                {
                    if (indexPath.section==0)
                    {
                        type=2;//视频
                    }
                    else
                    {
                        type=1;  //图片
                    }
                }
            }
        }
        [headView reloadUIWithModel:model withType:type];
        return  headView;
    }
    else
    {
        return nil;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==100 || collectionView.tag==101) {
        return CGSizeMake((UI_SCREEN_WIDTH-45)/2, (UI_SCREEN_WIDTH-45)/2 * (11.0/17.0)+60);
    }
    return CGSizeMake((UI_SCREEN_WIDTH-45)/2, (UI_SCREEN_WIDTH-45)/2 * (11.0/17.0)+40);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15,15,15,15);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView.tag==101) {
        if (section==0 || section==self.dataM.pastworkVideoCount) {
            return CGSizeMake(0, 85);
        }
        return CGSizeMake(0, 20);
    }
    else
    {
        if (section==0) {
            return CGSizeMake(0, 35);
        }
        return CGSizeMake(0,20);
    }
}

@end
