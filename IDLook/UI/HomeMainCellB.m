//
//  HomeMainCellB.m
//  IDLook
//
//  Created by HYH on 2018/7/2.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "HomeMainCellB.h"
#import "iCarousel.h"

@interface HomeMainCellB ()<iCarouselDelegate,iCarouselDataSource>
@property(nonatomic,strong)UILabel *titleV;
@property(nonatomic,strong)UIButton *moreBtn;

@property(nonatomic,strong)iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation HomeMainCellB

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleV.text=@"明星艺人推荐";
        [self moreBtn];
        
        self.items = [NSMutableArray array];
        
        [self carousel];
    }
    return self;
}

-(UILabel*)titleV
{
    if (!_titleV) {
        _titleV=[[UILabel alloc]init];
        [self.contentView addSubview:_titleV];
        _titleV.textColor=Public_Text_Color;
        _titleV.font=[UIFont boldSystemFontOfSize:18.0];
        [_titleV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _titleV;
}

-(UIButton*)moreBtn
{
    if (!_moreBtn) {
        _moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_moreBtn];
        [_moreBtn setImage:[UIImage imageNamed:@"center_arror_icon"] forState:UIControlStateNormal];
        [_moreBtn setTitle:@"More" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
        _moreBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14.0];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleV);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
        
        _moreBtn.titleLabel.backgroundColor = _moreBtn.backgroundColor;
        _moreBtn.imageView.backgroundColor = _moreBtn.backgroundColor;
        //在使用一次titleLabel和imageView后才能正确获取titleSize
        CGSize titleSize = _moreBtn.titleLabel.bounds.size;
        CGSize imageSize = _moreBtn.imageView.bounds.size;
        CGFloat interval = 1.0;
        _moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
        _moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + 5), 0, imageSize.width + 5);
        
        [_moreBtn addTarget:self action:@selector(entryMoreRecommend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

-(iCarousel*)carousel
{
    if (!_carousel) {
        _carousel=[[iCarousel alloc]init];
        _carousel.delegate=self;
        _carousel.dataSource=self;
        _carousel.bounces=NO;
        _carousel.pagingEnabled=YES;
        [_carousel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_carousel];
        _carousel.type = iCarouselTypeRotary;
        [_carousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.titleV.mas_bottom).offset(5);
        }];
    }
    return _carousel;
}

-(void)reloadUIWithArray:(NSArray *)array
{
    [self.items setArray:array];
    [self.carousel reloadData];
}

#pragma mark---
-(void)entryMoreRecommend
{
    self.EntryMoreRecommendBlock(10);
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[self.items count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    UIButton *button= nil;
    UIImageView *imageView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 163)];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 163)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius=4.0;
        imageView.layer.masksToBounds=YES;
        [view addSubview:imageView];

        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [label.font fontWithSize:16.0];
        label.textColor=[UIColor whiteColor];
        label.tag = 1;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(15);
            make.bottom.mas_equalTo(view).offset(-10);
        }];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:button];
        [button setImage:[UIImage imageNamed:@"home_sina"] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(view).offset(-15);
            make.bottom.mas_equalTo(view).offset(-10);
        }];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //    label.text = (index == 0)? @"[": @"]";
    UserInfoM *info = self.items[index];
    [imageView sd_setImageWithUrlStr:info.head placeholderImage:[UIImage imageNamed:@"default_home"]];
    label.text=info.nick;
    [button setTitle:@"1120万" forState:UIControlStateNormal];

    
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    if (self.items.count>0) {
        return 1;
    }
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    UIButton *button= nil;
    UIImageView *imageView = nil;

    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 163)];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 163)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius=4.0;
        imageView.layer.masksToBounds=YES;
        [view addSubview:imageView];
        
        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [label.font fontWithSize:16.0];
        label.textColor=[UIColor whiteColor];
        label.tag = 1;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(15);
            make.bottom.mas_equalTo(view).offset(-10);
        }];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:button];
        [button setImage:[UIImage imageNamed:@"home_sina"] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(view).offset(-15);
            make.bottom.mas_equalTo(view).offset(-10);
        }];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    UserInfoM *info = self.items[index];
    [imageView sd_setImageWithUrlStr:info.thumHead placeholderImage:[UIImage imageNamed:@"default_home"]];
    label.text=info.nick;
    [button setTitle:@"1120万" forState:UIControlStateNormal];
    

    if (index==0 || index==(self.items.count-1))
    {
        view.hidden=YES;
    }

    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0.0, 1.0, 0.0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return 0.0;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    UserInfoM *info = self.items[index];
    self.HomeMainCellBlickBlock(info);
   
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
}



@end
