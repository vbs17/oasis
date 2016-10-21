

import UIKit

class BasyoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

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
 


