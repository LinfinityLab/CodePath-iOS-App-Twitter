//
//  UserTweetCell.swift
//  Twitter
//
//  Created by Weifan Lin on 3/25/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

class UserTweetCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
//            usernameLabel.text = tweet.username
//            screennameLabel.text = "@"+tweet.screenname!
//            tweetText.sizeToFit()
//            usernameLabel.sizeToFit()
//            profilePhoto.setImageWithURL(tweet.profileImageUrl!)
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
