# CCTextToSpeech
CCTextToSpeech is a very ligte wight freamwork that converts your text to speech. The framework is using google's open TTS server to retrive converted audio from google service. 

CCTextToSpeech是一个轻量级的文字音频转换框架。此框架使用google的TTS服务。

Example useage:
```objc
CCTextToSpeech * t2p = [CCTextToSpeech sharedInstance];
t2p.delegate = self;
[t2p startPlayWithLanguage:EN andText:@"Hi,what's up"];
```

Optional delegates:
```objc
-(void)CCTextToSpeechStarted;
-(void)CCTextToSpeechDidGetError:(NSError*)error;
-(void)CCTextToSpeechStartedPlayingSpeech;
-(void)CCTextToSpeechEnded;
```

all suppported languages：
所有支持的语言：

```
'af' : 'Afrikaans',
'sq' : 'Albanian',
'ar' : 'Arabic',
'hy' : 'Armenian',
'ca' : 'Catalan',
'zh-CN' : 'Mandarin (simplified)',
'zh-TW' : 'Mandarin (traditional)',
'hr' : 'Croatian',
'cs' : 'Czech',
'da' : 'Danish',
'nl' : 'Dutch',
'en' : 'English',
'eo' : 'Esperanto',
'fi' : 'Finnish',
'fr' : 'French',
'de' : 'German',
'el' : 'Greek',
'ht' : 'Haitian Creole',
'hi' : 'Hindi',
'hu' : 'Hungarian',
'is' : 'Icelandic',
'id' : 'Indonesian',
'it' : 'Italian',
'ja' : 'Japanese',
'ko' : 'Korean',
'la' : 'Latin',
'lv' : 'Latvian',
'mk' : 'Macedonian',
'no' : 'Norwegian',
'pl' : 'Polish',
'pt' : 'Portuguese',
'ro' : 'Romanian',
'ru' : 'Russian',
'sr' : 'Serbian',
'sk' : 'Slovak',
'es' : 'Spanish',
'sw' : 'Swahili',
'sv' : 'Swedish',
'ta' : 'Tamil',
'th' : 'Thai',
'tr' : 'Turkish',
'vi' : 'Vietnamese',
'cy' : 'Welsh'
```
