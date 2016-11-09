
import UIKit
import AVFoundation
import MediaPlayer


class Play2ViewController: UIViewController {
    var songData2:NSURL!
    var songData:NSURL!
    var playSong:AVAudioPlayer!
    var timer = NSTimer()
    let recordSetting : [String : AnyObject] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVNumberOfChannelsKey: 1 ,
        AVSampleRateKey: 44100
    ]
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var byou: UILabel!
    @IBOutlet weak var retake: UIButton!
    @IBOutlet weak var ok: UIButton!
    @IBOutlet weak var onbyou: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //二つとも再生
        let sound2:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData2!)
        playSong = sound2
        sound2.prepareToPlay()
        
        
    }
    //二つとも再生
    @IBAction func playGo(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(PlayViewController.updatePlayingTime), userInfo: nil, repeats: true)
        playSong.play()
        play.enabled = false
        back.enabled = true
    }
    @IBAction func backGo(sender: AnyObject) {
        onbyou.text = "0:00"
        play.enabled = true
        back.enabled = false
        playSong.stop()
        playSong.prepareToPlay()
        playSong.currentTime = 0

    }
    //保存したのを送る
    @IBAction func okGo(sender: AnyObject) {
        playSong.stop()
        timer.invalidate()
        let sendviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Send") as! SendViewController
        sendviewcontroller.songData = songData2
        self.presentViewController(sendviewcontroller, animated: true, completion: nil)
        
    }
    
    @IBAction func retakeGo(sender: AnyObject) {
        playSong.stop()
        timer.invalidate()
        let deleteSong = try!AVAudioRecorder(URL: songData2,settings:recordSetting)
        deleteSong.deleteRecording()
        let viewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Top2") as! _TViewController
        viewcontroller.songData = self.songData
        self.presentViewController(viewcontroller, animated: true, completion: nil)
        let manager = NSFileManager()
        if manager.fileExistsAtPath(songData2.absoluteString){
            print("ok")
        }else{
            print("no")
        }

    }
    
    func updatePlayingTime() {
        //細かすぎるとあうわけないから
        if  floor(playSong.currentTime) ==  floor(playSong.duration) {
            timer.invalidate()
            onbyou.text = formatTimeString(playSong.duration)
            return
        }
        
        onbyou.text = formatTimeString(playSong.currentTime)
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
