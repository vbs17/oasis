

import UIKit
import Firebase
import FirebaseAuth


class TabViewController: UIViewController {
    
    @IBAction func home(sender: AnyObject) {
        let HomeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Itiran")
        self.presentViewController(HomeViewController!, animated: true, completion: nil)
        }
    
    @IBAction func post(sender: AnyObject) {
        let TopViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Top") 
        self.presentViewController(TopViewController!, animated: true, completion: nil)
        
    }
    
    @IBAction func set(sender: AnyObject) {
        let setViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Set") as! SetViewController
        self.presentViewController(setViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if FIRAuth.auth()?.currentUser == nil {
            dispatch_async(dispatch_get_main_queue()) {
                let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(loginViewController!, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
   }