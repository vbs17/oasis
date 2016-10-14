

import UIKit

class SendViewController: UIViewController {
    
    var songData:NSURL!
    
    @IBOutlet weak var library: UIButton!
    @IBOutlet weak var camera: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        library.layer.cornerRadius = 10
        library.clipsToBounds = true
        camera.layer.cornerRadius = 10
        camera.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
