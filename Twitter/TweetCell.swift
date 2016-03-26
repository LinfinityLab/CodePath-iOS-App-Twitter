//
//  TweetCell.swift
//  Twitter
//
//  Created by Weifan Lin on 3/19/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit
import AFNetworking

@objc protocol SegueDetailUserDelegate {
    optional func toUserDetailView(cell: TweetCell)
}

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    weak var delegate: SegueDetailUserDelegate?
    
    var tweet: Tweet! {
        didSet {
            tweetText.text = tweet.text
            usernameLabel.text = tweet.username
            screennameLabel.text = "@"+tweet.screenname!
            tweetText.sizeToFit()
            usernameLabel.sizeToFit()
            profilePhoto.setImageWithURL(tweet.profileImageUrl!)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: Selector("imageTapped"))
        profilePhoto.userInteractionEnabled = true
        profilePhoto.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func imageTapped() {
        if self.delegate != nil {
            delegate!.toUserDetailView?(self)
        }
        
    }

}
