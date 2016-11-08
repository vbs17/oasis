

import UIKit
import FirebaseAuth


class BasyoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var back: UIButton!
  
    @IBAction func camera(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(pickerController, animated: true, completion: nil)
      }
    }
    
    @IBAction func library(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(pickerController, animated: true, completion: nil)

      }
    }
    @IBAction func back(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        back.layer.cornerRadius = 37
        back.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            if info[UIImagePickerControllerOriginalImage] != nil {
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                
              
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let syugoviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Syugo") as! SyugoViewController
                    syugoviewcontroller.image = image
                    self.presentViewController(syugoviewcontroller, animated: true, completion:  nil)
                }
            }
             picker.dismissViewControllerAnimated(true, completion: nil)
        }

    

 
   }
 


