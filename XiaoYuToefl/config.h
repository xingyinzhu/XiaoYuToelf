//
//  config.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#ifndef configed

//UI defines
#define kScreenWidth [UIScreen mainScreen].bounds.size.height
#define kScreenHeight [UIScreen mainScreen].bounds.size.width

//add more definitions here
#define IS_IPAD    (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define kTileMargin (IS_IPAD ? 20 : 8)

#define kCategorySidelength (IS_IPAD ? 100 : 60)

//#define kCategoryColNum (kScreenHeight / (kTileMargin + kCategorySidelength))
//#define kCategoryRowNum (kScreenWidth / (kTileMargin + kCategorySidelength))

#define kFontHUD [UIFont fontWithName:@"comic andy" size:62.0]
#define kFontHUDBig [UIFont fontWithName:@"comic andy" size:120.0]

#define kFZMWFont (IS_IPAD ? [UIFont fontWithName:@"FZMiaoWuS-GB" size:30.0] : [UIFont fontWithName:@"FZMiaoWuS-GB" size:20.0])

#define kSoundDing  @"ding.mp3"
#define kSoundWrong @"wrong.m4a"
#define kSoundWin   @"win.mp3"

#define kAudioEffectFiles @[kSoundDing, kSoundWrong, kSoundWin]
//handy math functions
#define rad2deg(x) x * 180 / M_PI
#define deg2rad(x) x * M_PI / 180
#define randomf(minX,maxX) ((float)(arc4random() % (maxX - minX + 1)) + (float)minX)


#define koffsetTagValue 2013

#define configed 1
#endif