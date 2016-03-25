//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Weifan Lin on 3/19/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD


//let date = NSDate()
//let calendar = NSCalendar.currentCalendar()
//let components = calendar.components([.Day , .Month , .Year], fromDate: date)
//
//let year =  components.year
//let month = components.month
//let day = components.day
//let hour = components.hour
//let minute = components.minute
//let second = components.second

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    
    let logo = UIImage(named: "twitter")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UIImageView(image:logo)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        refreshControlAction(refreshControl)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    
    // get tweets
    func requestHomeTimeLine() {
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            for tweet in tweets {
                print(tweet.text!)
            }
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }
    

    internal class Reachability {
        class func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        if Reachability.isConnectedToNetwork() {
            navigationItem.titleView = UIImageView(image:logo)
            requestHomeTimeLine()
        } else {
            navigationItem.titleView = nil
            navigationItem.title = "Disconnected"
        }
        refreshControl.endRefreshing()
        
    }
    
    ////////// table \\\\\\\\\\
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets  {
            return tweets.count
        } else {
            return 0
        }
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "TweetDetailSegue") {
            
            let detailTweetViewController = segue.destinationViewController as! DetailTweetViewController
            let cell = sender as! TweetCell
            let indexpath = tableView.indexPathForCell(cell)
            let tweet = tweets[indexpath!.row]
            
            detailTweetViewController.tweet = tweet
            
        } else if (segue.identifier == "UserDetailSegue") {
            
        }
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
