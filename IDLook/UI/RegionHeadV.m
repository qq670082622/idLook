//
//  RegionHeadV.m
//  IDLook
//
//  Created by Mr Hu on 2018/9/26.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "RegionHeadV.h"
#import "CityModel.h"
#import <CoreLocation/CoreLocation.h>

@interface RegionHeadV ()<CLLocationManagerDelegate>
//@property (strong, nonatomic) CLLocationManager* locationManager;
//@property(nonatomic,strong)UIButton *locatBtn;
@end

@implementation RegionHeadV

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self startLocation];
    
    CGFloat width = (UI_SCREEN_WIDTH-30-16-15)/3;
#if 0
    UILabel *title1= [[UILabel alloc]init];
    title1.font=[UIFont systemFontOfSize:14];
    title1.textColor=[UIColor colorWithHexString:@"#999999"];
    title1.text=@"定位城市";
    [self addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(19);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=4;
    btn.tag=100;
    btn.frame=CGRectMake(15,45, width,32);
    btn.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
    [btn setTitleColor:Public_Text_Color forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [btn setTitle:@"未知城市" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"center_region"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 3, 0, -3);
    self.locatBtn=btn;
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor=Public_LineGray_Color;
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(self).offset(95);
        make.height.mas_equalTo(0.5);
    }];
#endif

    UILabel *title2= [[UILabel alloc]init];
    title2.font=[UIFont systemFontOfSize:14];
    title2.textColor=[UIColor colorWithHexString:@"#999999"];
    title2.text=@"热门城市";
    [self addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(20);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    
    
    for (int i = 0 ; i<self.dataSource.count; i++) {
        CityModel *model = self.dataSource[i];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=4;
        btn.tag=1000+i;
        btn.frame=CGRectMake(15+(width+8)*(i%3),50+40*(i/3),width,32);
        btn.backgroundColor=[UIColor colorWithHexString:@"#F5F5F5"];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [btn setTitle:model.city forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)btnClick:(UIButton*)sender
{
    if (self.cityClickBlock) {
        self.cityClickBlock(sender.titleLabel.text);
    }
}

#if 0
-(void)startLocation{
    
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;//遵循代理
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.locationManager.distanceFilter = 10.0f;
        
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
        
        [self.locationManager startUpdatingLocation];//开始定位
        
    }else{//不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *address = [placemark addressDictionary];
            
            //  Country(国家)  State(省)  City（市）
            NSLog(@"#####%@",address);
            
            NSLog(@"%@", [address objectForKey:@"Country"]);
            
            NSLog(@"%@", [address objectForKey:@"State"]);
            
            NSLog(@"%@", [address objectForKey:@"City"]);
            
            if (address[@"State"]==nil) {
                [self.locatBtn setTitle:address[@"City"] forState:UIControlStateNormal];
            }
            else
            {
                [self.locatBtn setTitle:address[@"State"] forState:UIControlStateNormal];
            }
        }
        
    }];
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}
#endif
@end
