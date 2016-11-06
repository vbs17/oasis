#import <AVFoundation/AVFoundation.h>

@interface MixerMeter : NSObject

@property (nonatomic, weak) AVAudioMixerNode *mixer;
@property (nonatomic, assign) NSInteger numberOfChannels;
@property (nonatomic, assign) AudioUnitParameterValue averagePowerForChannel0;
@property (nonatomic, assign) AudioUnitParameterValue averagePowerForChannel1;

- (void)setMeteringEnabled:(BOOL)enabled;
- (void)updateMeters;

@end