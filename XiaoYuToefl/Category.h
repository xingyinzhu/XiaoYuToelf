//
//  category.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-10.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property (nonatomic, assign)NSInteger categoryid;
@property (nonatomic, copy)NSString * categoryName;
@property (nonatomic, assign)float progress;
@property (nonatomic, assign)NSInteger levelNum;

@property (nonatomic, strong)NSArray * categoryDict;


+(instancetype) categoryWithId:(int)id;

typedef enum
{
    hasNotReviewed = -1,
    hasReviewed = 0
}CategoryDisplayMode;

- (NSComparisonResult) compareProgress: (Category *)other;

- (void)updateMemCategoryProgressbyWordProgress : (int)totalCurrentProgress withLength : (int)length;

- (BOOL)updateCategoryProgressByOneScore : (int)score withLength : (int)length;

@end
