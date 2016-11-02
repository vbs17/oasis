


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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRDatabase.database().reference().child(CommonConst.Profile).child("uid").queryEqualToValue(FIRAuth.auth()?.currentUser?.uid).observeEventType(.ChildAdded, withBlock: { snapshot in
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                let postData = PostData2(snapshot: snapshot, myId: uid)
                self.imageView.image = postData.image
                self.name.text = postData.name
                self.line.text = postData.line
                self.twitter.text = postData.twitter
                self.face.text = postData.facebook
                self.den.text = postData.den
                self.ta.text = postData.ta
            }
        })
        }
    
    func updateViewInfomation() {
        FIRDatabase.database().reference().child(CommonConst.Profile).child("uid").queryEqualToValue(FIRAuth.auth()?.currentUser?.uid).observeEventType(.ChildChanged, withBlock: { snapshot in
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                let postData = PostData2(snapshot: snapshot, myId: uid)
                self.imageView.image = postData.image
                self.name.text = postData.name
                self.line.text = postData.line
                self.twitter.text = postData.twitter
                self.face.text = postData.facebook
                self.den.text = postData.den
                self.ta.text = postData.ta
            }
        })
    }
    
    @IBAction func post(sender: AnyObject) {
            if( name.text != nil && imageView.image != nil ) {
            let postRef = FIRDatabase.database().reference().child(CommonConst.Profile)
            let ta1:NSString = ta.text!
            let name1:NSString = name.text!
            let den1:NSString = den.text!
            let line1:NSString = line.text!
            let twitter1:NSString = twitter.text!
            let face1:NSString = face.text!
            let uid:NSString = (FIRAuth.auth()?.currentUser?.uid)!
            let imageData = UIImageJPEGRepresentation(image!, 0.5)
            let postData = ["image": imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength),"name": name1,"line":line1,"twitter":twitter1,"facebook":face1,"den":den1,"ta":ta1,"uid":uid]
              postRef.child(uid as String).setValue(postData)
                updateViewInfomation()
            
                let tabvarviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
            self.presentViewController(tabvarviewcontroller, animated: true, completion: nil)
    } else {
            // アラートを出す
        }
    }
    
    @IBAction func proI(sender: AnyObject) {
        let proiviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("ProI") as! ProIViewController
        self.presentViewController(proiviewcontroller, animated: true, completion: nil)
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.imageView.image = image
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
        let tabviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
        self.presentViewController(tabviewcontroller, animated: true, completion: nil)
    }
}

   

