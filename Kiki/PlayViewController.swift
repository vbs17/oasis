

import UIKit

class PlayViewController: UIViewController {
    
    var songData:NSURL!
    var timeCount = 1
    var timeCountTimer: NSTimer!
    
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var byou: UILabel!
    @IBOutlet weak var onbyou: UILabel!
    
    
    
    @IBAction func goPlay(sender: AnyObject) {
        self.timeCountTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.recordLimits), userInfo: nil, repeats: true)
        songData.
    }
    
    @IBAction func goPause(sender: AnyObject) {
    }
    
    @IBAction func goBack(sender: AnyObject) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func recordLimits(){
        let minuteCount = timeCount / 60
        let secondCount = timeCount % 60
        if secondCount <= 9 {
            byou.text = String(format: "%d:0%d", minuteCount, secondCount)
        }else if secondCount >= 10 {
            byou.text = String(format: "%d:%d", minuteCount, secondCount)
        }
  }

}
