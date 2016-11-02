
import UIKit
import Firebase
import FirebaseDatabase

class PostData2: NSObject{
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var line: String?
    var twitter: String?
    var facebook: String?
    var den: String?
    var ta: String?
    var uid: String?
    
    
    init(snapshot: FIRDataSnapshot, myId: String){
        id = snapshot.key
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        name = valueDictionary["name"] as? String
        line = valueDictionary["line"] as? String
        twitter = valueDictionary["twitter"] as? String
        facebook = valueDictionary["facebook"] as? String
        den = valueDictionary["den"] as? String
        ta = valueDictionary["ta"] as? String
        uid = valueDictionary["uid"] as? String

    }
}
