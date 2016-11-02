

import UIKit

class SyugoViewController: UIViewController {
    
    var image:UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hiniti: UITextField!
    @IBOutlet weak var zikoku: UITextField!
    @IBOutlet weak var station: UITextField!
    @IBOutlet weak var path: UITextView!
    
    @IBOutlet weak var ok: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        ok.layer.cornerRadius = 30
        ok.clipsToBounds = true

    }
    @IBAction func Ok(sender: AnyObject) {
        let kind2viewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Kind2") as! Kind2ViewController
        kind2viewcontroller.hiniti = hiniti
        kind2viewcontroller.image = imageView.image!
        kind2viewcontroller.zikoku = zikoku
        kind2viewcontroller.station = station
        kind2viewcontroller.path = path
        self.presentViewController(kind2viewcontroller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

}
