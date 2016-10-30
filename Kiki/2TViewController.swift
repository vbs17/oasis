
import UIKit
import AVFoundation
import Accelerate


class _TViewController: UIViewController,AVAudioRecorderDelegate {
    //こいつが音源
    
    var playSong:AVAudioPlayer!
    var timer: NSTimer!
    var timeCountTimer: NSTimer!
    let photos = ["Kiki17", "Kiki18", "Kiki19","Kiki20","Kiki21","08531cedbc172968acd38e7fa2bfd2e0"]
    var count = 1
    var timeCount = 1
    let fileManager = NSFileManager()
    let fileName = "sister1.m4a"
    var songData:NSURL!
    var sound:NSURL!
    var audioEngine: AVAudioEngine!
    var player: AVAudioPlayerNode!
    let engine = AVAudioEngine()
    let LEVEL_LOWPASS_TRIG:Float32 = 0.7
    var averagePower:Float32 = 0
    var songFile:NSURL!
    
    @IBOutlet weak var recButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nami1: UIProgressView!
    @IBOutlet weak var nami2: UIProgressView!
    @IBOutlet weak var nami3: UIProgressView!
    @IBOutlet weak var byou: UILabel!
    @IBOutlet weak var recImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recImage!.layer.cornerRadius = 37
        recImage!.clipsToBounds = true
    }
    
    
    @IBAction func rec(sender: AnyObject) {
        if count == 1{
            recButton!.enabled = false
            let image:UIImage! = UIImage(named: photos[0])
            imageView.image = image
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.nextPage), userInfo: nil, repeats: true )
        }else if count == 5{
            audioEngine.mainMixerNode.removeTapOnBus(0)
            audioEngine.stop()
            nextGamenn()
        }
    }
    
    func nextGamenn(){
        let playviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Play2") as! Play2ViewController
        playviewcontroller.songData2 = songFile
        self.presentViewController(playviewcontroller, animated: true, completion: nil)
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
            play()
            self.timeCountTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.recordLimits), userInfo: nil, repeats: true)
            sender.invalidate()
            recButton!.setImage(UIImage(named: "Kiki28"), forState: UIControlState.Normal)
            recButton!.layer.cornerRadius = 37
            recButton!.clipsToBounds = true
            recButton!.enabled = true
            
        }
        
    }
    
    
    func play() {
        
        let documentDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let filePath2 = NSURL(fileURLWithPath: documentDir + "/sample.caf")
        songFile = filePath2
        //ここ何してるんやろ songDataを代入するのは何でやろか
        if let url = songData {
            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                try audioSession.setActive(true)
                
                let audioFile = try AVAudioFile(forReading: url)
                
                
                audioEngine = AVAudioEngine()
                player = AVAudioPlayerNode()
                audioEngine.attachNode(player)
                let mixer = audioEngine.mainMixerNode
                
                audioEngine.connect(player, to: mixer, fromBus: 0, toBus: 0, format: player.outputFormatForBus(0))
                let inputNode = audioEngine.inputNode!
                let format = AVAudioFormat(commonFormat: .PCMFormatFloat32  , sampleRate: 44100, channels: 1 , interleaved: true)
                audioEngine.connect(inputNode, to: mixer, fromBus: 0, toBus: 1, format: format)
                
                player.scheduleFile(audioFile, atTime: nil) {
                    print("complete")
                }
                
                let audioFile2 = try AVAudioFile(forWriting: filePath2, settings: mixer.outputFormatForBus(0).settings)
                mixer.installTapOnBus(0, bufferSize: 4096, format: mixer.outputFormatForBus(0)) { (buffer, when) in
                    do {
                        try audioFile2.writeFromBuffer(buffer)
                    } catch let error {
                        print("audioFile2.writeFromBuffer error:", error)
                    }
                    let dB = self.averagePower
                    let atai = max(0, (dB + 77)) / 77
                    self.nami1.progress = atai
                    self.nami2.progress = atai
                    self.nami3.progress = atai
                }
                try audioEngine.start()
                player.play()
            } catch let error {
                print(error)
            }
        } else {
            print("File not found")
        }
        
        
    }
    
    
    
    func stop() {
        audioEngine.mainMixerNode.removeTapOnBus(0)
        self.audioEngine.stop()
    }
    
       func recordLimits(){
        let minuteCount = timeCount / 60
        let secondCount = timeCount % 60
        if secondCount <= 9 {
            byou.text = String(format: "%d:0%d", minuteCount, secondCount)
        }else if secondCount >= 10 {
            byou.text = String(format: "%d:%d", minuteCount, secondCount)
        }
        if timeCount == 360{
            self.timeCountTimer.invalidate()
            stop()
            nextGamenn()
        }else{
             timeCount += 1
        }
    }
    
    
    @IBAction func back(sender: AnyObject) {
        playSong.stop()
        timer.invalidate()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
}




