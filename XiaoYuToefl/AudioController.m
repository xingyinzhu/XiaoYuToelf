//
//  AudioController.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "AudioController.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudioController
{
  NSMutableDictionary* audio;
}

-(void)preloadAudioEffects:(NSArray*)effectFileNames
{
    //initialize the effects array
    if (audio == Nil)
    {
        audio = [[NSMutableDictionary alloc]init];
    }

    //loop over the filenames
    for (NSString* effect in effectFileNames)
    {
        //1 get the file path URL
        NSString* soundPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: effect];
        NSURL* soundURL = [NSURL fileURLWithPath: soundPath];        //2 load the file contents
        NSError* loadError = nil;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error: &loadError];
        NSAssert(loadError==nil, @"load sound failed");

        //3 prepare the play
        player.numberOfLoops = 0;
        [player prepareToPlay];
    
        //4 add to the array ivar
        audio[effect] = player;
    }
}

-(void)playEffect:(NSString*)name
{
  NSAssert(audio[name], @"effect not found");
  
  AVAudioPlayer* player = (AVAudioPlayer*)audio[name];
  if (player.isPlaying) {
    player.currentTime = 0;
  } else {
    [player play];
  }
}

@end
