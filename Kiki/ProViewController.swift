


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
        print("kiki current_user_uid \(FIRAuth.auth()?.currentUser?.uid)")
        FIRDatabase.database().reference().child(CommonConst.Profile).observeEventType(.ChildAdded, withBlock: { snapshot in
            print("kiki child_count\(snapshot.childrenCount)")
            if ( snapshot.key == FIRAuth.auth()?.currentUser?.uid ) {
                let postData = PostData2(snapshot: snapshot, myId: snapshot.key)
                print("kiki postData \(postData.name)")
                self.imageView.image = postData.image
                self.name.text = postData.name
                self.line.text = postData.line
                self.twitter.text = postData.twitter
                self.face.text = postData.facebook
                self.den.text = postData.den
                self.ta.text = postData.ta
            }
            else {
                print("kiki snapshot not loaded")
            }
        })
        
        FIRDatabase.database().reference().child(CommonConst.Profile).observeEventType(.ChildChanged, withBlock: { snapshot in
            print("kiki child_count\(snapshot.childrenCount)")
            if ( snapshot.key == FIRAuth.auth()?.currentUser?.uid ) {
                let postData = PostData2(snapshot: snapshot, myId: snapshot.key)
                print("kiki postData \(postData.name)")
                self.imageView.image = postData.image
                self.name.text = postData.name
                self.line.text = postData.line
                self.twitter.text = postData.twitter
                self.face.text = postData.facebook
                self.den.text = postData.den
                self.ta.text = postData.ta
            }
            else {
                print("kiki snapshot not loaded")
            }
        })
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

   

