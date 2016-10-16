

import UIKit

class KindTableViewCell: UITableViewCell {

    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var button: UIButton!
    var buttonImage:UIImage = UIImage(named: "104937")!
    
    
    
    func btn_click(sender: UIButton){
        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(KindTableViewCell.btn_click(_:)), forControlEvents:.TouchUpInside)
        print("button is clcked!")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

           }
    
    }

