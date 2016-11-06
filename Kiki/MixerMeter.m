#import "MixerMeter.h"

@implementation MixerMeter

- (void)setMeteringEnabled:(BOOL)enabled;
{
    UInt32 on = (enabled)?1:0;
    AVAudioIONode *node = (AVAudioIONode*)self.mixer;
    OSStatus err = AudioUnitSetProperty(node.audioUnit, kAudioUnitProperty_MeteringMode, kAudioUnitScope_Output, 0, &on, sizeof(on));
    if (err != 0) {
        NSLog(@"AudioUnitSetProperty kAudioUnitProperty_MeteringMode %d",err);
    }
}

- (void)updateMeters;
{
    AVAudioIONode *node = (AVAudioIONode*)self.mixer;
    
    AudioUnitParameterValue level;
    OSStatus err = AudioUnitGetParameter(node.audioUnit, kMultiChannelMixerParam_PostAveragePower, kAudioUnitScope_Output, 0, &level);
    if (err != 0) {
        NSLog(@"AudioUnitGetParameter kMultiChannelMixerParam_PostAveragePower0 %d",err);
    }
    
    self.averagePowerForChannel1 = self.averagePowerForChannel0 = level;
    if(self.numberOfChannels>1)
    {
        OSStatus err = AudioUnitGetParameter(node.audioUnit, kMultiChannelMixerParam_PostAveragePower+1, kAudioUnitScope_Output, 0, &level);
        if (err != 0) {
            NSLog(@"AudioUnitGetParameter kMultiChannelMixerParam_PostAveragePower1 %d",err);
        }
    }
}
@end