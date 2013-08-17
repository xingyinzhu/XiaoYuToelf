//
//  GameData.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-12.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "GameData.h"
#include "Word.h"
#include "DictHelper.h"

@implementation GameData

- (void)initScoreWithTotalCount: (NSInteger)totalCount
{
    _score = [[NSMutableArray alloc]initWithCapacity:totalCount];
    for (int i=0;i<totalCount;i++)
    {
        _score[i] = [NSNumber numberWithInt:0];
    }
}
/*
- (void)byCategoryDictIndex : (NSInteger) index
{
    NSInteger tmpScore = [_score[index]integerValue];
    tmpScore = tmpScore / 2;
    _score[index] = [NSNumber numberWithInt:tmpScore];

}
*/
- (void)saveScoreWithCategoryDict : (NSArray *)dict
{
    NSInteger totalCount = [dict count];
    NSLog(@"totalCount : %d",totalCount);
    for (int i=0;i<totalCount;i++)
    {
        Word * word = dict[i];
        [DictHelper updateProgressWithWord:word.word withScore:[_score[i]integerValue]];
    }
}

@end
