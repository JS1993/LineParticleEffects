//
//  ViewController.m
//  Line particle effects
//
//  Created by  江苏 on 16/4/25.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet DrawView *DrawView;

@end

@implementation ViewController

- (IBAction)startAnimation:(id)sender {
    
    [self.DrawView setUpAnimation];
}

-(IBAction)endAnimatuon:(id)sender {
    
    [self.DrawView stopAnimation];
    
}


@end
