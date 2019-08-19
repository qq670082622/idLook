//
//  priceGroupPopV.h
//  IDLook
//
//  Created by 吴铭 on 2018/12/14.  平面Or视频拍摄服务选择的底部弹窗
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, Videotype) {
    Videotype_tvcAdd = 11,//tvc影视广告
     Videotype_advertise, //Video宣传片
    Videotype_microFilm, //微电影广告
   
    
};
typedef NS_ENUM(NSInteger, PlaneType) {
    PlaneType_plane = 21,//全平面
    PlaneType_planeAdver,//内部宣传
    PlaneType_planePack,//产品包装
};
@interface OfferTypePopV2 : UIView
//-----------------外部方法
-(void)showOfferTypeWithPriceList:(NSArray*)list withSelectArray:(NSArray*)array withUserModel:(UserInfoM*)userModel;

@property(nonatomic,copy)void(^typeSelectAction)(NSArray *selectArray);

- (IBAction)closePopV:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;//抬头小提示
//---------------------视频价格类UI
@property (weak, nonatomic) IBOutlet UIView *videoView;//装3个视频广告view的superview

@property (weak, nonatomic) IBOutlet UIView *tvcAddView;//装tvc影视广告的view
@property (weak, nonatomic) IBOutlet UILabel *tvcAddview_Title;//tvc广告
@property (weak, nonatomic) IBOutlet UIImageView *tvcAddview_Image;//tvc影视广告背景图
@property (weak, nonatomic) IBOutlet UILabel *tvcAddview_priceLabel;//tvc影视广告价格标签
- (IBAction)tvcAddview_select:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *microFilmView;//装微电影广告的view
@property (weak, nonatomic) IBOutlet UILabel *microFilmview_Title;
@property (weak, nonatomic) IBOutlet UIImageView *microFilmview_Image;//微电影广告背景图
@property (weak, nonatomic) IBOutlet UILabel *microFilmview_priceLabel;//微电影广告价格标签
- (IBAction)microFilmview_select:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *advertiseView;//装Video宣传片的view
@property (weak, nonatomic) IBOutlet UILabel *advertiseView_Title;//Video宣传片title
@property (weak, nonatomic) IBOutlet UIImageView *advertiseview_Image;//Video宣传片背景图
@property (weak, nonatomic) IBOutlet UILabel *advertiseview_priceLabel;//Video宣传片价格标签
- (IBAction)advertiseview_select:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *videoView_DayAddBtn;//视频拍摄天数加按钮
- (IBAction)videoView_DayAddBtn:(id)sender;//
@property (weak, nonatomic) IBOutlet UIButton *videoView_DayMinusBtn;//视频拍摄天数减按钮
- (IBAction)videoView_DayMinusBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *videoView_DayLabel;//视频拍摄天数
//--------------------平面价格类UI
@property (weak, nonatomic) IBOutlet UIView *photoView;//装3种平面的superview

@property (weak, nonatomic) IBOutlet UIView *planView;//装全平面的view
@property (weak, nonatomic) IBOutlet UILabel *planeView_Title;//全平面title
@property (weak, nonatomic) IBOutlet UIImageView *planeview_Image;//全平面背景图
@property (weak, nonatomic) IBOutlet UILabel *planeview_priceLabel;//全平面价格
@property (weak, nonatomic) IBOutlet UIView *planeview_OffLine;//折扣划线
@property (weak, nonatomic) IBOutlet UILabel *planeView_priceNewLabel;//全平面折扣价格
- (IBAction)planeViewSelect:(id)sender;//全平面被选中

@property (weak, nonatomic) IBOutlet UIView *planeAdverView;//装内部宣传的view
@property (weak, nonatomic) IBOutlet UILabel *planeAdverView_Title;//内部宣传title
@property (weak, nonatomic) IBOutlet UIImageView *planeAdver_Image;//内部宣传背景图
@property (weak, nonatomic) IBOutlet UILabel *planeAdver_priceLabel;//内部宣传价格
@property (weak, nonatomic) IBOutlet UIView *planeAdver_OffLine;//内部宣传折扣划线
@property (weak, nonatomic) IBOutlet UILabel *planeAdver_priceNewLabel;//内部宣传折扣价
- (IBAction)planeAdverSelect:(id)sender;//内部宣传被选中

@property (weak, nonatomic) IBOutlet UIView *planePackView;//装产品包装的view
@property (weak, nonatomic) IBOutlet UILabel *planePackView_Title;//产品包装
@property (weak, nonatomic) IBOutlet UIImageView *planePack_Image;//产品包装背景图
@property (weak, nonatomic) IBOutlet UILabel *planePack_priceLabel;//产品包装价格
@property (weak, nonatomic) IBOutlet UIView *planePack_OffLine;//产品包装扣划线
@property (weak, nonatomic) IBOutlet UILabel *planePack_priceNewLabel;//产品包装折扣价
- (IBAction)planePackSelect:(id)sender;//产品包装被选中

@property (weak, nonatomic) IBOutlet UIButton *planeView_DayAddBtn;//平面拍摄天数加按钮
- (IBAction)planeView_DayAddBtn:(id)sender;//
@property (weak, nonatomic) IBOutlet UIButton *planeView_DayMinusBtn;//平面拍摄天数减按钮
- (IBAction)planeView_DayMinusBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *planeView_DayLabel;//平面拍摄天数


@property (weak, nonatomic) IBOutlet UIView *line;//分割线

@property (weak, nonatomic) IBOutlet UILabel *foreignerTips;//外国人提醒
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;//确定
- (IBAction)ensure:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

NS_ASSUME_NONNULL_END
