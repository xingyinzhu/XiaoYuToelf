//
//  helper.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-11.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface helper : NSObject

+ (NSString *)randomWordString:(NSString *)string;

+ (BOOL)is_file_exist:(NSString *)name;
@end
