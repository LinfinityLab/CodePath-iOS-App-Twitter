//
//  UserDetailViewController.swift
//  Twitter
//
//  Created by Weifan Lin on 3/25/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userBackgroundImg: UIView!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    var user: User!
    var userTweets: [Tweet]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make nav bar completely translucent
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()

        tableView.dataSource = self
        tableView.delegate = self
        
        profilePhoto.setImageWithURL(user.profileUrl!)
        profilePhoto.layer.cornerRadius = 6
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.borderWidth = 3
        profilePhoto.layer.borderColor = UIColor.whiteColor().CGColor
        
        usernameLabel.text = user.name
        screennameLabel.text = user.screenname
        followerCountLabel.text = String(user.followers)
        followingCountLabel.text = String(user.following)
        
        getUserTweets(user.screenname!)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ////////// table \\\\\\\\\\
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserTweetCell", forIndexPath: indexPath) as! UserTweetCell
        
        cell.tweet = userTweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userTweets = userTweets  {
            return userTweets.count
        } else {
            return 0
        }
    }
    
    
    // get user's tweets
    func getUserTweets(screenname: String) {
        TwitterClient.sharedInstance.getTweetsFromUser({ (tweets: [Tweet]) -> () in
            self.userTweets = tweets
            self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
            }, screenname: screenname)
    }
    
    @IBAction func goBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
