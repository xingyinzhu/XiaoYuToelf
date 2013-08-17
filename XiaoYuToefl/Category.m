//
//  category.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-10.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "Category.h"
#import "DictHelper.h"

@implementation Category


+(instancetype) categoryWithId:(int)id
{
    Category * c = [[Category alloc]init];
    c.categoryDict = [DictHelper fetchWordsWithCategoryId:id];
    return c;
}

- (CGFloat)calcProgressInCategory
{
    return [DictHelper calcProgressWithCategoryDict:_categoryid];
}

/*
- (NSComparisonResult) compareProgress: (Category *)other
{
    if (self.progress > other.progress)
    {
        return (NSComparisonResult)NSOrderedDescending;
    }
    else if (self.progress < other.progress)
    {
        return (NSComparisonResult)NSOrderedAscending;
    }
    else
        return (NSComparisonResult)NSOrderedSame;
}
*/

@end
