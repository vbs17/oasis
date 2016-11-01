


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ProViewController: UIViewController {
    
    var image:UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var line: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var face: UITextField!
    @IBOutlet weak var den: UITextField!
    @IBOutlet weak var ta: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func proI(sender: AnyObject) {
        let proiviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("ProI") as! ProIViewController
        self.presentViewController(proiviewcontroller, animated: true, completion: nil)
    }

    @IBAction func post(sender: AnyObject) {
            if( name.text != nil && imageView.image != nil ) {
            let postRef = FIRDatabase.database().reference().child(CommonConst.Profile)
            let imageData = UIImageJPEGRepresentation(image!, 0.5)
            let postData = ["image": imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength),"name": name,"line":line,"twitter":twitter,"facebook":face,"den":den,"ta":ta]
           
                let tabvarviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
            self.presentViewController(tabvarviewcontroller, animated: true, completion: nil)
    } else {
            // アラートを出す
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
        let tabviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
        self.presentViewController(tabviewcontroller, animated: true, completion: nil)
    }

   
}
