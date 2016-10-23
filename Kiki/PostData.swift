

import UIKit
import Firebase
import FirebaseDatabase



class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var song: String?
    var byou: String?
    var realsong: String?
    var star: [[String]] = [[]]
    
   
    //写真　曲名　秒数　音源
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        id = snapshot.key
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        if let stars = valueDictionary["star"] as? [[String]] {
            self.star = stars
        }
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        byou = valueDictionary["byou"] as? String
        name = valueDictionary["songname"] as? String
        song = valueDictionary["ongen"] as? String
        realsong = valueDictionary["realsong"] as? String
    
  }
}
