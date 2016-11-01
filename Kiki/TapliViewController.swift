

import UIKit

class TapliViewController: UIViewController {
    
    var path1:String!

    @IBOutlet weak var path: UITextView!
    
    
    
    
    
    @IBAction func map(sender: AnyObject) {
        func schemebtn(sender: AnyObject) {
            let url = NSURL(string: "http://maps.apple.com://")!
            if (UIApplication.sharedApplication().canOpenURL(url)) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    
    
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        path.text = path1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func schemebtn(sender: AnyObject) {
        let url = NSURL(string: "http://maps.apple.com://")!
        if (UIApplication.sharedApplication().canOpenURL(url)) {
            UIApplication.sharedApplication().openURL(url)
        }
    }

   
}
