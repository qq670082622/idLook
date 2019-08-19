/*
 @header  AuthCellD.m
 @project IDLook
 
 @company  观腾文化科技（上海）有限公司
 版权所有，侵权必究
 
 @author     Mr Hu
 @date       2018/11/26
 @description
 
 */

#import "AuthCellD.h"

@interface AuthCellD ()
@property(nonatomic,strong)UIImageView *leftV;
@property(nonatomic,strong)UIImageView *rightV;
@property(nonatomic,strong)UIImageView *bgV;
@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UILabel *rightLab;

@property(nonatomic,strong)UIImageView *leftCamera;
@property(nonatomic,strong)UIImageView *rightCamera;

@property(nonatomic,strong)UIButton *downloadBtn;

@end

@implementation AuthCellD

-(UIImageView*)bgV
{
    if (!_bgV) {
        _bgV=[[UIImageView alloc]init];
        [self.contentView addSubview:_bgV];
        _bgV.backgroundColor=[UIColor whiteColor];
        [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(40);
        }];
    }
    return _bgV;
}

-(UILabel*)titleLab
{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font=[UIFont systemFontOfSize:13.0];
        _titleLab.textColor=[UIColor colorWithHexString:@"#666666"];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.contentView).offset(15);
        }];
    }
    return _titleLab;
}

-(UIImageView*)leftV
{
    if (!_leftV) {
        _leftV=[[UIImageView alloc]init];
        _leftV.userInteractionEnabled=YES;
        _leftV.tag=10000;
        _leftV.clipsToBounds=YES;
        _leftV.layer.cornerRadius=5.0;
        _leftV.layer.masksToBounds=YES;
        _leftV.contentMode=UIViewContentModeScaleAspectFill;
        UIImage *image = [UIImage imageNamed:@"auth_idcard_bg1"];
        [self.contentView addSubview:_leftV];
        [_leftV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_centerX).offset(-3);
            make.top.mas_equalTo(self.bgV).offset(8);
            make.left.mas_equalTo(self.bgV).offset(5);
            make.height.mas_equalTo(image.size.height);
        }];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_leftV addGestureRecognizer:tap];
    }
    return _leftV;
}

-(UIImageView*)rightV
{
    if (!_rightV) {
        _rightV=[[UIImageView alloc]init];
        _rightV.userInteractionEnabled=YES;
        _rightV.tag=10001;
        _rightV.contentMode=UIViewContentModeScaleAspectFill;
        _rightV.clipsToBounds=YES;
        _rightV.layer.cornerRadius=5.0;
        _rightV.layer.masksToBounds=YES;
        UIImage *image = [UIImage imageNamed:@"auth_idcard_bg1"];
        [self.contentView addSubview:_rightV];
        [_rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX).offset(3);
            make.top.mas_equalTo(self.bgV).offset(8);
            make.right.mas_equalTo(self.bgV).offset(-5);
            make.height.mas_equalTo(image.size.height);
        }];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_rightV addGestureRecognizer:tap];
    }
    return _rightV;
}

-(UIImageView*)leftCamera
{
    if (!_leftCamera) {
        _leftCamera=[[UIImageView alloc]init];
        _leftCamera.userInteractionEnabled=YES;
        _leftCamera.tag=1000;
        _leftCamera.contentMode=UIViewContentModeScaleAspectFill;
        UIImage *image = [UIImage imageNamed:@"auth_camera"];
        _leftCamera.image=image;
        [self.contentView addSubview:_leftCamera];
        [_leftCamera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.leftV);
            make.centerY.mas_equalTo(self.leftV).offset(-15);
        }];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cameraAction:)];
        [_leftCamera addGestureRecognizer:tap];
    }
    return _leftCamera;
}

-(UIImageView*)rightCamera
{
    if (!_rightCamera) {
        _rightCamera=[[UIImageView alloc]init];
        _rightCamera.userInteractionEnabled=YES;
        _rightCamera.tag=1001;
        _rightCamera.contentMode=UIViewContentModeScaleAspectFill;
        UIImage *image = [UIImage imageNamed:@"auth_camera"];
        _rightCamera.image=image;
        [self.contentView addSubview:_rightCamera];
        [_rightCamera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.rightV);
            make.centerY.mas_equalTo(self.rightV).offset(-15);
        }];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cameraAction:)];
        [_rightCamera addGestureRecognizer:tap];
    }
    return _rightCamera;
}

-(UILabel*)leftLab
{
    if (!_leftLab) {
        _leftLab=[[UILabel alloc]init];
        [self.contentView addSubview:_leftLab];
        _leftLab.font=[UIFont systemFontOfSize:11];
        _leftLab.textColor=Public_Red_Color;
        [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.leftV);
            make.top.mas_equalTo(self.leftV.mas_centerY).offset(17);
        }];
    }
    return _leftLab;
}

-(UILabel*)rightLab
{
    if (!_rightLab) {
        _rightLab=[[UILabel alloc]init];
        [self.contentView addSubview:_rightLab];
        _rightLab.font=[UIFont systemFontOfSize:11];
        _rightLab.textColor=Public_Red_Color;
        [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.rightV);
            make.top.mas_equalTo(self.rightV.mas_centerY).offset(17);
        }];
    }
    return _rightLab;
}

-(UIButton*)downloadBtn
{
    if (!_downloadBtn) {
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadBtn setImage:[UIImage imageNamed:@"auth_download"] forState:UIControlStateNormal];
        [_downloadBtn setImage:[UIImage imageNamed:@"auth_download"] forState:UIControlStateSelected];
        [_downloadBtn addTarget:self action:@selector(downloadAction) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:_downloadBtn];
        [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(20);
            make.bottom.mas_equalTo(self.contentView).offset(-15);
        }];
        
        // underline Terms and condidtions
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"下载《委托下单授权书》范本"];
        
        [tncString addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#52ACFF"],NSUnderlineColorAttributeName:[UIColor colorWithHexString:@"#52ACFF"],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} range:NSMakeRange(0, tncString.length)];
        
        [_downloadBtn setAttributedTitle:tncString forState:UIControlStateNormal];
        _downloadBtn.imageEdgeInsets=UIEdgeInsetsMake(0, -3, 0, 3);
    }
    return _downloadBtn;
}

-(void)reloadUIWithModel:(AuthStructModel *)model
{
    [self bgV];
    self.titleLab.text=model.headTitle;
    UIImage *image = [UIImage imageNamed:@"auth_lic_bg"];

    if (model.image1==nil) {
        self.leftV.image=[UIImage imageNamed:@"auth_lic_bg"];
        self.leftLab.hidden=NO;
        self.leftLab.text=model.content;
        self.leftCamera.hidden=NO;
        [self.leftV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_centerX).offset(0);
            make.top.mas_equalTo(self.bgV).offset(8);
            make.left.mas_equalTo(self.bgV).offset(5);
            make.height.mas_equalTo(image.size.height);
        }];
    }
    else
    {
        self.leftV.image=model.image1;
        self.leftLab.hidden=YES;
        self.leftCamera.hidden=YES;
        [self.leftV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_centerX).offset(-5);
            make.top.mas_equalTo(self.bgV).offset(18);
            make.left.mas_equalTo(self.bgV).offset(12);
            make.height.mas_equalTo(image.size.height-21);
        }];
    }
    
    if (model.image2==nil) {
        self.rightV.image=[UIImage imageNamed:@"auth_cer_bg"];
        self.rightLab.hidden=NO;
        self.rightLab.text=model.placeholder;
        self.rightCamera.hidden=NO;
        [self.rightV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX).offset(0);
            make.top.mas_equalTo(self.bgV).offset(8);
            make.right.mas_equalTo(self.bgV).offset(-5);
            make.height.mas_equalTo(image.size.height);
        }];
    }
    else
    {
        self.rightV.image=model.image2;
        self.rightLab.hidden=YES;
        self.rightCamera.hidden=YES;
        [self.rightV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX).offset(5);
            make.top.mas_equalTo(self.bgV).offset(18);
            make.right.mas_equalTo(self.bgV).offset(-12);
            make.height.mas_equalTo(image.size.height-21);
        }];
    }
    self.downloadBtn.hidden=NO;
}


-(void)tapAction:(UITapGestureRecognizer*)tap
{
    NSInteger tag = tap.view.tag;
    if (self.selectPhotoBlock) {
        self.selectPhotoBlock(tag-10000);
    }
}

-(void)cameraAction:(UITapGestureRecognizer*)tap
{
    NSInteger tag = tap.view.tag;
    if (self.selectPhotoBlock) {
        self.selectPhotoBlock(tag-1000);
    }
}

//下载授权书
-(void)downloadAction
{
    if (self.downloadCerBlock) {
        self.downloadCerBlock();
    }
}


@end
