
import UIKit

class ProViewController: UIViewController {
    
    var image:UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var line: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var face: UITextField!
    @IBOutlet weak var den: UITextField!
    @IBOutlet weak var ta: UITextField!
    
    @IBAction func proI(sender: AnyObject) {
        let proiviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("ProI") as! ProIViewController
        self.presentViewController(proiviewcontroller, animated: true, completion: nil)
    }

    @IBAction func post(sender: AnyObject) {
        if( name.text != nil && imageView.image != nil ) {
            // 保存処理
        } else {
            // アラートを出す
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
        let tabviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
        self.presentViewController(tabviewcontroller, animated: true, completion: nil)
    }

   
}
