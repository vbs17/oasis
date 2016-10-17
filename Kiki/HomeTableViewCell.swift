

import UIKit
import AVFoundation

class HomeTableViewCell: UITableViewCell {
    
    var tap:String?
    var playSong:AVAudioPlayer!
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var cellText: UITextField!
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBAction func saisei(sender: AnyObject) {
        // StringのPATHをURLに変換
        let url = NSURL(fileURLWithPath: tap!)
        playSong = try! AVAudioPlayer(contentsOfURL: url)
        playSong?.prepareToPlay()
        playSong?.play()
    }

    func setPostData(postData: PostData) {
        ImageView.image = postData.image
        cellText.text = postData.name
        cellLabel.text = postData.byou
        tap = postData.song
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
