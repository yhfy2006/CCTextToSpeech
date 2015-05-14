//
//  CCTextToSpeech.m
//  tToP
//
//  Created by He, Changchen on 5/14/15.
//  Copyright (c) 2015 com.Changchen. All rights reserved.
//

#import "CCTextToSpeech.h"


#define languageString(Language) [@[@"af",@"sq",@"ar",@"hy",@"ca",@"zh_CN",@"zh_TW",@"hr",@"cs",@"nl",@"da",@"en",@"eo",@"fi",@"fr",@"de",@"el",@"ht",@"hi",@"hu",@"is",@"id",@"it",@"ja",@"ko",@"la",@"lv",@"mk",@"no",@"pl",@"pt",@"ro",@"ru",@"sr",@"sk",@"es",@"sw",@"sv",@"ta",@"th",@"tr",@"vi",@"cy"] objectAtIndex:Language]
@interface CCTextToSpeech() 
@property (nonatomic, strong)NSString * defaultFilePath;
@property (nonatomic,strong)AVAudioPlayer  *player;
@end

@implementation CCTextToSpeech

+ (instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

-(NSString*)defaultFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"googleTTS.mp3"];
    return  path;
}

-(NSString*)getLanguageStringFromEnum:(Language) languageEnum{
    return languageString(languageEnum);
}

-(void)startPlayWithStringLanguage:(NSString*) language andText:(NSString*)text
{
    
    if ([self.delegate respondsToSelector:@selector(CCTextToSpeechStarted)]) {
        [self.delegate CCTextToSpeechStarted];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.translate.google.com/translate_tts?tl=%@&q=%@",language,text];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" forHTTPHeaderField:@"User-Agent"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            if ([self.delegate respondsToSelector:@selector(CCTextToSpeechDidGetError:)]) {
                [self.delegate CCTextToSpeechDidGetError:connectionError];
            }
        }else
        {
            [data writeToFile:self.defaultFilePath atomically:YES];
            [self playAudio];
        }
    }];
}

-(void)playAudio
{
    NSError *err;
    if ([self.delegate respondsToSelector:@selector(CCTextToSpeechStartedPlayingSpeech)]) {
        [self.delegate CCTextToSpeechStartedPlayingSpeech];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.defaultFilePath])
    {
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:
                   [NSURL fileURLWithPath:self.defaultFilePath] error:&err];
        if (err) {
            if ([self.delegate respondsToSelector:@selector(CCTextToSpeechDidGetError:)]) {
                [self.delegate CCTextToSpeechDidGetError:err];
            }
            return;
        }
        _player.delegate = self;
        _player.volume = 0.4f;
        [_player prepareToPlay];
        [_player setNumberOfLoops:0];
        [_player play];
    }
}


-(void)startPlayWithLanguage:(Language) language andText:(NSString*)text{
    NSString * strLanguage = [self getLanguageStringFromEnum:language];
    [self startPlayWithStringLanguage:strLanguage andText:text];
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSError *err;
    [[NSFileManager defaultManager] removeItemAtPath:self.defaultFilePath error:&err];
    if ([self.delegate respondsToSelector:@selector(CCTextToSpeechEnded)]) {
        [self.delegate CCTextToSpeechEnded];
    }
}


@end
