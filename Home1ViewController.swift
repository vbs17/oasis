import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import AVFoundation

class HomeViewController1: UIViewController,UITableViewDataSource, UITableViewDelegate,AVAudioPlayerDelegate{
    var postArray: [PostData1] = []
    var observing = false
    var genre: String!
    var back: UIButton!
    var tableView: UITableView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "HomeTableViewCell1", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell22")
        
    }
    
    
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

    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell22", forIndexPath: indexPath) as! HomeTableViewCell1
               let uid = FIRAuth.auth()?.currentUser?.uid
        cell.setPostData(postArray[indexPath.row], myid: uid!)
        cell.pathGo.addTarget(self, action:#selector(schemebtn(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
       
        return cell
    }
    
    
    func handleButton1(sender: UIButton, event:UIEvent){
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]
        //pathGoボタン押した時次の画面に住所だけ渡す
        let tapli = self.storyboard?.instantiateViewControllerWithIdentifier("Tapli") as! TapliViewController
        tapli.path1 = postData.path
        self.presentViewController(tapli, animated: true, completion: nil)

    }
    
    func getIndexPath(event:UIEvent) -> NSIndexPath? {
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        return indexPath
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

