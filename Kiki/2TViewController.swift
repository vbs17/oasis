
import UIKit
import AVFoundation


class _TViewController: UIViewController {
    //こいつが音源
    var songData:NSURL!
    var playSong:AVAudioPlayer!
    let fileManager = NSFileManager()
    var audioRecorder: AVAudioRecorder!
    let fileName = "sister.m4a"
    var timer: NSTimer!
    var timeCountTimer: NSTimer!
    let photos = ["Kiki17", "Kiki18", "Kiki19","Kiki20","Kiki21","08531cedbc172968acd38e7fa2bfd2e0"]
    var count = 1
    var timeCount = 1
    
    @IBOutlet weak var recButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let sound:AVAudioPlayer = try! AVAudioPlayer(contentsOfURL: songData!)
        playSong = sound
        sound.prepareToPlay()
        
    }
    
    func nextGamenn(){
        let playviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Play2") as! Play2ViewController
        playviewcontroller.songData = songData
        playviewcontroller.songData2 = self.documentFilePath()
        self.presentViewController(playviewcontroller, animated: true, completion: nil)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func rec(sender: AnyObject) {
        if count == 1{
            recButton!.enabled = false
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
            playSong.play()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(ViewController.levelTimerCallback), userInfo: nil, repeats: true)
            self.timeCountTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.recordLimits), userInfo: nil, repeats: true)
            audioRecorder.meteringEnabled = true
            sender.invalidate()
            recButton!.setImage(UIImage(named: "Kiki28"), forState: UIControlState.Normal)
            recButton!.layer.cornerRadius = 37
            recButton!.clipsToBounds = true
            recButton!.enabled = true
            
        }
        
    }
    func setupAudioRecorder() {
        let session = AVAudioSession.sharedInstance()
        
        
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        
        try! session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        
        try! session.setActive(true)
        let recordSetting : [String : AnyObject] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey: 1 ,
            AVSampleRateKey: 44100
        ]
        
        do {
            try audioRecorder = AVAudioRecorder(URL: self.documentFilePath(), settings: recordSetting)
            
            print(self.documentFilePath())
        } catch {
            print("初期設定でerror")
        }
    }
    
    func documentFilePath()-> NSURL {
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        let dirURL = urls[0]
        return dirURL.URLByAppendingPathComponent(fileName)
    }
    
    
    
}
