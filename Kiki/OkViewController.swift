

import UIKit
import AVFoundation

class OkViewController: UIViewController {

    var image: UIImage!
    var songData:NSURL!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var byou: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sound:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData!)
        byou.text = formatTimeString(sound.duration)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.image = image
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func OKGo(sender: AnyObject) {
        
    }
    
    func formatTimeString(d: Double) -> String {
        let s: Int = Int(d % 60)
        let m: Int = Int((d - Double(s)) / 60 % 60)
        let str = String(format: "%2d:%02d",  m, s)
        return str
    }


  
}
