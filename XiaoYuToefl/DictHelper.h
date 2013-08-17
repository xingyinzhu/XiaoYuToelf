//
//  DictHelper.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-10.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictHelper : NSObject

+ (void)CopyDict;
+ (void)OpenDict;
+ (void)closeDict;
+ (void)loadWords;
+ (void)loadCategorys;


+ (NSMutableArray*)fetchCategoryWithLevel: (NSInteger)level;
+ (NSMutableArray*)fetchWordsWithCategoryId: (NSInteger)categoryid;


+ (BOOL)DictIsExist : (NSFileManager *)filemanager;

+ (CGFloat)calcProgressWithCategoryDict : (NSInteger)categoryId;

+ (BOOL)updateProgressWithWord:(NSString *)word withScore:(NSInteger)score;

@end
