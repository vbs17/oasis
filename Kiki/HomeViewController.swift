

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

    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func backGo(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "CEll")
        back.layer.cornerRadius = 37
        back.clipsToBounds = true
    }
    
    func handleButton(sender: UIButton, event:UIEvent){
        let touch = event.allTouches()?.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        let postData = postArray[indexPath!.row]//どのセルがタップされたか認識できた(写真　曲名　秒数　音源など)
        let cell = tableView.cellForRowAtIndexPath(indexPath!) as! HomeTableViewCell
        
    }
    
    //移動
    func namigo(){
        nami.progress = Float(playSong.currentTime / playSong.duration)
    }
    
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
            let tapLocation = touch!.locationInView(self.view)
            print("touchesBegan ---- " + (tapLocation.x - nami.frame.origin.x).description)
        }
    }
    
    //タッチしたまま指を移動
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ((event?.touchesForView(nami)) != nil) {
            print("touchesMoved ---- AudioView")
            let touch = touches.first
            let tapLocation = touch!.locationInView(self.view)
            print("touchesMoved ---- " + (tapLocation.x - nami.frame.origin.x).description)
            
        }
    }
    
    //タッチした指が画面から離れる
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ((event?.touchesForView(nami)) != nil) {
            print("touchesEnded ---- AudioView")
            let touch = touches.first
            let tapLocation = touch!.locationInView(self.view)
            let x:Double = Double(tapLocation.x - view.frame.origin.x)
            let time = playSong.duration
            let p:Double = x / Double(nami.frame.size.width)
            playSong.currentTime = Double(time * p)
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCellWithIdentifier("CEll", forIndexPath: indexPath) as! HomeTableViewCell
        cell.setPostData(postArray[indexPath.row])   //var postArray: [PostData] = [] 写真　曲名　秒数　音源が存在してる
        return cell
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

    

   
}
