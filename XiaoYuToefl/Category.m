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

- (void)updateMemCategoryProgressbyWordProgress : (int)totalCurrentProgress withLength : (int)length
{
    //NSLog(@"totalCurrentProgress : %d",totalCurrentProgress);
    float progress = totalCurrentProgress * 1.0 / (50 * length);
    if (progress >= 1.0f)
    {
        NSLog(@"i am here : %f",progress);
        self.progress = 1.0f;    //NSLog(@"self.progress : %f",self.progress);
    }
    else
    {
        self.progress = progress;
    }
    /*
     if (totalCurrentProgress == 120)
     {
     NSLog(@"self.progress : %f",self.progress);
     }
     */
}

- (BOOL)updateCategoryProgressByOneScore : (int)score withLength : (int)length
{
    if (self.progress >= 1.0 || score == 0)
    {
        return NO;
    }
    else
    {
        float delta = score * 1.0 / (50 * length);
        self.progress += delta;
        NSLog(@"in updateCategoryProgressByOneScore : %f",self.progress);
        return YES;
    }
}

@end
