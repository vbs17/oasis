

import UIKit

class LogAcaViewController: UIViewController {
    @IBAction func log(sender: AnyObject) {
        let proiviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Log") as! LogViewController
        self.presentViewController(proiviewcontroller, animated: true, completion: nil)
        
    }
    @IBAction func aca(sender: AnyObject) {
        let proiviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
        self.presentViewController(proiviewcontroller, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   
}
