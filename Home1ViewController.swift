import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import AVFoundation

class HomeViewController1: UIViewController,UITableViewDataSource, UITableViewDelegate,AVAudioPlayerDelegate{
    var postArray: [PostData1] = []
    var postArray2:[PostData2] = []
    var observing = false
    var genre: String!
    var tableView: UITableView!

    @IBOutlet weak var back: UIButton!
    
    func schemebtn(sender: UIButton, event:UIEvent) {
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]
        let adress =  postData.path
        let encodedString = adress!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url = NSURL(string: "http://maps.apple.com/?q=\(encodedString)")!
        if (UIApplication.sharedApplication().canOpenURL(url)) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    func pro(sender: UIButton, event:UIEvent) {
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]
        let pro = self.storyboard?.instantiateViewControllerWithIdentifier("Pi") as! ProIdouViewController
        pro.uid = postData.uid
        self.presentViewController(pro, animated: true, completion: nil)
        
    }

    
    
    
    //ここかなsetPostData
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell22", forIndexPath: indexPath) as! HomeTableViewCell1
        let uid = FIRAuth.auth()?.currentUser?.uid
        cell.setPostData(postArray[indexPath.row], myid: uid!)
        let postData1 = postArray[indexPath.row]
        var image:UIImage? = nil
        for id in postArray2{
            if postData1.uid == id.uid{
                image = id.image
            }
        }
        cell.imageView1.image = image
        cell.pathGo.addTarget(self, action:#selector(schemebtn(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.pro.addTarget(self, action:#selector(pro(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "HomeTableViewCell1", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell22")
        back.layer.cornerRadius = 37
        back.clipsToBounds = true
        
    }
    


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if FIRAuth.auth()?.currentUser != nil {
            if observing == false {
                FIRDatabase.database().reference().child(CommonConst.PostPATH2).child(genre).observeEventType(.ChildAdded, withBlock: { snapshot in
                    
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        let postData = PostData1(snapshot: snapshot, myId: uid)
                        self.postArray.insert(postData, atIndex: 0)
                        self.tableView.reloadData()
                    }
                })
                //ここもfunc hoshiと一緒
                FIRDatabase.database().reference().child(CommonConst.PostPATH2).child(genre).observeEventType(.ChildChanged, withBlock: { snapshot in
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        let postData = PostData1(snapshot: snapshot, myId: uid)
                        
                        var index: Int = 0
                        for post in self.postArray {
                            if post.id == postData.id {
                                index = self.postArray.indexOf(post)!
                                break
                            }
                        }
                        self.postArray.removeAtIndex(index)
                        self.postArray.insert(postData, atIndex: index)
                        self.tableView.reloadData()
                    }
                })
                
                FIRDatabase.database().reference().child(CommonConst.Profile).observeEventType(.ChildAdded, withBlock: { snapshot in
                    
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        let postData = PostData2(snapshot: snapshot, myId: uid)
                        self.postArray2.insert(postData, atIndex: 0)
                        self.tableView.reloadData()
                    }
                })
                
                FIRDatabase.database().reference().child(CommonConst.Profile).observeEventType(.ChildChanged, withBlock: { snapshot in
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        let postData = PostData2(snapshot: snapshot, myId: uid)
                        
                        var index: Int = 0
                        for post in self.postArray2 {
                            if post.id == postData.id {
                                index = self.postArray2.indexOf(post)!
                                break
                            }
                        }
                        self.postArray2.removeAtIndex(index)
                        self.postArray2.insert(postData, atIndex: index)
                        self.tableView.reloadData()
                    }
                })

                observing = true
            }
        } else {
            if observing == true {
                postArray = []
                tableView.reloadData()
                FIRDatabase.database().reference().removeAllObservers()
                observing = false
            }
        }
    }
    

    
    
    
    
    
    
    func getIndexPath(event:UIEvent) -> NSIndexPath? {
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        return indexPath
    }
    
    
    //無視
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // セルをタップされたら何もせずに選択状態を解除する
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func backGo(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

