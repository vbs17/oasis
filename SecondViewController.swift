import UIKit
import Foundation
import UIKit
import AVFoundation
import CoreAudio

class SecondViewController: UIViewController {

    var recorder: AVAudioRecorder!
    var levelTimer = NSTimer()
    var lowPassResults: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioSession.setActive(true, error: nil)
        
        var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        var str =  documents.stringByAppendingPathComponent("recordTest.caf")
        var url = NSURL.fileURLWithPath(str as String)
        
        var recordSettings: [NSObject : AnyObject] = [AVFormatIDKey:kAudioFormatAppleIMA4,
                                                      AVSampleRateKey:44100.0,
                                                      AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
                                                      AVLinearPCMBitDepthKey:16,
                                                      AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
            
        ]
        
        var error: NSError?
        
       
        recorder = AVAudioRecorder(URL:url, settings: recordSettings, error: &error)
        if let e = error {
            print(e.localizedDescription)
        } else {//ここから調べろボケ
            recorder.prepareToRecord()
            recorder.meteringEnabled = true
            //1点目のポイント
            recorder.record()
            //で0.02秒のタイマーをかけています.こんなに早いタイマーじゃなくても、0.1秒くらいでよさそうにも思います。
            self.levelTimer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(SecondViewController.levelTimerCallback), userInfo: nil, repeats: true)
            
        }
        
    }
    
    //これが、タイマー処理
    func levelTimerCallback() {
        recorder.updateMeters()
  //このaveragePowerForChannel(0)やaveragePowerForChannel(0)が、録音中の音量レベルです。これを取得してグラフ表示すればいい
        if recorder.averagePowerForChannel(0) > -7 {
            print("Dis be da level I'm hearin' you in dat mic ")
            print(recorder.averagePowerForChannel(0))
            print("Do the thing I want, mofo")
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
