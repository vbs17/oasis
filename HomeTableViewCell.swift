

import UIKit
import AVFoundation

class HomeTableViewCell: UITableViewCell {
    var tap:NSData?
    var playSong:AVAudioPlayer!
    var timer: NSTimer!

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nami: UIProgressView!
    
    
    @IBAction func play(sender: AnyObject) {
        playSong = try! AVAudioPlayer(data:tap!)
        playSong?.prepareToPlay()
        playSong?.play()
         timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(HomeTableViewCell.namigo), userInfo: nil, repeats: true)
        }
    
    
//タッチ開始時
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ((event?.touchesForView(nami)) != nil) {
            print("touchesBegan ---- AudioView")
            let touch = touches.first
            let tapLocation = touch!.locationInView(self.view)
            print("touchesBegan ---- " + (tapLocation.x - nami.frame.origin.x).description)
        }
    }
    //タッチしたまま指を移動
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ((event?.touchesForView(nami)) != nil) {
            print("touchesMoved ---- AudioView")
            
            let touch = touches.first
            let tapLocation = touch!.locationInView(self.view)
            print("touchesMoved ---- " + (tapLocation.x - nami.frame.origin.x).description)
            
        }
    }
    
    //タッチした指が画面から離れる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ((event?.touchesForView(nami)) != nil) {
            print("touchesEnded ---- AudioView")
            
            let touch = touches.first
            let tapLocation = touch!.locationInView(self.view)
            
            let x:Double = Double(tapLocation.x - view.frame.origin.x)
            let time = playSong.duration
            let p:Double = x / Double(nami.frame.size.width)
            
            playSong.currentTime = Double(time * p)
            
        }
    }
    
    func namigo(){
         nami.progress = Float(playSong.currentTime / playSong.duration)
    }
    
    
    
    func setPostData(postData: PostData) {
        ImageView.image = postData.image
        label.text = postData.name
        label2.text = postData.byou
        tap = NSData(base64EncodedString: postData.realsong!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nami.transform = CGAffineTransformMakeScale(1.0, 30.0)
        nami.progressImage = UIImage(named: "Kiki45" )
        nami.trackImage = UIImage(named: "Kiki41")
        nami.progress = 0
       

    }
    
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBAction func star1Go(sender: AnyObject) {
    }
    
    @IBAction func star2Go(sender: AnyObject) {
    }
    
    @IBAction func star3Go(sender: AnyObject) {
    }
    
    @IBAction func star4Go(sender: AnyObject) {
    }
    
    @IBAction func star5Go(sender: AnyObject) {
    }



    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

