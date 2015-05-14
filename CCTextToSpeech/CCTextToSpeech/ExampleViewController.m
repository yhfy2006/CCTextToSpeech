//
//  ViewController.m
//  CCTextToSpeech
//
//  Created by He, Changchen on 5/14/15.
//  Copyright (c) 2015 com.Changchen. All rights reserved.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()<CCTextToSpeechDelegate>

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    CCTextToSpeech * t2p = [CCTextToSpeech sharedInstance];
    t2p.delegate = self;
    [t2p startPlayWithLanguage:EN andText:@"Hi,what's up"];
}

-(void)CCTextToSpeechStarted
{
    NSLog(@"started");
}

-(void)CCTextToSpeechStartedPlayingSpeech{
    NSLog(@"started playing");
}

-(void)CCTextToSpeechDidGetError:(NSError*)error;
{
    NSLog(@"%@",error);
}
-(void)CCTextToSpeechEnded
{
    NSLog(@"stopped");
}

@end
