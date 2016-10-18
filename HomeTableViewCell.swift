//
//  HomeTableViewCell.swift
//  
//
//  Created by kei ikeuchi on 2016/10/18.
//
//

import UIKit
import AVFoundation

class HomeTableViewCell: UITableViewCell {
    var tap:String?
    var playSong:AVAudioPlayer!

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBAction func play(sender: AnyObject) {
        let url = NSURL(fileURLWithPath: tap!)
        playSong = try! AVAudioPlayer(contentsOfURL: url)
        playSong?.prepareToPlay()
        playSong?.play()

    }
    
    func setPostData(postData: PostData) {
        ImageView.image = postData.image
        label.text = postData.name
        label2.text = postData.byou
        tap = postData.song
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
