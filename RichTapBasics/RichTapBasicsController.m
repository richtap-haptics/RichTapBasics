//
//  RichTapBasicsController.m
//  RichTap-Test
//
//  Created by Silence on 2022/6/8.
//

#import "RichTapBasicsController.h"
#import "SourceLoader.h"
#import <AVFoundation/AVFoundation.h>
#import <RichTapSDK/RichTapSDK.h>


@interface RichTapBasicsController ()

@property (weak, nonatomic) IBOutlet UILabel *indicatorL;
@property (weak, nonatomic) IBOutlet UILabel *effectIdL;
@property (weak, nonatomic) IBOutlet UILabel *amplitudeL;
@property (weak, nonatomic) IBOutlet UILabel *extLoopNumL;
@property (weak, nonatomic) IBOutlet UILabel *extAmplitudeL;
@property (weak, nonatomic) IBOutlet UILabel *extFrequencyL;
@property (weak, nonatomic) IBOutlet UILabel *extIntervalL;

@property (nonatomic, assign) PrebakedEffectId effectId;
@property (nonatomic, assign) int amplitude;

@property (nonatomic, assign) int extLoop;
@property (nonatomic, assign) int extAmplitude;
@property (nonatomic, assign) int extFreq;
@property (nonatomic, assign) int extInterval;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation RichTapBasicsController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([RichTapHapticUtils supportRichTap]) {
        self.indicatorL.text = @"Congrats! Your device supports high-fidelity haptic feedback, which is powered by RichTap.";
    } else {
        self.indicatorL.text = @"Sorry, but your device only supports low-fidelity haptic feedback...";
    }
    
    self.effectId = RT_CLICK;
    self.amplitude = 100;
    
    self.extLoop = 0;
    self.extAmplitude = 100;
    self.extFreq = 0;
    self.extInterval = 0;
    
    [self initilizeAudioPlayer];
}

- (void)initilizeAudioPlayer {
    NSString *testAudioFilePath = [[SourceLoader sharedLoader] pathForWavFile:@"CarIgnite"];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:testAudioFilePath] error:nil];
    [self.audioPlayer prepareToPlay];
}

#pragma mark - Prebaked Events
- (IBAction)playPrebakedEffect:(id)sender {
    if (self.effectId < RT_CLICK || self.effectId > RT_GAMEOVER) { // Check is in prebaked ranges
        NSLog(@"EffectId index is over the range between RT_CLICK and RT_GAMEOVER");
        return;
    }
    
    NSError *err = nil;
    [RichTapHapticUtils playExtPreBaked:self.effectId strength:self.amplitude error:&err];
    if (nil != err) {
        NSLog(@"%@", err.debugDescription);
    }
}

- (IBAction)switchPlayPrevious:(id)sender {
    if (self.effectId <= RT_CLICK) {
        return;
    }
    self.effectId --;
    self.effectIdL.text = [NSString stringWithFormat:@"%lu+1001", (unsigned long)self.effectId];
}

- (IBAction)switchPlayNext:(id)sender {
    if (self.effectId >= RT_GAMEOVER) {
        return;
    }
    self.effectId ++;
    self.effectIdL.text = [NSString stringWithFormat:@"%lu+1001", (unsigned long)self.effectId];
}

- (IBAction)changeAmplitude:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.amplitude = (int)slider.value;
    self.amplitudeL.text = [NSString stringWithFormat:@"Amplitude(%ld)", (long)self.amplitude];
}

#pragma mark - Send ExtParameters Events
- (IBAction)playExtEffect:(id)sender {
    NSError *err = nil;
    NSString *testHeFilePath = [[SourceLoader sharedLoader] pathForHeFile:@"CarIgnite"];
    [RichTapHapticUtils playHaptic:testHeFilePath loop:self.extLoop amplitude:self.extAmplitude error:&err];
    if (nil != err) {
        NSLog(@"%@", err.debugDescription);
        return;
    }
    
    [RichTapHapticUtils sendLoopParameter:self.extAmplitude interval:self.extInterval error:&err];
    if (nil != err) {
        NSLog(@"%@", err.debugDescription);
    }
}

- (IBAction)stopExtEffect:(id)sender {
    NSError *err = nil;
    [RichTapHapticUtils stop:&err];
    if (err == nil) {
        NSLog(@"%@", err.debugDescription);
    }
}

- (IBAction)doReduceExtLoopParam:(id)sender {
    if (self.extLoop > -1) {
        self.extLoop -= 1;
    }
    
    self.extLoopNumL.text = [NSString stringWithFormat:@"%d", self.extLoop];
}

- (IBAction)doAddExtLoopParam:(id)sender {
    self.extLoop += 1;
    self.extLoopNumL.text = [NSString stringWithFormat:@"%d", self.extLoop];
}

- (IBAction)changeExtAmplitude:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.extAmplitude = (int)slider.value;
    self.extAmplitudeL.text = [NSString stringWithFormat:@"Amplitude(%d)", self.extAmplitude];
}

- (IBAction)changeExtFrequency:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.extFreq = (int)slider.value;
    self.extFrequencyL.text = [NSString stringWithFormat:@"Frequency(%d)", self.extFreq];
}

- (IBAction)changeExtInterval:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.extInterval = (int)slider.value;
    self.extIntervalL.text = [NSString stringWithFormat:@"Interval(%dms)", self.extInterval];
}

#pragma mark - Audia Test Events
- (IBAction)playAudioExample:(id)sender {
    // lite版本的SDK未针对音视频播放器做同步处理，可以咨询full版本
    NSString *testHeFilePath = [[SourceLoader sharedLoader] pathForHeFile:@"CarIgnite"];
    if (!_audioPlayer.isPlaying) {
        [_audioPlayer play];
        [RichTapHapticUtils playHaptic:testHeFilePath amplitude:255 freq:0 playProgress:^double{
            return self.audioPlayer.currentTime / self.audioPlayer.duration;
        } error:nil];
    }
}

- (void)dealloc {
    NSLog(@"dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
