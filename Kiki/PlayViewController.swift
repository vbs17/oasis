

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    //曲はここ
    var songData:NSURL!
    var playSong:AVAudioPlayer!
    var timer = NSTimer()
    let recordSetting : [String : AnyObject] = [
        AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
        AVEncoderBitRateKey : 16,
        AVNumberOfChannelsKey: 2 ,
        AVSampleRateKey: 44100.0
    ]

    @IBOutlet weak var onbyou: UILabel!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var byou: UILabel!
    @IBOutlet weak var retake: UIButton!
    @IBOutlet weak var ok: UIButton!
    
    
    //秒数がすでに表示
    override func viewDidLoad() {
        super.viewDidLoad()
        //曲はここ
        let sound:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData!)
        playSong = sound
        sound.prepareToPlay()
        byou.text = formatTimeString(sound.duration)
        play.layer.cornerRadius = 37
        play.clipsToBounds = true
        back.layer.cornerRadius = 37
        back.clipsToBounds = true
    }
    
    //再生
    @IBAction func goPlay(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(PlayViewController.updatePlayingTime), userInfo: nil, repeats: true)
        playSong.play()
        play.enabled = false
        back.enabled = true
        
    }
    
    //巻き戻し
    @IBAction func goBack(sender: UIButton) {
        play.enabled = true
        back.enabled = false
        playSong.stop()
        playSong.prepareToPlay()
        playSong.currentTime = 0
    }
    
    //取り直し
    @IBAction func retake(sender: AnyObject) {
        playSong.stop()
        let deleteSong = try!AVAudioRecorder(URL: songData,settings:recordSetting)
        deleteSong.deleteRecording()
        let viewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Top") as! ViewController
        self.presentViewController(viewcontroller, animated: true, completion: nil)
        let manager = NSFileManager()
        if manager.fileExistsAtPath(songData.absoluteString){
            print("ok")
        }else{
            print("no")
        }
    }
    
    func updatePlayingTime() {
        onbyou.text = formatTimeString(playSong.currentTime)
        print(playSong.currentTime)
        print(playSong.duration)
    }

    func formatTimeString(d: Double) -> String {
        let s: Int = Int(d % 60)
        let m: Int = Int((d - Double(s)) / 60 % 60)
        let str = String(format: "%2d:%02d",  m, s)
        return str
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
