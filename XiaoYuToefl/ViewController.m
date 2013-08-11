//
//  ViewController.m
//  XiaoYuToefl
//
//  Created by Xingyin Zhu on 13-8-7.
//  Copyright (c) 2013年 Xingyin Zhu. All rights reserved.
//

#import "ViewController.h"
#import "GameController.h"
#import "config.h"
#import "Word.h"

@interface ViewController () <UIActionSheetDelegate>
@property(strong, nonatomic) GameController * controller;
@end

@implementation ViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        self.controller = [[GameController alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIView * gameLayer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:gameLayer];
    
    self.controller.gameView = gameLayer;
    
    __weak ViewController* weakSelf = self;
    self.controller.onAnagramSolved = ^(){
        [weakSelf showLevelMenu];
    };

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //todo
    /*
    self.controller.category = [Category categoryWithId:1];
    [self.controller dealRandomWord];
    */
    
    [self showLevelMenu];
}

- (void)randomTest
{
    self.controller.level = [Level levelWithNum:1];
    self.controller.category = [Category categoryWithId:1];
    [self.controller dealRandomWord];

}

- (void)showLevelMenu
{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"选择难度"
                                                delegate:self
                                                cancelButtonTitle:nil
                                                destructiveButtonTitle:nil
                                                otherButtonTitles:@"初级",@"中级",@"高级", nil];
    
    [action showInView:self.view];
}

//level was selected, load it up and start the game
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == -1)
    {
        [self showLevelMenu];
        return;
    }
    
    int levelNum = buttonIndex + 1;
    
    //todo tmp test
    if (levelNum == 2)
    {
        self.controller.level = [Level levelWithNum:levelNum];
        [self.controller dealCategoryWithLevel:levelNum];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
