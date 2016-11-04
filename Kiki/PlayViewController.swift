

import UIKit
import AVFoundation
import MediaPlayer

class PlayViewController: UIViewController {
    //曲はここ
    //filenameをsongDataに渡す
    var songData:NSURL!
    var playSong:AVAudioPlayer!
    var timer = NSTimer()
    let recordSetting : [String : AnyObject] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVNumberOfChannelsKey: 1 ,
        AVSampleRateKey: 44100
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
        play.layer.cornerRadius = 15
        play.clipsToBounds = true
        back.layer.cornerRadius = 15
        back.clipsToBounds = true
        retake.layer.cornerRadius = 10
        retake.clipsToBounds = true
        ok.layer.cornerRadius = 10
        ok.clipsToBounds = true
    }
    //ここら辺
    @IBAction func kasane(sender: AnyObject) {
        playSong.stop()
        timer.invalidate()
        let recviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Top2") as! _TViewController
        recviewcontroller.songData = songData

        self.presentViewController(recviewcontroller, animated: true, completion: nil)
    }
    
    //再生
    @IBAction func goPlay(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(PlayViewController.updatePlayingTime), userInfo: nil, repeats: true)
        playSong.play()
        play.enabled = false
        back.enabled = true
    }
    
    //mp3に圧縮させて投稿
    @IBAction func gok(sender: AnyObject) {
        playSong.stop()
        timer.invalidate()
        let sendviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Send") as! SendViewController
        sendviewcontroller.songData = songData
         self.presentViewController(sendviewcontroller, animated: true, completion: nil)
    }
    
       //巻き戻し
    @IBAction func goBack(sender: UIButton) {
        onbyou.text = "0:00"
        play.enabled = true
        back.enabled = false
        playSong.stop()
        timer.invalidate()
        playSong.prepareToPlay()
        playSong.currentTime = 0
    }
    
    //取り直し
    @IBAction func retake(sender: AnyObject) {
        playSong.stop()
        timer.invalidate()
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
