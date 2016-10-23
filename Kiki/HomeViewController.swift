

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import AVFoundation

class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,AVAudioPlayerDelegate{
    var postArray: [PostData] = []
    var observing = false
    var genre: String!
    var playSong:AVAudioPlayer!
    var timer = NSTimer()
    var back: UIButton!
    var tableView: UITableView!
    var playingIndexPath:NSIndexPath!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "CEll")
        back.layer.cornerRadius = 37
        back.clipsToBounds = true
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CEll", forIndexPath: indexPath) as! HomeTableViewCell
        if (playingIndexPath != nil) && (indexPath == playingIndexPath) {
            cell.backButton.enabled = true
        } else {
            cell.nami.progress = 0
            cell.onlabel2.text = "0:00"
            cell.backButton.enabled = false
        }
        let uid = FIRAuth.auth()?.currentUser?.uid
        cell.setPostData(postArray[indexPath.row], myid: uid!)
        cell.playButton.addTarget(self, action:#selector(handleButton(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.backButton.addTarget(self, action:#selector(back(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.star1.addTarget(self, action: #selector(hoshi(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.star2.addTarget(self, action: #selector(hoshi(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.star3.addTarget(self, action: #selector(hoshi(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.star4.addTarget(self, action: #selector(hoshi(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.star5.addTarget(self, action: #selector(hoshi(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.hyouka.addTarget(self, action: #selector(hyoukaGo), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    

    func hyoukaGo(sender:UIButton, event:UIEvent){
        let cell = tableView.cellForRowAtIndexPath(playingIndexPath) as! HomeTableViewCell?
        cell?.star1.imageView?.image = UIImage(named:"IMG_2728_2")
        cell?.star2.imageView?.image = UIImage(named:"IMG_2728_2")
        cell?.star3.imageView?.image = UIImage(named:"IMG_2728_2")
        cell?.star4.imageView?.image = UIImage(named:"IMG_2728_2")
        cell?.star5.imageView?.image = UIImage(named:"IMG_2728_2")
        
    }
    
    func hoshi(sender: UIButton, event:UIEvent){
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath!) as! HomeTableViewCell?
        //どのセルかわかった
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            var index = -1
            for var i in (0 ..< postData.star.count) {
                if postData.star[i].keys == uid{
                    index = i
                    break
                }
            }
            postData.star.removeAtIndex(index)
            postData.star.append([uid:String(sender.tag)])
        }
        
        switch sender.tag {
        case 1:
            cell?.star1.imageView?.image = UIImage(named:"IMG_2727_2")
            
        case 2:
            cell?.star1.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star2.imageView?.image = UIImage(named:"IMG_2727_2")
        case 3:
            cell?.star1.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star2.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star3.imageView?.image = UIImage(named:"IMG_2727_2")
        case 4:
            cell?.star1.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star2.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star3.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star4.imageView?.image = UIImage(named:"IMG_2727_2")
        case 5:
            cell?.star1.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star2.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star3.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star4.imageView?.image = UIImage(named:"IMG_2727_2")
            cell?.star5.imageView?.image = UIImage(named:"IMG_2727_2")
        default: break
        }
        let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH).child(genre)
        postRef.child(postData.id!).setValue(postData)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if FIRAuth.auth()?.currentUser != nil {
            if observing == false {
                FIRDatabase.database().reference().child(CommonConst.PostPATH).child(genre).observeEventType(.ChildAdded, withBlock: { snapshot in
                    
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        self.postArray.insert(postData, atIndex: 0)
                        self.tableView.reloadData()
                    }
                })
                
                FIRDatabase.database().reference().child(CommonConst.PostPATH).child(genre).observeEventType(.ChildChanged, withBlock: { snapshot in
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        
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

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    
    
    
    
    
    
    
    
    
    func handleButton(sender: UIButton, event:UIEvent){
        //indexPathは今選択中のセル
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath!) as! HomeTableViewCell?
        cell?.backButton.enabled = true
        if indexPath == playingIndexPath{
            if playSong.playing == true{
                playSong.pause()
                timer.invalidate()
            }else{
                timer.invalidate()
                playSong.play()
                timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(HomeViewController.updatePlayingTime), userInfo: nil, repeats: true)
            }
        } else { //他の曲を再生した時再生中の曲がこうなる
            if playingIndexPath != nil {
                let cell = tableView.cellForRowAtIndexPath(playingIndexPath) as! HomeTableViewCell?
                if cell != nil {
                    cell!.nami.progress = 0
                    cell!.onlabel2.text = "0:00"
                    cell?.backButton.enabled = false
                }}
            
            timer.invalidate()
            playingIndexPath = indexPath
            let tap = NSData(base64EncodedString: postData.realsong!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            playSong = try! AVAudioPlayer(data:tap!)
            playSong.delegate = self
            cell!.playSong = playSong
            playSong.prepareToPlay()
            playSong.play()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(HomeViewController.updatePlayingTime), userInfo: nil, repeats: true)
            
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //巻き戻し
    func back(sender: UIButton, event:UIEvent) {
        
        let cell = tableView.cellForRowAtIndexPath(playingIndexPath) as! HomeTableViewCell?
        cell!.onlabel2.text = "0:00"
        playSong.stop()
        timer.invalidate()
        playSong.prepareToPlay()
        playSong.currentTime = 0
        playSong.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(HomeViewController.updatePlayingTime), userInfo: nil, repeats: true)
        
    }
    //tesita
    func formatTimeString(d: Double) -> String {
        let s: Int = Int(d % 60)
        let m: Int = Int((d - Double(s)) / 60 % 60)
        let str = String(format: "%2d:%02d",  m, s)
        return str
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Auto Layoutを使ってセルの高さを動的に変更する
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // セルをタップされたら何もせずに選択状態を解除する
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    
    
    
    
    @IBAction func backGo(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //波と秒数
    func updatePlayingTime() {
        let cell = tableView.cellForRowAtIndexPath(playingIndexPath) as! HomeTableViewCell?
        if cell != nil {
            cell!.onlabel2.text = formatTimeString(playSong.currentTime)
            cell!.nami.progress = Float(playSong.currentTime / playSong.duration)
        }
    }
    
    //厄介者　再生が完了した時の作業
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        let cell = tableView.cellForRowAtIndexPath(playingIndexPath) as! HomeTableViewCell?
        timer.invalidate()
        if cell != nil {
            cell!.onlabel2.text = formatTimeString(playSong.duration)
            cell!.nami.progress = 1
        }
        
    }
    //違う画面になった時停止してタイマー止める
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if playSong != nil {
            playSong.stop()
            timer.invalidate()
        }else{
            
        }
    }
    
    
    
    
}

