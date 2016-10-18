

import UIKit
import AVFoundation

class HomeTableViewCell: UITableViewCell {
    
    //写真　曲名　秒数　音源
    
    var tap:String?
    var playSong:AVAudioPlayer!
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var cellText: UITextField!
    @IBOutlet weak var cellLabel: UILabel!
    
    //写真タップされたら音源を再生
    @IBAction func play(sender: AnyObject) {
        let url = NSURL(fileURLWithPath: tap!)
        playSong = try! AVAudioPlayer(contentsOfURL: url)
        playSong?.prepareToPlay()
        playSong?.play()
    }
    
    //写真　曲名　秒数　音源を設定
    //セルを取得してデータを設定する
    //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! HomeTableViewCell
    //cell.setPostData(postArray[indexPath.row])
    
    //return cell

    func setPostData(postData: PostData) {
        ImageView.image = postData.image
        cellText.text = postData.name
        cellLabel.text = postData.byou
        tap = postData.song
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
