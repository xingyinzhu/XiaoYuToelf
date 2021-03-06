//
//  GameControllerViewController.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level.h"
#import "Category.h"
#import "AudioController.h"
#import "TileView.h"
#import "HUDView.h"
#import "GameData.h"

typedef void (^CallbackBlock)();

@interface GameController : NSObject <TileDragDelegateProtocol>

@property (nonatomic, weak) UIView * gameView;

@property (nonatomic, strong) Level * level;

@property (nonatomic, strong) Category * category;

@property (strong, nonatomic) AudioController * audioController;

@property (strong, nonatomic) CallbackBlock onAnagramSolved;

@property (weak, nonatomic) HUDView * hud;

@property (strong, nonatomic) GameData * data;

- (void)dealCategoryWithLevel : (NSInteger)levelNum;

@end
