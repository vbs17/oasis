

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import AVFoundation

class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,AVAudioPlayerDelegate{
    var postArray: [PostData] = []
    var postArray2:[PostData2] = []
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
        cell.edittingFlag = false
        cell.star1.userInteractionEnabled = false
        cell.star2.userInteractionEnabled = false
        cell.star3.userInteractionEnabled = false
        cell.star4.userInteractionEnabled = false
        cell.star5.userInteractionEnabled = false
        if (playingIndexPath != nil) && (indexPath == playingIndexPath) {
            cell.backButton.enabled = true
        } else {//それ以外のセル
            cell.nami.progress = 0
            cell.onlabel2.text = "0:00"
            cell.backButton.enabled = false
        }
        cell.setPostData(postArray[indexPath.row])
        let postData1 = postArray[indexPath.row]
        var image:UIImage? = nil
        for id in postArray2{
            if postData1.uid == id.uid{
                image = id.image
            }
        }
        cell.imageView1.image = image

        cell.go.addTarget(self, action: #selector(pro(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
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
    
    func pro(sender: UIButton, event:UIEvent) {
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]
        let pro = self.storyboard?.instantiateViewControllerWithIdentifier("Pi") as! ProIdouViewController
        pro.uid = postData.uid
        self.presentViewController(pro, animated: true, completion: nil)
        
    }

    
    func getIndexPath(event:UIEvent) -> NSIndexPath? {
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        return indexPath
    }

    //色を無色星にする
    func hyoukaGo(sender:UIButton, event:UIEvent){
        let indexPath = getIndexPath(event)
        let cell = tableView.cellForRowAtIndexPath(indexPath!) as! HomeTableViewCell?
        cell?.hyouka.tintColor = UIColor.blackColor()
        if cell!.edittingFlag == false{
        cell!.edittingFlag = true
        cell!.star1.userInteractionEnabled = true
        cell!.star2.userInteractionEnabled = true
        cell!.star3.userInteractionEnabled = true
        cell!.star4.userInteractionEnabled = true
        cell!.star5.userInteractionEnabled = true
        cell?.star1.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
        cell?.star2.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
        cell?.star3.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
        cell?.star4.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
        cell?.star5.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
        } else if cell!.edittingFlag == true{
            cell?.hyouka.tintColor = UIColor.redColor()
            cell!.edittingFlag = false
            cell?.setPostData1(self.postArray[indexPath!.row])
            cell!.star1.userInteractionEnabled = false
            cell!.star2.userInteractionEnabled = false
            cell!.star3.userInteractionEnabled = false
            cell!.star4.userInteractionEnabled = false
            cell!.star5.userInteractionEnabled = false
            
        }
    }
    
     //ここでprofie画像消さないようにするには
    func hoshi(sender: UIButton, event:UIEvent){
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath!) as! HomeTableViewCell?
        //どのセルかわかった
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            var index = -1 //0からpostData.star.count(postData.star.countは含まない)
            for var i in (0 ..< postData.star.count) {
                
                let starDic = Array(postData.star[i].keys)
                // star配列の中から 自分が投票したデータを探す
                if starDic[0] == uid{
                    index = i
                    break
                }
            }
            // -1 の場合は削除対象のデータが無い
            if index != -1 {//例えば3つ星タップしてたとして再度評価したらそれを消して再度保存しな一人で総数100回とか出来てまうから
                postData.star.removeAtIndex(index)
            }
                                           //何個星タップしたかpostData.starに保存
            postData.star.append([uid:String(sender.tag)])
        }
        
        switch sender.tag {
        case 1:
            cell?.star1.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
        case 2:
            cell?.star1.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star2.setImage(UIImage(named:"IMG_2728 2"), forState: UIControlState.Normal)
        case 3:
            cell?.star1.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star2.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star3.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
        case 4:
            cell?.star1.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star2.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star3.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star4.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
        case 5:
            cell?.star1.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star2.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star3.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star4.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)
            cell?.star5.setImage(UIImage(named:"IMG_2727 2"), forState: UIControlState.Normal)

        default: break
        }
       //配列との相性悪いせいでいちいち全部保存しなあかん
        //どこのgenreのどのセルに星がついたか保存しなあかん
       
        let imageString = postData.imageString
        let name = postData.name
        let song = postData.song
        let byou = postData.byou
        let realsong = postData.realsong
        let star = postData.star //97行目
        let uid:NSString = postData.uid!
        let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH).child(genre)
        let postData2 = ["image":imageString!,"songname":name!,"ongen":song!,"byou":byou!,"realsong":realsong!,"star":star,"uid":uid]
        postRef.child(postData.id!).setValue(postData2)
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
                //ここもfunc hoshiと一緒
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func handleButton(sender: UIButton, event:UIEvent){
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
            //ここもポイント
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
        return UITableViewAutomaticDimension
    }
    
    // セルをタップされたら何もせずに選択状態を解除する
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func backGo(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //波と秒数
    func updatePlayingTime() {
        let cell = tableView.cellForRowAtIndexPath(playingIndexPath) as! HomeTableViewCell?
        if (cell != nil) && (playSong.currentTime >= 0.1) {
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
            cell!.nami.progress = 0
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

