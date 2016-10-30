

import UIKit
import Firebase
import FirebaseDatabase

class PostData2: NSObject{
    var id: String?
    var image: UIImage?
    var imageString: String?
    var hiniti: String?
    var zikoku: String?
    var station: String?
    var path: String?
    
    
    init(snapshot: FIRDataSnapshot, miId: String){
        id = snapshot.key
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        hiniti = valueDictionary["hiniti"] as? String
        zikoku = valueDictionary["zikoku"] as? String
        station = valueDictionary["station"] as? String
        path = valueDictionary["path"] as? String
        
        
    }
}
