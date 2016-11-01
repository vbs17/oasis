//
//  SyuruViewController.swift
//  Kiki
//
//  Created by kei ikeuchi on 2016/10/21.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class SyuruViewController: UIViewController {
    @IBOutlet weak var rec: UIButton!
    @IBOutlet weak var syu: UIButton!
    @IBAction func rec(sender: AnyObject) {
        let recviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Top") as! ViewController
        self.presentViewController(recviewcontroller, animated: true, completion: nil)
    }
    

    @IBAction func basyo(sender: AnyObject) {
      
        let basyoviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Basyo") as! BasyoViewController
        self.presentViewController(basyoviewcontroller, animated: true, completion: nil)
    }
    
    @IBAction func back(sender: AnyObject) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rec.layer.cornerRadius = 8
        rec.clipsToBounds = true
        syu.layer.cornerRadius = 8
        syu.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
