

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
            if (postData.star.count != 0){
                for var i in (0 ..< postData.star.count) {
                    let starDic = Array(postData.star[i].keys)
                    if starDic[0] == uid{
                        let starData = postData.star[i][uid]
                        switch  String(starData){
                        case "1":
                            star1.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                          
                        case "2":
                            star1.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star2.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                           
                        case "3":
                            star1.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star2.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star3.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                         
                        case "4":
                            star1.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star2.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star3.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star4.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                        case "5":
                            star1.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star2.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star3.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star4.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                            star5.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
                        default: break
                        }
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

