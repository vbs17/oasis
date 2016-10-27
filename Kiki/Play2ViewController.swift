
import UIKit
import AVFoundation
import MediaPlayer


class Play2ViewController: UIViewController {
    var songData:NSURL!
    var songData2:NSURL!

    var playSong:AVAudioPlayer!
    let recordSetting : [String : AnyObject] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVNumberOfChannelsKey: 1 ,
        AVSampleRateKey: 44100
    ]


    @IBOutlet weak var play: UIButton!
    
    @IBAction func playGo(sender: AnyObject) {
        playSong.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let sound:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData!)
        let sound2:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData2!)
        playSong = sound
        sound.prepareToPlay()
        playSong = sound2
        sound2.prepareToPlay()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
