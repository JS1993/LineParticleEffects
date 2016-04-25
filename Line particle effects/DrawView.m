//
//  DrawView.m
//  Line particle effects
//
//  Created by  江苏 on 16/4/25.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property(nonatomic,strong)UIBezierPath* path;

@property(nonatomic,strong)CALayer* grainLayer;

@property(nonatomic,strong)CAReplicatorLayer* repL;

@end

@implementation DrawView

-(CAReplicatorLayer *)repL{
    
    if (_repL==nil) {
        _repL=[CAReplicatorLayer layer];
        _repL.frame=self.bounds;
        [self.layer addSublayer:_repL];
    }
    return _repL;
}

-(CALayer *)grainLayer{
    if (_grainLayer==nil) {
        _grainLayer=[CALayer layer];
        _grainLayer.bounds=CGRectMake(0, -1000, 10, 10);
        _grainLayer.cornerRadius=5;
        _grainLayer.backgroundColor=[UIColor redColor].CGColor;
        [self.repL addSublayer:_grainLayer];
    }
    return _grainLayer;
}

-(UIBezierPath *)path{
    if (_path==nil) {
        _path=[UIBezierPath bezierPath];
    }
    return _path;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch=[touches anyObject];
    
    CGPoint startP=[touch locationInView:self];
    
    [self.path moveToPoint:startP];
}

static int count=0;
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch=[touches anyObject];
    
    CGPoint curP=[touch locationInView:self];
    
    [self.path addLineToPoint:curP];
    
    [self setNeedsDisplay];
    
    count++;
}

#pragma mark--设置动画
-(void)setUpAnimation{
   
    CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
    
    anim.keyPath=@"position";
    
    anim.path=self.path.CGPath;
    
    anim.duration=3;
    
    anim.repeatCount=MAXFLOAT;
    
    [self.grainLayer addAnimation:anim forKey:nil];
    
    //注意，复制的子层如果有动画，先加动画，再复制
    
    self.repL.instanceCount=count;
    
    self.repL.instanceDelay=0.2;
}

-(void)stopAnimation{
    
    //把图层从父控件移除，再清空指针
    [self.grainLayer removeFromSuperlayer];
    self.grainLayer=nil;
    
    //将保存的路径清空
    self.path=nil;
    [self setNeedsDisplay];
    
    count=0;
    
}


- (void)drawRect:(CGRect)rect {
    
    [self.path stroke];
}

@end
