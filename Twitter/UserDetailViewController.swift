//
//  UserDetailViewController.swift
//  Twitter
//
//  Created by Weifan Lin on 3/25/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
//        {
//        didSet {
//            profilePhoto.setImageWithURL(user.profileUrl!)
//            usernameLabel.text = user.name
//            screennameLabel.text = user.screenname
//        }
//    }
    var userTweets: [Tweet]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        tableView.dataSource = self
//        tableView.delegate = self
        
        profilePhoto.setImageWithURL(user.profileUrl!)
        usernameLabel.text = user.name
        screennameLabel.text = user.screenname
//
        print(user.screenname)
//        let str: String! = user.screenname!
//        print(str)
         //get user's tweets
        //getUserTweets("\(user.screenname)")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func requestUserHomeTimeLine() {
//        
//        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
//            self.userTweets = tweets
//            self.tableView.reloadData()
//            for tweet in tweets {
//                print(tweet.text!)
//            }
//            }, failure: { (error: NSError) -> () in
//                print(error.localizedDescription)
//        })
//    }
    
    ////////// table \\\\\\\\\\
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
//        
//        cell.tweet = userTweets[indexPath.row]
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let userTweets = userTweets  {
//            return userTweets.count
//        } else {
//            return 0
//        }
//    }
    
    
    // get user's tweets
    func getUserTweets(screenname: String) {
        TwitterClient.sharedInstance.getTweetsFromUser({ (tweets: [Tweet]) -> () in
            self.userTweets = tweets
            self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
            }, screenname: screenname)
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
