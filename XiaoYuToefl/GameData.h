//
//  GameData.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-12.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property (assign, nonatomic) NSInteger points;
//total score only for display
@property(nonatomic, strong) NSMutableArray * score;

- (void)initScoreWithTotalCount: (NSInteger)totalCount;

//- (void)byCategoryDictIndex : (NSInteger) index;

- (void)saveScoreWithCategoryDict : (NSArray *)dict;

@end
