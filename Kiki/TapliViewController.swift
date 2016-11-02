

import UIKit

class TapliViewController: UIViewController {
    
   

    @IBOutlet weak var path: UITextView!
     var path1:String!
    @IBAction func map(sender: AnyObject) {
        schemebtn()
            }
    
    func schemebtn() {
        let adress =  path.text
        let encodedString = adress.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url = NSURL(string: "http://maps.apple.com/?q=\(encodedString)")!
        if (UIApplication.sharedApplication().canOpenURL(url)) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        path.text = path1
        path.layer.cornerRadius = 15
        path.clipsToBounds = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
   
}

