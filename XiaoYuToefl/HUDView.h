//
//  HUDView.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "StopwatchView.h"
#import "CounterLabelView.h"

@interface HUDView : UIView

@property (strong, nonatomic) StopwatchView* stopwatch;
@property (strong, nonatomic) CounterLabelView* gamePoints;
@property (strong, nonatomic) UIButton* btnHelp;

+(instancetype)viewWithRect:(CGRect)r;

@end
