//
//  CCTextToSpeech.h
//  tToP
//
//  Created by He, Changchen on 5/14/15.
//  Copyright (c) 2015 com.Changchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, Language) {
    AF,SQ,AR,HY,CA,ZH_CN,ZH_TW,HR,CS,NL,DA,EN,EO,FI,FR,DE,EL,HT,HI,HU,IS,ID,It,JA,KO,LA,LV,MK,NOO,PL,PT,RO,RU,SR,SK,ES,SW,SV,TA,TH,TR,VI,CY
};

@protocol CCTextToSpeechDelegate<NSObject>
@optional
-(void)CCTextToSpeechStarted;
-(void)CCTextToSpeechDidGetError:(NSError*)error;
-(void)CCTextToSpeechStartedPlayingSpeech;
-(void)CCTextToSpeechEnded;
@end

@interface CCTextToSpeech : NSObject<AVAudioPlayerDelegate>
@property(weak,nonatomic)id<CCTextToSpeechDelegate> delegate;


+(instancetype)sharedInstance;
-(void)startPlayWithStringLanguage:(NSString*) language andText:(NSString*)text;
-(void)startPlayWithLanguage:(Language) language andText:(NSString*)text;

@end
