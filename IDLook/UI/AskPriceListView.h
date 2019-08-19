//
//  AskPriceListView.h
//  IDLook
//
//  Created by 吴铭 on 2019/6/3.
//  Copyright © 2019 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AskPriceListViewDelegate <NSObject>

-(void)selectType:(NSInteger)type withDay:(NSInteger)day andSinglePrice:(NSInteger)price isDelete:(BOOL)del;

@end
@interface AskPriceListView : UIView
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UIImageView *priceViewBackImg;
@property (weak, nonatomic) IBOutlet UILabel *priceTitle;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
- (IBAction)minus:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *day;
- (IBAction)select:(id)sender;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)NSInteger type;//类型，外部传 11:Video宣传片; 12:TVC影视广告; 21:平面; 41:Video+平面套拍; 42: TVC+平面套拍
@property(nonatomic,strong)NSArray *priceList;//价格，外部传
@property(nonatomic,assign)NSInteger startPrice;
@property(nonatomic,assign)CGFloat topY;
@property(nonatomic,weak)id<AskPriceListViewDelegate>delegate;
-(void)reloadWithDay:(NSInteger)day;
@end

NS_ASSUME_NONNULL_END
