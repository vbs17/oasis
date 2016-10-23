

import UIKit
import AVFoundation
import Firebase
import FirebaseAuth
import FirebaseDatabase


class HomeTableViewCell: UITableViewCell {
    
    var tap:NSData?
    weak var playSong: AVAudioPlayer!

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var onlabel2: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nami: UIProgressView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var hyouka: UIButton!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    
    func setPostData(postData: PostData, myid: String) {
        if let uid = FIRAuth.auth()?.currentUser?.uid{
        for var i in (0 ..< postData.star.count) {
                if postData.star[i][0] == uid{
                    switch postData.star[i][1] {
                    case "1":
                        star1.imageView?.image = UIImage(named:"IMG_2727_2")
                        
                    case "2":
                        star1.imageView?.image = UIImage(named:"IMG_2727_2")
                        star2.imageView?.image = UIImage(named:"IMG_2727_2")
                    case "3":
                        star1.imageView?.image = UIImage(named:"IMG_2727_2")
                        star2.imageView?.image = UIImage(named:"IMG_2727_2")
                        star3.imageView?.image = UIImage(named:"IMG_2727_2")
                    case "4":
                        star1.imageView?.image = UIImage(named:"IMG_2727_2")
                        star2.imageView?.image = UIImage(named:"IMG_2727_2")
                        star3.imageView?.image = UIImage(named:"IMG_2727_2")
                        star4.imageView?.image = UIImage(named:"IMG_2727_2")
                    case "5":
                        star1.imageView?.image = UIImage(named:"IMG_2727_2")
                        star2.imageView?.image = UIImage(named:"IMG_2727_2")
                        star3.imageView?.image = UIImage(named:"IMG_2727_2")
                        star4.imageView?.image = UIImage(named:"IMG_2727_2")
                        star5.imageView?.image = UIImage(named:"IMG_2727_2")
                        default: break
                    }
                  
            }
            
            }
        }

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

    
       
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

