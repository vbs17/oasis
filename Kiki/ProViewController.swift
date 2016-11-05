


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
    @IBOutlet weak var back: UIButton!
    
    
    @IBAction func post(sender: AnyObject) {
        if (self.imageView.image != nil && name.text!.characters.count > 0){
            let postRef = FIRDatabase.database().reference().child(CommonConst.Profile)
            let imageData = UIImageJPEGRepresentation(image ?? imageView.image!, 0.5)
            let name1:NSString = name.text ?? name.text!
            let line1:NSString = line.text ?? line.text!
            let twitter1:NSString = twitter.text ?? twitter.text!
            let facebook1: NSString = face.text ?? face.text!
            let den1: NSString = den.text ?? den.text!
            let ta1: NSString = ta.text ?? ta.text!
            let uid:NSString = (FIRAuth.auth()?.currentUser?.uid)!
           let postData = ["name": name1, "image": imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), "line": line1, "facebook": facebook1, "twitter":twitter1,"den":den1,"ta":ta1,"uid":uid]
            postRef.child(uid as String).setValue(postData)
            let tabvarviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
            self.presentViewController(tabvarviewcontroller, animated: true, completion: nil)
        } else{
        if (image != nil && name.text!.characters.count > 0){
        let postRef = FIRDatabase.database().reference().child(CommonConst.Profile)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        let name1:NSString = name.text!
        let line1:NSString = line.text!
        let twitter1:NSString = twitter.text!
        let facebook1: NSString = face.text!
        let den1: NSString = den.text!
        let ta1: NSString = ta.text!
        let uid:NSString = (FIRAuth.auth()?.currentUser?.uid)!
        let postData = ["name": name1, "image": imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), "line": line1, "facebook": facebook1, "twitter":twitter1,"den":den1,"ta":ta1,"uid":uid]
         postRef.child(uid as String).setValue(postData)
        let tabvarviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
        self.presentViewController(tabvarviewcontroller, animated: true, completion: nil)
        }else{
            let alert: UIAlertController = UIAlertController(title: "MUST", message: "画像とNAMEは必須項目です", preferredStyle:  UIAlertControllerStyle.Alert)
            
           
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
           
            
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
        
}

    override func viewDidLoad() {
        super.viewDidLoad()
        back.layer.cornerRadius = 37
        back.clipsToBounds = true
        self.imageView.image = image
        FIRDatabase.database().reference().child(CommonConst.Profile).observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let postData = PostData2(snapshot: snapshot, myId: snapshot.key)
            
            if ( postData.uid == FIRAuth.auth()?.currentUser?.uid ) {
                
                if self.image == nil {
                    self.imageView.image = postData.image
                }
                self.name.text = postData.name
                self.line.text = postData.line
                self.twitter.text = postData.twitter
                self.face.text = postData.facebook
                self.den.text = postData.den
                self.ta.text = postData.ta
            }
            else {
            }
        })
        
        FIRDatabase.database().reference().child(CommonConst.Profile).observeEventType(.ChildChanged, withBlock: { snapshot in
            if ( snapshot.key == FIRAuth.auth()?.currentUser?.uid ) {
                let postData = PostData2(snapshot: snapshot, myId: snapshot.key)
                if self.image == nil {
                    self.imageView.image = postData.image
                }
                self.name.text = postData.name
                self.line.text = postData.line
                self.twitter.text = postData.twitter
                self.face.text = postData.facebook
                self.den.text = postData.den
                self.ta.text = postData.ta
            }
            else {
            }
        })
    }
    
    @IBAction func proI(sender: AnyObject) {
        let proiviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("ProI") as! ProIViewController
        self.presentViewController(proiviewcontroller, animated: true, completion: nil)
    }

    
    @IBAction func logout(sender: AnyObject) {
        let HomeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Set")
        self.presentViewController(HomeViewController!, animated: true, completion: nil)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
        let tabviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
        self.presentViewController(tabviewcontroller, animated: true, completion: nil)
    }
}

   

