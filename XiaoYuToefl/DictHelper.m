//
//  DictHelper.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-10.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "DictHelper.h"
#import "FMDatabase.h"
#import "Word.h"
#import "Category.h"
#import "FMDatabaseAdditions.h"

@implementation DictHelper

static NSString * dictPath;
static FMDatabase *dictDataBase;
static NSMutableDictionary *allDict;
static NSMutableDictionary *categoryDict;

+ (void)CopyDict
{
    if (dictPath == nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *realPath = [docsPath stringByAppendingPathComponent:@"dict.db"];
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"dict" ofType:@"db"];
        
        dictPath = realPath;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSLog(@"%@",realPath);
        if (![DictHelper DictIsExist:fileManager])
        {
            NSError *error;
            NSLog(@"copying ...");
            if (![fileManager copyItemAtPath:sourcePath toPath:dictPath error:&error])
            {
                NSLog(@"%@", [error localizedDescription]);
            }
        }
    }
    
}

+ (void)OpenDict
{
    if (dictDataBase == nil)
    {
        if (dictPath != nil)
        {
            dictDataBase = [FMDatabase databaseWithPath:dictPath];
        }
        if (![dictDataBase open])
        {
            NSLog(@"Open dict failed!");
            return;
        }
    }
}

+ (void)closeDict
{
    if (dictDataBase != nil)
    {
        if (![dictDataBase close])
        {
            NSLog(@"Close dict failed!");
            return;
        }
        else
        {
            NSLog(@"Close dict ok!");
        }
    }
}


+ (void)loadWords
{
    if (allDict == nil)
    {
        allDict = [[NSMutableDictionary alloc]init];
        
        //table words * table progress
        NSString * sql = @"select w.word, w.englishmark, w.americamark, w.meanings,w.hint, p.value from words w, progress p where p.word = w.word";
        FMResultSet *result = [dictDataBase executeQuery:sql];
        int cnt = 0;
        while ([result next])
        {
            Word * tmpWord = [[Word alloc]init];
            tmpWord.word = [result stringForColumn:@"word"];
            tmpWord.englishmark = [result stringForColumn:@"englishmark"];
            tmpWord.americamark = [result stringForColumn:@"americamark"];
            tmpWord.meanings = [result stringForColumn:@"meanings"];
            tmpWord.progress = [result intForColumn:@"value"];
            tmpWord.hint = [result stringForColumn:@"hint"];
            [allDict setObject:tmpWord forKey:tmpWord.word];
            cnt ++;
        }
        NSLog(@"load all words , number : %d",cnt);
    }
}

+ (void)loadCategorys
{
    NSLog(@"in loadCategorys");
    
    if (categoryDict == nil)
    {
        categoryDict = [[NSMutableDictionary alloc]init];
        NSString * sql = @"select * from attribute_id";
        FMResultSet *result = [dictDataBase executeQuery:sql];
        
        while ([result next])
        {
            NSInteger attribute_id = [result intForColumn:@"attributeid"];
            NSNumber *aWrappedId = [NSNumber numberWithInteger:attribute_id];
            NSString * attribute_name = [result stringForColumn:@"attributename"];
            int level = [result intForColumn:@"level"];
            
            Category * category = [[Category alloc]init];
            category.categoryid = attribute_id;
            category.categoryName = attribute_name;
            category.levelNum = level;
            [categoryDict setObject:category forKey:aWrappedId];
        }
    }
}

+ (NSMutableArray*)fetchCategoryWithLevel: (NSInteger)level
{
    NSLog(@"in fetchCategoryWithLevel");
    
    NSMutableArray * res = [[NSMutableArray alloc]init];
    
    if(categoryDict == nil)
    {
        [self loadCategorys];
    }
    
    for (NSNumber * categoryid in categoryDict)
    {
        Category *category = [categoryDict objectForKey:categoryid];
        if (category.levelNum == level)
        {
            [res addObject:category];
        }
    }
    return res;
}

+ (NSMutableArray*)fetchWordsWithCategoryId: (NSInteger)categoryid
{
    NSString * sql = [NSString stringWithFormat:@"select * from attribute where attribute_id = %d",categoryid];
    FMResultSet *result = [dictDataBase executeQuery:sql];
    NSMutableArray * res = [[NSMutableArray alloc]init];
    
    int cnt = 0;
    while ([result next])
    {
        NSString * word = [result stringForColumn:@"word"];
        [res addObject:[allDict objectForKey:word]];
        cnt++;
    }
    return res;
}

+ (BOOL)DictIsExist:(NSFileManager *)filemanager
{
    return [filemanager fileExistsAtPath:dictPath];
}

+ (CGFloat)calcProgressWithCategoryDict : (NSInteger)categoryId
{
    
    NSInteger totalProgress = 0;
    NSInteger currentProgress = 0;
    
    NSArray * array = [DictHelper fetchWordsWithCategoryId:categoryId];
    
    for (Word * word in array)
    {
        NSString * wordString = word.word;
        NSString * sql = [NSString stringWithFormat:@"select * from progress where word = '%@'",wordString];
        FMResultSet *result = [dictDataBase executeQuery:sql];
        while ([result next])
        {
            currentProgress += [result intForColumn:@"value"];
            totalProgress += [result intForColumn:@"goal"];
            break;
        }
    }
    //NSLog(@"currentProgress : %d totalProgress: %d",currentProgress,totalProgress);
    return currentProgress * 1.0f / totalProgress;
    
}

+ (BOOL)updateProgressWithWord:(NSString *)word withScore:(NSInteger)score
{
    NSLog(@"%@ : %d",word,score);
    
    BOOL success;
    NSInteger currentProgress = 0;
    NSInteger goal = 0;
    NSString * sql = [NSString stringWithFormat:@"select * from progress where word = '%@'",word];
    FMResultSet *result = [dictDataBase executeQuery:sql];
    
    while ([result next])
    {
        currentProgress = [result intForColumn:@"value"];
        goal = [result intForColumn:@"goal"];
        break;
    }
    
    currentProgress += score;
    currentProgress = MIN(currentProgress,goal);
    
    sql = [NSString stringWithFormat:@"update progress set value = %d where word = '%@'",currentProgress,word];
    
    success =  [dictDataBase executeUpdate:sql];
    return success;
}

@end
