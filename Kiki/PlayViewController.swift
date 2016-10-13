

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var songData:NSURL!
    var playSong:AVAudioPlayer!
    let deleteSong:AVAudioRecorder!
    
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
        deleteSong.url =
        deleteSong.deleteRecording()
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
