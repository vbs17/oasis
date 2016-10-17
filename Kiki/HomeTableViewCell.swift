

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var cellText: UITextField!
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBAction func saisei(sender: AnyObject) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setPostData(postData: PostData) {
        ImageView.image = postData.image
        cellText.text = "\(postData.name!)"
        cellLabel.text = "\(postData.byou)"
        
        
    
        
        
        }
    
}
