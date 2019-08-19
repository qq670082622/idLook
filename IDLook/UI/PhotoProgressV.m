//
//  PhotoProgressV.m
//  IDLook
//
//  Created by HYH on 2018/6/15.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import "PhotoProgressV.h"

@interface PhotoProgressV ()

@property (nonatomic,strong)CAShapeLayer *bgLayer;
@property (nonatomic,strong)CAShapeLayer *disLayer;

@end

@implementation PhotoProgressV

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self bgLayer];
}

- (CAShapeLayer *)bgLayer
{
    if(!_bgLayer)
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50)
                                                            radius:20.f
                                                        startAngle:0
                                                          endAngle:2*M_PI
                                                         clockwise:NO];
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.path = path.CGPath;
        _bgLayer.strokeColor = [UIColor darkGrayColor].CGColor;
        _bgLayer.lineWidth = 2.5;
        _bgLayer.allowsEdgeAntialiasing = YES;
        _bgLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_bgLayer];
    }
    return _bgLayer;
}

- (CAShapeLayer *)disLayer
{
    if(!_disLayer)
    {
        _disLayer = [CAShapeLayer layer];
        _disLayer.strokeColor = [UIColor whiteColor].CGColor;
        _disLayer.lineWidth = 2.5;
        _disLayer.lineCap = kCALineCapRound;
        _bgLayer.allowsEdgeAntialiasing = YES;
        _disLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer insertSublayer:_disLayer above:self.bgLayer];
    }
    return _disLayer;
}

- (void)setReceive:(NSInteger)receive
             total:(NSInteger)total
{
    if(receive<=0||total<0)return;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50)
                                                        radius:20.f
                                                    startAngle:-M_PI/2
                                                      endAngle:(float)receive/(float)total *M_PI*3/2
                                                     clockwise:YES];
    self.disLayer.path = path.CGPath;
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    [strokeAnimation setDuration:1];
    [strokeAnimation setToValue:@1];
    [self.disLayer addAnimation:strokeAnimation forKey:nil];
    [self.disLayer setNeedsDisplay];
    
    if(receive==total)
    {
        [self dismiss];
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
