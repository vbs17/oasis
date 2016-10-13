

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var songData:NSURL!
    var timeCount = 1
    var soundIdRing:SystemSoundID = 0
    
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var byou: UILabel!
    @IBOutlet weak var onbyou: UILabel!
    
    //秒数がすでに表示
    override func viewDidLoad() {
        super.viewDidLoad()
        let sound:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData!)
        byou.text = sound.duration.description
    }
    
    //再生
    @IBAction func goPlay(sender: AnyObject) {
        AudioServicesCreateSystemSoundID(songData!, &soundIdRing)
        AudioServicesPlaySystemSound(soundIdRing)
    }
    //一時停止
    @IBAction func goPause(sender: AnyObject) {

    }
    
    //巻き戻し
    @IBAction func goBack(sender: AnyObject) {
    
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
