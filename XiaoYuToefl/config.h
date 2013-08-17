//
//  config.h
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#ifndef configed

#define passed      1
#define nopassed    0

#define ratio       2.5

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

#define kFZMWFontActionSheetTitle [UIFont fontWithName:@"FZMiaoWuS-GB" size:16.0]

#define kFZMWFontGameText (IS_IPAD ? [UIFont fontWithName:@"FZMiaoWuS-GB" size:50.0] : [UIFont fontWithName:@"FZMiaoWuS-GB" size:20.0])
#define kFZMWFontGameTextBig (IS_IPAD ? [UIFont fontWithName:@"FZMiaoWuS-GB" size:100.0] : [UIFont fontWithName:@"FZMiaoWuS-GB" size:40.0])
#define kFZMWFontNormalText (IS_IPAD ? [UIFont fontWithName:@"FZMiaoWuS-GB" size:30.0] : [UIFont fontWithName:@"FZMiaoWuS-GB" size:18.0])


#define kSoundDing  @"ding.mp3"
#define kSoundWrong @"wrong.m4a"
#define kSoundWin   @"win.mp3"

#define kAudioEffectFiles @[kSoundDing, kSoundWrong, kSoundWin]
//handy math functions
#define rad2deg(x) x * 180 / M_PI
#define deg2rad(x) x * M_PI / 180
#define randomf(minX,maxX) ((float)(arc4random() % (maxX - minX + 1)) + (float)minX)


#define koffsetTagValue 2013

#define kMarginTop (IS_IPAD ? 10 : 5)
#define kMarginLeft (IS_IPAD ? 50 : 20)

#define kStopwatchWidth (IS_IPAD ? 300 : 120)
#define kStopwatchHeight (IS_IPAD ? 100 : 40)

#define kPointslabelWidth (IS_IPAD ? 140 : 56)
#define kPointslabelHeight (IS_IPAD ? 70 : 28)

#define kgamePointsWidth (IS_IPAD ? 200 : 80)
#define kgamePointsHeight (IS_IPAD ? 70 : 28)

#define khintbtnWidth (IS_IPAD ? image.size.width : (image.size.width/ratio))
#define khintbtnHeight (IS_IPAD ? image.size.height : (image.size.height/ratio))

#define kSecondsLeft 60

#define kProgressBarWidth kCategorySidelength * 3 / 4
#define kProgressBarColor [UIColor colorWithRed:184.0f/255.0f green:134.0f/255.0f blue:11.0f/255.0f alpha:1.0f]

#define kEveryWordScore 5
#define configed 1
#endif