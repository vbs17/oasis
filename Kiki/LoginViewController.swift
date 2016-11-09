
import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD
import FBSDKCoreKit
import FBSDKLoginKit


class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    @IBAction func handleLoginButton(sender: AnyObject) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text {
            
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
    
    @IBAction func handleCreateAcountButton(sender: AnyObject) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text,
            let displayName = displayNameTextField.text {
            if address.characters.isEmpty || password.characters.isEmpty
                || displayName.characters.isEmpty {
                SVProgressHUD.showErrorWithStatus("必要項目を入力して下さい")
                return
            }
            
            SVProgressHUD.show()
            
            FIRAuth.auth()?.createUserWithEmail(address, password: password) { user, error in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("エラー")
                    print(error)
                } else {
                    FIRAuth.auth()?.signInWithEmail(address, password: password) { user, error in
                        if error != nil {
                            SVProgressHUD.showErrorWithStatus("エラー")
                            print(error)
                        } else {
                            if let user = user {
                                let request = user.profileChangeRequest()
                                request.displayName = displayName
                                request.commitChangesWithCompletion() { error in
                                    if error != nil {
                                        print(error)
                                    } else {
                                        self.setDisplayName(displayName)
                                        
                                        SVProgressHUD.dismiss()
                                        
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setDisplayName(name: String) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setValue(name, forKey: CommonConst.DisplayNameKey)
        ud.synchronize()
    }
    
   
    
    
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            print("User Already Logged In")
            //後で既にログインしていた場合の処理（メイン画面へ遷移）を書く
        } else {
            print("User not Logged In")
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
    
    
    
    @IBAction func facebooklog(sender: AnyObject) {
        
        func loginButton(loginButton: FBSDKLoginButton!,didCompleteWithResult
            result: FBSDKLoginManagerLoginResult!, error: NSError!) {
            print("User Logged In")
            
            if ((error) != nil)
            {
                //エラー処理
            } else if result.isCancelled {
                //キャンセルされた時
            } else {
                //必要な情報が取れていることを確認(今回はemail必須)
                if result.grantedPermissions.contains("email")
                {
                    // 次の画面に遷移（後で）
                }
            }
        }

        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}