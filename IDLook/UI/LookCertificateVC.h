//
//  LookCertificateVC.h
//  IDLook
//
//  Created by HYH on 2018/5/23.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CertificateM.h"



@interface LookCertificateVC : UIViewController
@property(nonatomic,copy)void(^uploadRefreshUI)(void);

@property(nonatomic,strong)CertificateM *model;

@end
