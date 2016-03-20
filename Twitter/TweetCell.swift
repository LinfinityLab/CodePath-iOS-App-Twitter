//
//  TweetCell.swift
//  Twitter
//
//  Created by Weifan Lin on 3/19/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var llll: UILabel!
    var st = "g"
    
    var tweet: Tweet! {
        didSet {
            tweetText.text = tweet.text as? String
            tweetText.sizeToFit()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        llll.text = st
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
