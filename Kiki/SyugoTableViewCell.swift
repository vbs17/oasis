
import UIKit

protocol SyugoTableViewCellDelegate {
    func buttonPressed(tableViewCell: SyugoTableViewCell)
}

class SyugoTableViewCell: UITableViewCell {
    
     var delegate: SyugoTableViewCellDelegate! = nil

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var kete: UIButton!
    
    @IBAction func kettei(sender: AnyObject) {
        delegate.buttonPressed(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
