//
//  CategoryView.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-11.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "CategoryView.h"
#include "config.h"

@implementation CategoryView

- (id)init
{
    NSAssert(NO, @"Use initWithName:andSideLength instead");
    return nil;
}

- (id)initWithImage:(UIImage *)image
{
    NSAssert(NO, @"Use initWithName:andSideLength instead");
    return nil;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    NSAssert(NO, @"Use initWithName:andSideLength instead");
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSAssert(NO, @"Use initWithName:andSideLength instead");
    return nil;
}

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithName:andSideLength instead");
    return nil;
}


-(instancetype)initWithName:(NSString*)categoryName andSideLength:(float)sideLength
{
    UIImage * img = [UIImage imageNamed:@"tile.png"];
    
    self = [super initWithImage:img];
    
    if (self != nil)
    {
        float scale = sideLength/img.size.width;
        self.bounds = CGRectMake(0, 0, img.size.width*scale, img.size.height*scale);
        
        //add category_name on top
        UILabel *lblChar = [[UILabel alloc]initWithFrame:self.bounds];
        lblChar.textAlignment = NSTextAlignmentCenter;
        lblChar.textColor = [UIColor whiteColor];
        lblChar.text = categoryName;
        lblChar.backgroundColor = [UIColor clearColor];
        lblChar.font = kFZMWFontNormalText;
        [self addSubview:lblChar];
        
        _categoryName = categoryName;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

@end
