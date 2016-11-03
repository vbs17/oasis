

import UIKit
import AVFoundation

class OkViewController: UIViewController {

    var image: UIImage!
    //filenameをsongDataに渡す
    var songData:NSURL!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var byou: UILabel!
    @IBOutlet weak var back: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sound:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData!)
        byou.text = formatTimeString(sound.duration)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        back.layer.cornerRadius = 25
        back.clipsToBounds = true
        imageView.image = image
        
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func OKGo(sender: AnyObject) {
        let kindviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Kind") as! KindViewController
        kindviewcontroller.songData = songData
        kindviewcontroller.image = imageView.image
        kindviewcontroller.byou = byou
        kindviewcontroller.songname = text
        self.presentViewController(kindviewcontroller, animated: true, completion: nil)
    }
    
    @IBAction func backGo(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func formatTimeString(d: Double) -> String {
        let s: Int = Int(d % 60)
        let m: Int = Int((d - Double(s)) / 60 % 60)
        let str = String(format: "%2d:%02d",  m, s)
        return str
    }


  
}
