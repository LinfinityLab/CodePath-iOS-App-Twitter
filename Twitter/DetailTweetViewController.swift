//
//  DetailTweetViewController.swift
//  Twitter
//
//  Created by Weifan Lin on 3/23/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
        
    
    var tweet: Tweet!
    
    let notFavedImage = UIImage(named: "like-action")
    let favedImage = UIImage(named: "like-action-on")
    let notRetweetedImage = UIImage(named: "reweet-action")
    let retweetedImage = UIImage(named: "reweet-action-on")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Tweet"
        

        if tweet.isFavorited {
            favoriteButton.setImage(favedImage, forState: .Normal)
        } else {
            favoriteButton.setImage(notFavedImage, forState: .Normal)
        }
        

        
        if tweet.isRetweeted {
            retweetButton.setImage(retweetedImage, forState: .Normal)
        } else {
            retweetButton.setImage(notRetweetedImage, forState: .Normal)
        }
        
        tweetTextLabel.text = tweet.text
        usernameLabel.text = tweet.username
        screennameLabel.text = "@"+tweet.screenname!
        tweetTextLabel.sizeToFit()
        usernameLabel.sizeToFit()
        profilePhoto.setImageWithURL(tweet.profileImageUrl!)
        timestampLabel.text = tweet.createAt
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favoritesCountLabel.text = "\(tweet.favoritesCount)"

        profilePhoto.layer.cornerRadius = 6
        profilePhoto.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        profilePhoto.userInteractionEnabled = true
        profilePhoto.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retweet(sender: AnyObject) {

        if (!tweet.isRetweeted) {
            retweetButton.setImage(retweetedImage, forState: .Normal)
            
            TwitterClient.sharedInstance.retweetAction({ (tweet) -> () in
                
                }, failure: { (error: NSError) -> () in
                    print(error)
                }, tweetID: tweet.tweetID)
        } else {
            // unretweeted
        }

    }

    @IBAction func favorite(sender: AnyObject) {
        
        if (!tweet.isFavorited) {
            favoriteButton.setImage(favedImage, forState: .Normal)
            
            TwitterClient.sharedInstance.favoriteAction({ (tweet) -> () in
                
                }, failure: { (error: NSError) -> () in
                    print(error)
                }, tweetID: tweet.tweetID)
        } else {
            // unfavorite
        }
    }
    
    
    func imageTapped(img: AnyObject)
    {
        print("the img was tapped")
        performSegueWithIdentifier("UserDetailSegue", sender: self)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if (segue.identifier == "UserDetailSegue") {
            
            let userDetailViewController = segue.destinationViewController as! UserDetailViewController
            userDetailViewController.user = tweet.user
        }
    }

}
