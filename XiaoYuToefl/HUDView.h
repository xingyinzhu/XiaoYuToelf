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
#include "ExplainationLabelView.h"

@interface HUDView : UIView

@property (strong, nonatomic) StopwatchView* stopwatch;
@property (strong, nonatomic) CounterLabelView* gamePoints;
@property (strong, nonatomic) UIButton * btnHelp;
@property (strong, nonatomic) UIButton * btnExit;
@property (strong, nonatomic) ExplainationLabelView * explaination;
@property (strong, nonatomic) UILabel * remainCount;

+(instancetype)viewWithRect:(CGRect)r;

@end
