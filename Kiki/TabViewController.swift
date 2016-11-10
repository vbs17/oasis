

import UIKit
import Firebase
import FirebaseAuth


class TabViewController: UIViewController {
    
    @IBOutlet weak var music1: UIButton!
    @IBOutlet weak var recpic1: UIButton!
    @IBOutlet weak var set1: UIButton!
    @IBOutlet weak var pro: UIButton!
    
    
    @IBAction func pro(sender: AnyObject) {
        let ProViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Pro")
        self.presentViewController(ProViewController!, animated: true, completion: nil)
    }
    
    @IBAction func path(sender: AnyObject) {
        let HomeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Itiran1")
        self.presentViewController(HomeViewController!, animated: true, completion: nil)
    }
    
    
    @IBAction func recpic(sender: AnyObject) {
        let TopViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Syuru")
        self.presentViewController(TopViewController!, animated: true, completion: nil)
    }
    
    @IBAction func music(sender: AnyObject) {
        let setViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Itiran")
        self.presentViewController(setViewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        music1.layer.cornerRadius = 2
        music1.clipsToBounds = true
        recpic1.layer.cornerRadius = 2
        recpic1.clipsToBounds = true
        set1.layer.cornerRadius = 2
        set1.clipsToBounds = true
        pro.layer.cornerRadius = 35
        pro.clipsToBounds = true
       
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