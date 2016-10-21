

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import AVFoundation

class HomeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    var postArray: [PostData] = [] //写真　曲名　秒数　音源の格納庫
    var observing = false
    var genre: String!
    var playSong:AVAudioPlayer!
    var timer: NSTimer!
    var ImageView: UIImageView!
    var label: UILabel!
    var label2: UILabel!
    var onlabel2: UILabel!
    var view11: UIView!
    var nami: UIProgressView!
    var back: UIButton!
    var tableView: UITableView!
    
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
        cell.setPostData(postArray[indexPath.row])
        cell.playButton.addTarget(self, action:#selector(
            handleButton(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.backButton.addTarget(self, action:#selector(
            back(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }


    //どの音楽がタップされたか識別
    func handleButton(sender: UIButton, event:UIEvent){
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath!) as! HomeTableViewCell
        if (timer == nil){
            let tap = NSData(base64EncodedString: postData.realsong!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            playSong = try! AVAudioPlayer(data:tap!)
            playSong?.prepareToPlay()
            playSong?.play()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(HomeViewController.updatePlayingTime), userInfo: nil, repeats: true)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(HomeViewController.namigo), userInfo: nil, repeats: true)
        }else if (timer !== nil){
            playSong.pause()
            timer.invalidate()
            timer = nil
        }

    }
    
    //巻き戻し
    func back(sender: UIButton, event:UIEvent) {
            onlabel2.text = "0:00"
            playSong.stop()
            playSong.prepareToPlay()
            playSong.currentTime = 0
            playSong.play()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(HomeViewController.namigo), userInfo: nil, repeats: true)
    }

    //波
    func namigo(){
        nami.progress = Float(playSong.currentTime / playSong.duration)
    }
    //onbyou
    func updatePlayingTime() {
        if  floor(playSong.currentTime) ==  floor(playSong.duration) {
            playSong.stop()
            if timer != nil {
                timer.invalidate()
            }
            onlabel2.text = formatTimeString(playSong.duration)
            return
        }
        
        onlabel2.text = formatTimeString(playSong.currentTime)
    }
    
    //tesita
    func formatTimeString(d: Double) -> String {
        let s: Int = Int(d % 60)
        let m: Int = Int((d - Double(s)) / 60 % 60)
        let str = String(format: "%2d:%02d",  m, s)
        return str
    }

    //タッチ開始時
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ((event?.touchesForView(nami)) != nil) {
            print("touchesBegan ---- AudioView")
            let touch = touches.first
            let tapLocation = touch!.locationInView(self.view11)
            print("touchesBegan ---- " + (tapLocation.x - nami.frame.origin.x).description)
        }
    }
    
    //タッチしたまま指を移動
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ((event?.touchesForView(nami)) != nil) {
            print("touchesMoved ---- AudioView")
            let touch = touches.first
            let tapLocation = touch!.locationInView(self.view11)
            print("touchesMoved ---- " + (tapLocation.x - nami.frame.origin.x).description)
            
        }
    }
    
    //タッチした指が画面から離れる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ((event?.touchesForView(nami)) != nil) {
            print("touchesEnded ---- AudioView")
            let touch = touches.first
            let tapLocation = touch!.locationInView(self.view11)
            let x:Double = Double(tapLocation.x - view11.frame.origin.x)
            let time = playSong.duration
            let p:Double = x / Double(nami.frame.size.width)
            playSong.currentTime = Double(time * p)
        }
    }

    //無視
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
      func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Auto Layoutを使ってセルの高さを動的に変更する
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // セルをタップされたら何もせずに選択状態を解除する
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if FIRAuth.auth()?.currentUser != nil {
            if observing == false {
                // 写真　曲名　秒数　音源が追加されたらpostArray(写真　曲名　秒数　音源の格納庫)に追加してTableViewを再表示する
                FIRDatabase.database().reference().child(CommonConst.PostPATH).child(genre).observeEventType(.ChildAdded, withBlock: { snapshot in
                    
                    // PostDataクラスを生成して受け取ったデータを設定する
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        let postData = PostData(snapshot: snapshot, myId: uid) //写真　曲名　秒数　音源が存在してる
                        self.postArray.insert(postData, atIndex: 0)
                        
                        // TableViewを再表示する
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }

    
    @IBAction func backGo(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

   
 }

