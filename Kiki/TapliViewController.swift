

import UIKit
extension String {
    
    func escapeStr() -> String {
        var raw: NSString = self
        var str = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,raw,"[].",":/?&=;+!@#$()',*",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))
        return str as String
    }
}

class TapliViewController: UIViewController {
    
    var path1:String!
    var encoded =  ""

    @IBOutlet weak var path: UITextView!
    @IBAction func map(sender: AnyObject) {
        schemebtn()
            }
    
    func schemebtn() {
        let url = NSURL(string: "http://maps.apple.com/?q=\(encoded)")!
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
        var encoded = path1.escapeStr()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
   
}
