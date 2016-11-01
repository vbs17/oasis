
import UIKit

class ProViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var line: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var face: UITextField!
    @IBOutlet weak var den: UITextField!
    @IBOutlet weak var ta: UITextField!
    
    @IBAction func proI(sender: AnyObject) {
    }

    @IBAction func post(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }

   
}
