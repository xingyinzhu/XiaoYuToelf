//
//  CategoryView.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-11.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryView : UIImageView

@property (strong, nonatomic, readonly) NSString * categoryName;
@property (assign, nonatomic) NSInteger categoryid;

-(instancetype)initWithName:(NSString*)categoryName andSideLength:(float)sideLength;

@end
