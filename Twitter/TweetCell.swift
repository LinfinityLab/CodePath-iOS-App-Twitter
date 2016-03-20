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
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetText.text = tweet.text
            usernameLabel.text = tweet.username
            screennameLabel.text = "@"+tweet.screenname!
            tweetText.sizeToFit()
            usernameLabel.sizeToFit()
            profilePhoto.setImageWithURL(tweet.profileImageUrl!)
            durationLabel.text = tweet.createAt
        }
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
