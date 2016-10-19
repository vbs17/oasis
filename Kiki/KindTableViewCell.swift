

import UIKit

protocol KindTableViewCellDelegate {
     func buttonPressed(tableViewCell: KindTableViewCell)
}

class KindTableViewCell: UITableViewCell {
    var delegate: KindTableViewCellDelegate! = nil

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func genreButton(sender: AnyObject) {
         delegate.buttonPressed(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    }

