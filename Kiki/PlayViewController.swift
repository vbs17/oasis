

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var songData:NSURL!
    var playSong:AVAudioPlayer!
    let recordSetting : [String : AnyObject] = [
        //オーディオデータを設定の通りに全て取りこんでると大量のデータになってしまうので、圧縮//.minのとこ音質変えれる
        AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
        AVEncoderBitRateKey : 16,//1枚のページにたして16の情報をかけてる
        AVNumberOfChannelsKey: 2 , //イヤホンも左右から違う音が聞こえる
        AVSampleRateKey: 44100.0 //これが多ければ多いほどスムーズ
    ]

   
    
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var byou: UILabel!
    
    
    //秒数がすでに表示
    override func viewDidLoad() {
        super.viewDidLoad()
        let sound:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData!)
        playSong = sound
        byou.text = sound.duration.description
        sound.prepareToPlay()
        byou.text = formatTimeString(sound.duration)
        play.layer.cornerRadius = 37
        play.clipsToBounds = true
        back.layer.cornerRadius = 37
        back.clipsToBounds = true
    }
    
    //再生
    @IBAction func goPlay(sender: AnyObject) {
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
    
    @IBAction func retake(sender: AnyObject) {
        let deleteSong = try!AVAudioRecorder(URL: songData,settings:recordSetting)
        deleteSong.deleteRecording()
        self.dismissViewControllerAnimated(true, completion: nil)
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
