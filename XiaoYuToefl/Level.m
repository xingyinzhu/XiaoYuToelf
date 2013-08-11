//
//  Level.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-10.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "Level.h"
#import "DictHelper.h"

@implementation Level

+(instancetype) levelWithNum:(int)levelNum
{
    Level * l = [[Level alloc]init];
    l.categorys = [DictHelper fetchCategoryWithLevel:levelNum];
    return l;
}

@end
