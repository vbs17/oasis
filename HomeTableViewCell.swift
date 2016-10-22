

import UIKit
import AVFoundation

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var onlabel2: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nami: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var hyouka: UIButton!
    
    var tap:NSData?
    weak var playSong: AVAudioPlayer!
    
    func setPostData(postData: PostData) {
        ImageView.image = postData.image
        label.text = postData.name
        label2.text = postData.byou
        tap = NSData(base64EncodedString: postData.realsong!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
    }
    //見た目しかやってない
    override func awakeFromNib() {
        super.awakeFromNib()
        nami.transform = CGAffineTransformMakeScale(1.0, 30.0)
        nami.progressImage = UIImage(named: "Kiki45" )
        nami.trackImage = UIImage(named: "Kiki41")
        nami.progress = 0
        onlabel2.text = "0:00"
        backButton.layer.cornerRadius = 5
        backButton.clipsToBounds = true
        hyouka.layer.cornerRadius = 20
        hyouka.clipsToBounds = true
        backButton.enabled = false
        
    }
    
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
            if playSong != nil {
                let time = playSong.duration
                let p:Double = x / Double(nami.frame.size.width)
                playSong.currentTime = Double(time * p)
            }
        }
    }

    //誰が評価したか　その評価の平均値を表示させる
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

