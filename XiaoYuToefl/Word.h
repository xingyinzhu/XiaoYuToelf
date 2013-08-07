//
//  Word.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject

@property (nonatomic, copy) NSString * word;
@property (nonatomic, copy) NSString * englishmark;
@property (nonatomic, copy) NSString * americamark;
@property (nonatomic, copy) NSString * meanings;
@property (nonatomic, copy) NSString * group;
@property (nonatomic, copy) NSString * hint;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger progress;

@end
