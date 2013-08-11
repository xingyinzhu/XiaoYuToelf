//
//  TileView.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TileView;

@protocol TileDragDelegateProtocol <NSObject>
-(void)tileView:(TileView*)tileView didDragToPoint:(CGPoint)pt;
@end

@interface TileView : UIImageView

@property (strong, nonatomic, readonly) NSString* letter;
@property (assign, nonatomic) BOOL isMatched;
@property (weak, nonatomic) id<TileDragDelegateProtocol> dragDelegate;

-(instancetype)initWithLetter:(NSString*)letter andSideLength:(float)sideLength;

-(void)randomize;

@end
