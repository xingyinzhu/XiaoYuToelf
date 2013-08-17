//
//  HUDView.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//


#import "HUDView.h"
#import "config.h"

@implementation HUDView

+(instancetype)viewWithRect:(CGRect)r
{
    //create the hud layer
    HUDView* hud = [[HUDView alloc] initWithFrame:r];
    hud.userInteractionEnabled = YES;

    //the stopwatch
    hud.stopwatch = [[StopwatchView alloc] initWithFrame: CGRectMake((kScreenWidth-kStopwatchWidth)/2, kMarginTop / 2,
                                                                    kStopwatchWidth, kStopwatchHeight)];
    hud.stopwatch.seconds = 0;
    [hud addSubview: hud.stopwatch];

    //"points" label
    UILabel* pts = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-kPointslabelWidth * 2.5,kMarginTop,
                                                           kPointslabelWidth,kPointslabelHeight)];
    pts.backgroundColor = [UIColor clearColor];
    pts.font = kFZMWFontGameText;
    pts.text = @"Points:";
    [hud addSubview:pts];

    //the dynamic points label
    hud.gamePoints = [CounterLabelView labelWithFont:kFZMWFontGameText frame:CGRectMake(kScreenWidth-kgamePointsWidth,kMarginTop,
                                                                                      kgamePointsWidth,kgamePointsHeight) andValue:0];
    hud.gamePoints.textColor = [UIColor colorWithRed:0.38 green:0.098 blue:0.035 alpha:1] /*#611909*/;
    [hud addSubview: hud.gamePoints];

    //load the button image
    UIImage* image = [UIImage imageNamed:@"btn"];

    //the help button
    hud.btnHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnHelp setTitle:@"Hint!" forState:UIControlStateNormal];
    hud.btnHelp.titleLabel.font = kFZMWFontGameText;
    [hud.btnHelp setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnHelp.frame = CGRectMake(kMarginLeft, kMarginTop, khintbtnWidth, khintbtnHeight);
    hud.btnHelp.alpha = 0.8;
    [hud addSubview: hud.btnHelp];
    
    //the exit button
    hud.btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnExit setTitle:@"Exit!" forState:UIControlStateNormal];
    hud.btnExit.titleLabel.font = kFZMWFontGameText;
    [hud.btnExit setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnExit.frame = CGRectMake(kMarginLeft, kScreenHeight - khintbtnHeight - kMarginTop , khintbtnWidth, khintbtnHeight);
    hud.btnExit.alpha = 0.8;
    [hud addSubview: hud.btnExit];
    
    //the explaination label
    hud.explaination = [[ExplainationLabelView alloc]init];
    CGFloat explainationWidth = kScreenWidth / 2;
    CGFloat explainationHeight = kScreenHeight / 3;
    hud.explaination.bounds = CGRectMake(0, 0, explainationWidth, explainationHeight);
    hud.explaination.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    hud.explaination.font = kFZMWFontGameText;
    hud.explaination.backgroundColor = [UIColor clearColor];
    hud.explaination.lineBreakMode = NSLineBreakByWordWrapping;
    hud.explaination.numberOfLines = 0;
    [hud addSubview:hud.explaination];
    
    //the remain count label
    hud.remainCount = [[UILabel alloc]initWithFrame: CGRectMake((kScreenWidth-kStopwatchWidth)/2,
                                                                kScreenHeight - khintbtnHeight - kMarginTop,
                                                                kStopwatchWidth, kStopwatchHeight)];
    hud.remainCount.text = @"Remmain : 0";
    hud.remainCount.backgroundColor = [UIColor clearColor];
    hud.remainCount.font = kFZMWFontGameText;
    [hud addSubview: hud.remainCount];
    
    return hud;
}

-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  // let touches through and only catch the ones on buttons
    UIView* hitView = (UIView*)[super hitTest:point withEvent:event];

    if ([hitView isKindOfClass:[UIButton class]])
    {
        return hitView;
    }

    return nil;
  
}

@end