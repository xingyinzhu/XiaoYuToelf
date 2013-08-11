//
//  Level.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-10.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

@interface Level : NSObject

@property (nonatomic,strong) NSArray * categorys;

+(instancetype) levelWithNum:(int)levelNum;

@end
