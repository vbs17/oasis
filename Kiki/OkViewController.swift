

import UIKit

class OkViewController: UIViewController {

    var image: UIImage!
    var songData:NSURL!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func OKGo(sender: AnyObject) {
        
    }

  
}
