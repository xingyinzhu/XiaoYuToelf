//
//  ExplainationLabelView.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-16.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "ExplainationLabelView.h"

@implementation ExplainationLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setExplainationText: (NSString *)explainationString
{
    self.text = explainationString;
}

@end
