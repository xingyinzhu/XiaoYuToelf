//
//  GameControllerViewController.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "GameController.h"
#import "config.h"
#import "TargetView.h"
#import "Word.h"
#import "ExplodeView.h"
#import "StarDustView.h"
#import "helper.h"
#import "CategoryView.h"

@interface GameController ()

@end

@implementation GameController
{
    //tile lists
    NSMutableArray * _tiles;
    NSMutableArray * _targets;
    NSMutableArray * _passed;
    NSInteger        currentWordIndex;
    
    //stopwatch variables
    int _secondsLeft;
    NSTimer* _timer;
}

-(instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        self.audioController = [[AudioController alloc]init];
        [self.audioController preloadAudioEffects:kAudioEffectFiles];
    }
    return self;
}

- (void)dealCategoryWithLevel : (NSInteger)levelNum
{
    NSAssert(self.level.categorys, @"no level loaded");
    NSLog(@"in dealCategoryWithLevel");
    
    int totalCount = [self.level.categorys count];
    
    NSLog(@"kScreenWidth : %f kScreenHeight : %f",kScreenWidth,kScreenHeight);
    
    int kCategoryColNum = (int)((kScreenWidth / (kTileMargin + kCategorySidelength)));
    int kCategoryRowNum = (int)((kScreenHeight / (kTileMargin + kCategorySidelength)));
    int pages = ceilf(totalCount * 1.0 / ( kCategoryColNum * kCategoryRowNum));
    
    //平均间距
    int averageColMargin = (kScreenWidth - kCategoryColNum * kCategorySidelength) / (kCategoryColNum + 1);
    int averageRowMargin = (kScreenHeight - kCategoryRowNum * kCategorySidelength) / (kCategoryRowNum + 1);
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [scrollView setContentSize:CGSizeMake(pages * kScreenWidth, kScreenHeight)];
    [self.gameView addSubview:scrollView];
    
    int index = 0;
    int currentRow = 0;
    int currentCol = 0;
    
    for (Category * category in self.level.categorys)
    {
        CategoryView * categoryView = [[CategoryView alloc]initWithName:category.categoryName andSideLength:kCategorySidelength];
        categoryView.frame = CGRectMake(currentCol*kCategorySidelength + averageColMargin*(currentCol+1),
                                        currentRow*kCategorySidelength + averageRowMargin*(currentRow+1),
                                        kCategorySidelength, kCategorySidelength);
     
        UIButton * button = [[UIButton alloc]initWithFrame:categoryView.frame];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTag:koffsetTagValue + category.categoryid];
        [button addTarget:self action:@selector(categoryViewPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:categoryView];
        scrollView.showsHorizontalScrollIndicator = NO;
        [scrollView addSubview:button];
        
        index++;
        currentRow++;
        if (currentRow == kCategoryRowNum)
        {
            currentRow = 0;
            currentCol ++;
        }
    }
}

- (void)categoryViewPressed:(UIButton *)sender
{
    int categoryid = sender.tag - koffsetTagValue;
    NSLog(@"%d",categoryid);
    _category = [Category categoryWithId:categoryid];
    [self clearBoard];
    NSLog(@"%d",[self.category.categoryDict count]);
    
    
    int totalCount = self.category.categoryDict.count;
    _passed = [[NSMutableArray alloc]initWithCapacity:totalCount];
    for (int i = 0 ; i < totalCount ; i++)
    {
        _passed[i] = [NSNumber numberWithInteger:nopassed];
    }
    
    [self startGameByRandomSelect];
    [_hud setHidden:NO];
}

- (void)startGameByRandomSelect
{
    int totalCount = self.category.categoryDict.count;
    currentWordIndex = arc4random() % totalCount;
    while ([_passed[currentWordIndex] integerValue]  == passed)
    {
        currentWordIndex = arc4random() % totalCount;
    }
        
    [self dealOneWordWithIndex];
}

- (void)dealOneWordWithIndex
{
    NSAssert(self.category.categoryDict, @"no dict loaded");
    
    Word *word = self.category.categoryDict[currentWordIndex];
    NSString *wordString = word.word;
    
    int length = [wordString length];
    
    //calculate the tile size
    NSLog(@"kTileMargin : %d",kTileMargin);
    float tileSide = ceilf( kScreenWidth*0.9 / (float)length) - kTileMargin;
    
    //get the left margin for first tile
    float xOffset = (kScreenWidth - length * (tileSide + kTileMargin))/2;
    
    //adjust for tile center (instead the tile's origin)
    xOffset += tileSide/2;
    
    // initialize target list
    _targets = [NSMutableArray arrayWithCapacity: length];
    
    // create targets
    for (int i=0;i<length;i++)
    {
        NSString* letter = [wordString substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "])
        {
            TargetView* target = [[TargetView alloc] initWithLetter:letter andSideLength:tileSide];
            target.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4);
            
            [self.gameView addSubview:target];
            [_targets addObject: target];
        }
    }
    
    //initialize tile list
    _tiles = [NSMutableArray arrayWithCapacity: length];
    
    //create tiles
    NSString * randomString = [helper randomWordString:wordString];
    for (int i=0;i<length;i++)
    {
        NSString* letter = [randomString substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "])
        {
            TileView* tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
            tile.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4*3);
            [tile randomize];
            tile.dragDelegate = self;
            
            [self.gameView addSubview:tile];
            [_tiles addObject: tile];
        }
    }
    
    //start the timer
    [self startStopwatch];
}

//a tile was dragged, check if matches a target
-(void)tileView:(TileView*)tileView didDragToPoint:(CGPoint)pt
{
    TargetView* targetView = nil;
    
    for (TargetView* tv in _targets)
    {
        if (CGRectContainsPoint(tv.frame, pt))
        {
            targetView = tv;
            break;
        }
    }
    
    // check if target was found
    if (targetView!=nil)
    {
        
        // check if letter matches
        if ([targetView.letter isEqualToString: tileView.letter])
        {
            
            [self placeTile:tileView atTarget:targetView];
            
            //more stuff to do on success here
            [self.audioController playEffect: kSoundDing];
            
            //give points
            //self.data.points += self.level.pointsPerTile;
            //[self.hud.gamePoints countTo:self.data.points withDuration:1.5];
            
            //check for finished game
            [self checkForSuccess];
        }
        else
        {
            //visualize the mistake
            [tileView randomize];
            
            [UIView animateWithDuration:0.35
                                  delay:0.00
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 tileView.center = CGPointMake(tileView.center.x + randomf(-20, 20),
                                                               tileView.center.y + randomf(20, 30));
                             } completion:nil];
            
            //more stuff to do on failure here
            [self.audioController playEffect:kSoundWrong];
            
            //take out points
            //self.data.points -= self.level.pointsPerTile/2;
            //[self.hud.gamePoints countTo:self.data.points withDuration:.75];
        }
    }
}

-(void)placeTile:(TileView*)tileView atTarget:(TargetView*)targetView
{
    targetView.isMatched = YES;
    tileView.isMatched = YES;
    
    tileView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.35
                          delay:0.00
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tileView.center = targetView.center;
                         tileView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished){
                         targetView.hidden = YES;
                     }];
    
    ExplodeView* explode = [[ExplodeView alloc] initWithFrame:CGRectMake(tileView.center.x,tileView.center.y,10,10)];
    [tileView.superview addSubview: explode];
    [tileView.superview sendSubviewToBack:explode];
}

- (BOOL)isPassedTest
{
    //check if passed all the words test
    int totalCount = [self.category.categoryDict count];
    for (int i = 0; i < totalCount ; i++)
    {
        if ([_passed[i] integerValue] == nopassed)
            return FALSE;
    }
    
    [self.audioController playEffect:kSoundWin];
    
    //win animation
    TargetView* firstTarget = _targets[0];
    
    int startX = 0;
    int endX = kScreenWidth + 300;
    int startY = firstTarget.center.y;
    
    StarDustView* stars = [[StarDustView alloc] initWithFrame:CGRectMake(startX, startY, 10, 10)];
    [self.gameView addSubview:stars];
    [self.gameView sendSubviewToBack:stars];
    
    [UIView animateWithDuration:3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         stars.center = CGPointMake(endX, startY);
                     } completion:^(BOOL finished) {
                         
                         //game finished
                         [stars removeFromSuperview];
                         
                         //when animation is finished, show menu
                         [self clearBoard];
                         [_hud setHidden:YES];
                         self.onAnagramSolved();
                     }];
    
    return TRUE;
}

- (void)checkForSuccess
{
    for (TargetView* t in _targets)
    {
        //no success, bail out
        if (t.isMatched==NO) return;
    }
    
    NSLog(@"Game Over!");
    
    //stop the stopwatch
    [self stopStopwatch];
    
    _passed[currentWordIndex] = [NSNumber numberWithInteger:passed];
    
    if ([self isPassedTest] == FALSE)
    {
        [self clearBoard];
        [self startGameByRandomSelect];
    }
    
}

//clear the tiles and targets
-(void)clearBoard
{
    [_tiles removeAllObjects];
    [_targets removeAllObjects];
    
    for (UIView *view in self.gameView.subviews)
    {
        [view removeFromSuperview];
    }
}

-(void)startStopwatch
{
    //initialize the timer HUD
    //todo
    _secondsLeft = kSecondsLeft;
    [self.hud.stopwatch setSeconds:kSecondsLeft];
    
    //schedule a new timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(tick:)
                                            userInfo:nil
                                             repeats:YES];
}

//stopwatch on tick
-(void)tick:(NSTimer*)timer
{
    _secondsLeft --;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    
    if (_secondsLeft==0) {
        [self stopStopwatch];
    }
}

//stop the watch
-(void)stopStopwatch
{
    [_timer invalidate];
    _timer = nil;
}

//connect the Hint button
-(void)setHud:(HUDView *)hud
{
    _hud = hud;
    [hud.btnHelp addTarget:self action:@selector(actionHint) forControlEvents:UIControlEventTouchUpInside];
}

//the user pressed the hint button
-(void)actionHint
{
    self.hud.btnHelp.enabled = NO;
    
    //self.data.points -= self.level.pointsPerTile/2;
    //[self.hud.gamePoints countTo: self.data.points withDuration: 1.5];
    
    // find the first target, not matched yet
    TargetView* target = nil;
    for (TargetView* t in _targets) {
        if (t.isMatched==NO) {
            target = t;
            break;
        }
    }
    
    // find the first tile, matching the target
    TileView* tile = nil;
    for (TileView* t in _tiles) {
        if (t.isMatched==NO && [t.letter isEqualToString:target.letter]) {
            tile = t;
            break;
        }
    }
    
    // don't want the tile sliding under other tiles
    [self.gameView bringSubviewToFront:tile];
    
    //show the animation to the user
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tile.center = target.center;
                     } completion:^(BOOL finished) {
                         // adjust view on spot
                         [self placeTile:tile atTarget:target];
                         
                         // check for finished game
                         [self checkForSuccess];
                         
                         // re-enable the button
                         self.hud.btnHelp.enabled = YES;
                     }];
    
}

@end
