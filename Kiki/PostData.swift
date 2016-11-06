

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
    var star: Array<[String:String]> = []
    var uid: String?
   
   
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        id = snapshot.key
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        byou = valueDictionary["byou"] as? String
        name = valueDictionary["songname"] as? String
        song = valueDictionary["ongen"] as? String
        realsong = valueDictionary["realsong"] as? String//[uid:星の数]
        if let stars = valueDictionary["star"] as? Array<[String:String]> {
            self.star = stars
        }
        uid = valueDictionary["uid"] as? String


    
  }
}