

import UIKit

class SendViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //filenameをsongDataに渡す
    var songData:NSURL!
    
    @IBOutlet weak var library: UIButton!
    @IBOutlet weak var camera: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        library.layer.cornerRadius = 10
        library.clipsToBounds = true
        camera.layer.cornerRadius = 10
        camera.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func camGo(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(pickerController, animated: true, completion: nil)
        }

    }
    
    @IBAction func libGo(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(pickerController, animated: true, completion: nil)
         }
    }
    
    
       
  
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if info[UIImagePickerControllerOriginalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // ここでpresentViewControllerを呼び出しても表示されないためメソッドが終了してから呼ばれるようにする
            dispatch_async(dispatch_get_main_queue()) {
                
                // AdobeImageEditorを起動する
                let okviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Ok") as! OkViewController
                okviewcontroller.image = image
                okviewcontroller.songData = self.songData
                self.presentViewController(okviewcontroller, animated: true, completion:  nil)
            }
        }
        
        // 閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

  }

