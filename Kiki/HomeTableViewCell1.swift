
import UIKit
import AVFoundation
import Firebase
import FirebaseAuth
import FirebaseDatabase


class HomeTableViewCell1: UITableViewCell {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var pathGo: UIButton!
    
    func setPostData(postData: PostData1, myid: String) {
        ImageView.image = postData.image
        label1.text = postData.hiniti
        label2.text = postData.zikoku
        label3.text = postData.station
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

