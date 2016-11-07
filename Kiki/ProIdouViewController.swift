
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProIdouViewController: UIViewController {
    
    var uid:String!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var face: UILabel!
    @IBOutlet weak var insta: UILabel!
    @IBOutlet weak var p: UILabel!

    @IBOutlet weak var twitter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        FIRDatabase.database().reference().child(CommonConst.Profile).observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let postData = PostData2(snapshot: snapshot, myId: snapshot.key)
            
            if ( postData.uid == self.uid ) {
                
                self.imageView.image = postData.image
                self.name.text = postData.name
                self.line.text = postData.line
                self.twitter.text = postData.twitter
                self.face.text = postData.facebook
                self.insta.text = postData.den
                self.p.text = postData.ta
            }
            else {
            }
        })
        
        FIRDatabase.database().reference().child(CommonConst.Profile).observeEventType(.ChildChanged, withBlock: { snapshot in
            if ( snapshot.key == self.uid ) {
                let postData = PostData2(snapshot: snapshot, myId: snapshot.key)
                self.imageView.image = postData.image
                self.name.text = postData.name
                self.line.text = postData.line
                self.twitter.text = postData.twitter
                self.face.text = postData.facebook
                self.insta.text = postData.den
                self.p.text = postData.ta
            }
            else {
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
}
