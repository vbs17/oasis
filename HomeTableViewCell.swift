

import UIKit
import AVFoundation

class HomeTableViewCell: UITableViewCell {
    var tap:NSData?
    var playSong:AVAudioPlayer!

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBAction func play(sender: AnyObject) {
        playSong = try! AVAudioPlayer(data:tap!)
        playSong?.prepareToPlay()
        playSong?.play()

    }
    
    func setPostData(postData: PostData) {
        ImageView.image = postData.image
        label.text = postData.name
        label2.text = postData.byou
        tap = postData.realsong!.dataUsingEncoding(NSUTF8StringEncoding)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
