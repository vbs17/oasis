import UIKit
import AVFoundation

//録音できたものを次の画面に移す　録音中にマイクの音を拾って波をつける

class ViewController: UIViewController,AVAudioRecorderDelegate {
    
    
    let fileManager = NSFileManager()//録音もできないしそれを再生もできない
    var audioRecorder: AVAudioRecorder!
    let fileName = "sample.caf"
    var timer: NSTimer!
    var timeCountTimer: NSTimer!
    let photos = ["Kiki17", "Kiki18", "Kiki19","Kiki20","Kiki21","08531cedbc172968acd38e7fa2bfd2e0"]
    var count = 1
    var timeCount = 1
    let songs = ["kiki.band","kiki2.band","kiki3.band","kiki4.band","kiki5.band"]
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var recordImage: UIButton?
    @IBOutlet weak var nami1: UIProgressView!
    @IBOutlet weak var nami2: UIProgressView!
    @IBOutlet weak var nami3: UIProgressView!
    @IBOutlet weak var byou: UILabel!

 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAudioRecorder()
        recordImage!.layer.cornerRadius = 37
        recordImage!.clipsToBounds = true
    }
    
    //カウントダウンしてレコード開始しボタンのUIも変更 //countでif文で処理ればいいかも
    @IBAction func recordStart(sender: UIButton) {
        if count == 1{
        recordImage!.enabled = false
        let image:UIImage! = UIImage(named: photos[0])
        imageView.image = image
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.nextPage), userInfo: nil, repeats: true )
        }else if count == 5{
            self.timeCountTimer.invalidate()
            audioRecorder.stop()
            nextGamenn()
    }
        
    }
    
    
    func nextPage (sender:NSTimer){
        
        var image:UIImage! = UIImage(named: photos[1])
        if count == 1{
            imageView.image = image;
            count += 1
        }else if count == 2{
            image = UIImage(named: photos[2])
            imageView.image = image
            count += 1
        }else if count == 3{
            image = UIImage(named: photos[3])
            imageView.image = image
            count += 1
        }else if count == 4{
            image = UIImage(named: photos[4])
            imageView.image = image
            count += 1
        }else if count == 5{
            image = UIImage(named: photos[5])
            imageView.image = image
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(ViewController.levelTimerCallback), userInfo: nil, repeats: true)
            self.timeCountTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.recordLimits), userInfo: nil, repeats: true)
            audioRecorder.meteringEnabled = true
            sender.invalidate()
            recordImage!.setImage(UIImage(named: "Kiki28"), forState: UIControlState.Normal)
            recordImage!.layer.cornerRadius = 37
            recordImage!.clipsToBounds = true
            recordImage!.enabled = true

        }
        
    }
    
    func setupAudioRecorder() {
        let session = AVAudioSession.sharedInstance() //ここではどっちも設定してる
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord) //マイクから取りこんだ音声データを、再生専用とか録音専用の指定もある
        try! session.setActive(true)
        let recordSetting : [String : AnyObject] = [
            //オーディオデータを設定の通りに全て取りこんでると大量のデータになってしまうので、圧縮//.minのとこ音質変えれる
            AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey : 16,//1枚のページにたして16の情報をかけてる
            AVNumberOfChannelsKey: 2 , //イヤホンも左右から違う音が聞こえる
            AVSampleRateKey: 44100.0 //これが多ければ多いほどスムーズ
        ]
        do {     //録音したものは/aaa/bbb/ccc.app/Document/sample.caここに入る
            try audioRecorder = AVAudioRecorder(URL: self.documentFilePath(), settings: recordSetting)
            
            print(self.documentFilePath())
        } catch {
            print("初期設定でerror")
        }
    }
    
    
    
    // 録音するファイルのパスを取得(録音時、再生時に参照)
    // swift2からstringByAppendingPathComponentが使えなくなったので少し面倒
    func documentFilePath()-> NSURL {//要求されたドメインで指定された一般的なディレクトリの Url の配列を返します
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        //iTunesにもバックアップされる、大事なファイルを置くディレクトリへのパスを取得
        let dirURL = urls[0] //要求されたドメインで指定された一般的なディレクトリの Url の配列のうちの一個が帰ってくる
        return dirURL.URLByAppendingPathComponent(fileName)
    }          //その指定したディレクトリにurlを置いて完
        
    //  0 ||||||||||||||||||||||||||||| 1
    //-77 ||||||||||||||||||||||||||||| 0
    //それが、dBに77を足した値を、77で割る式
    func levelTimerCallback() {
        audioRecorder.updateMeters()
        //元のdB値が0から160を取れる
        let dB = audioRecorder.averagePowerForChannel(0)
                    //0か(dB + 77)かいずれか大きい方という意味.あとはこれを、取り得る最大値(今回だと77)で割れば良い
        //dBが-77のとき0.0になり、0のとき1.0になる変換を行う必要があります
        //(db + 77) / 77が意味不明
        let atai = max(0, (dB + 77)) / 77
        nami1.progress = atai
        nami2.progress = atai
        nami3.progress = atai
    }
    
    func recordLimits(){
        //ここの計算よく分からん
        let minuteCount = timeCount / 60
        let secondCount = timeCount % 60
        if secondCount <= 9 {
        byou.text = String(format: "%d:0%d", minuteCount, secondCount)
        }else if secondCount >= 10 {
        byou.text = String(format: "%d:%d", minuteCount, secondCount)
        }
        if timeCount == 360{
            self.timeCountTimer.invalidate()
            audioRecorder.stop()
            nextGamenn()
        }else{
            timeCount += 1
        }
    }
    
    func nextGamenn(){
        let playviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Play") as! PlayViewController
        playviewcontroller.songData = self.documentFilePath()
         self.presentViewController(playviewcontroller, animated: true, completion: nil)
        
        
    }

    
  }





