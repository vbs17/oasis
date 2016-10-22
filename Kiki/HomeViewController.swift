

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
    var ImageView: UIImageView!
    var label: UILabel!
    var label2: UILabel!
    var onlabel2: UILabel!
    var nami: UIProgressView!
    var back: UIButton!
    var tableView: UITableView!
    var playingIndexPath:NSIndexPath!
    //しょうもない設定
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "CEll")
        back.layer.cornerRadius = 37
        back.clipsToBounds = true
        
    }
    
    //波と秒数
    func updatePlayingTime() {
        let cell = tableView.cellForRowAtIndexPath(playingIndexPath) as! HomeTableViewCell?
        if cell != nil {
            cell!.onlabel2.text = formatTimeString(playSong.currentTime)
            cell!.nami.progress = Float(playSong.currentTime / playSong.duration)
        }
    }

    //厄介者
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        let cell = tableView.cellForRowAtIndexPath(playingIndexPath) as! HomeTableViewCell?
        timer.invalidate()
        if cell != nil {
            cell!.onlabel2.text = formatTimeString(playSong.duration)
            cell!.nami.progress = 1
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if playSong != nil {
            playSong.stop()
            timer.invalidate()
        }else{
            
        }
    }
    
        //セルの数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }

    //セルの数の分データを設定　３つなら３つのデータが設定される　これはそのうちの一つのセルの設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CEll", forIndexPath: indexPath) as! HomeTableViewCell
        if (playingIndexPath != nil) && (indexPath == playingIndexPath) {
            cell.backButton.enabled = true
        } else {
            cell.nami.progress = 0
            cell.onlabel2.text = "0:00"
            cell.backButton.enabled = false
        }
        cell.setPostData(postArray[indexPath.row])
        cell.playButton.addTarget(self, action:#selector(
            handleButton(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.backButton.addTarget(self, action:#selector(
            back(_:event:)), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
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
        } else {
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

    //タッチ開始時

    //無視
    
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

