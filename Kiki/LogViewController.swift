

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LogViewController: UIViewController {

    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func back(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func loButton(sender: AnyObject) {
        if let address = mail.text, let password = pass.text {
            
            if address.characters.isEmpty || password.characters.isEmpty {
                SVProgressHUD.showErrorWithStatus("必要項目を入力して下さい")
                return
            }
            
            SVProgressHUD.show()
            
            FIRAuth.auth()?.signInWithEmail(address, password: password) { user, error in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("エラー")
                    
                    print(error)
                } else {
                    if let displayName = user?.displayName {
                        self.setDisplayName(displayName)
                    }
                    
                    SVProgressHUD.dismiss()
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
    
    func setDisplayName(name: String) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setValue(name, forKey: CommonConst.DisplayNameKey)
        ud.synchronize()
    }


}
