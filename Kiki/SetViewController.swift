

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth
import SVProgressHUD

class SetViewController: UIViewController {
    
    
    @IBOutlet weak var disname: UITextField!
    
    @IBAction func change(sender: AnyObject) {
        if let name = disname.text {
                if name.characters.isEmpty {
                SVProgressHUD.showErrorWithStatus("表示名を入力して下さい")
                return
            }
                if let request = FIRAuth.auth()?.currentUser?.profileChangeRequest() {
                request.displayName = name
                request.commitChangesWithCompletion() { error in
                    if error != nil {
                        print(error)
                    } else {
                        let ud = NSUserDefaults.standardUserDefaults()
                        ud.setValue(name, forKey: CommonConst.DisplayNameKey)
                        ud.synchronize()
                        SVProgressHUD.showSuccessWithStatus("表示名を変更しました")
                        self.view.endEditing(true)
                    }
                }
            }
        }
    }
    
    @IBAction func out(sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
        self.presentViewController(loginViewController!, animated: true, completion: nil)
        let tabBarController = parentViewController as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: false)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let ud = NSUserDefaults.standardUserDefaults()
        let name = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        disname.text = name

    }

    

   }
