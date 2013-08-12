//
//  CounterLabelView.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterLabelView : UILabel

@property (assign, nonatomic) int value;

+(instancetype)labelWithFont:(UIFont*)font frame:(CGRect)r andValue:(int)v;
-(void)countTo:(int)to withDuration:(float)t;

@end
