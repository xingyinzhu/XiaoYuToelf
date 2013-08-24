//
//  helper.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-11.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "helper.h"

@implementation helper

+ (NSString *)randomWordString:(NSString *)string
{
    int length = [string length];
    bool used[length];
    for (NSUInteger i = 0U; i < length; i++)
    {
        used[i]=false;
    }
    NSMutableString *res = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0U; i < length; i++)
    {
        u_int32_t r = arc4random() % length;
        while (used[r])
        {
            r = arc4random() % length;
        }
        used[r] = true;
        unichar c = [string characterAtIndex:r];
        [res appendFormat:@"%C", c];
    }
    return res;
}

+ (NSString *)get_filename:(NSString *)name
{
    //return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
    //        stringByAppendingPathComponent:name];
    
    return  [[NSBundle mainBundle]
             pathForResource:name
             ofType:nil];
}

+ (BOOL)is_file_exist:(NSString *)name
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:[self get_filename:name]];
}

@end
