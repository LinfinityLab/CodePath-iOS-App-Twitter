//
//  TwitterClient.swift
//  Twitter
//
//  Created by Weifan Lin on 3/19/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "ML785xs8XjZpaj11O4f4F1TE6", consumerSecret: "n49MWCIRLvccFZ2p4r7ljyMtTw3bBiSWnPeO0OOZA3HptuS0kx")
    
    
//    var loginSuccess: (() -> ())?
//    var loginFailure: ((NSError) -> ())?
//    
//    
//    func login(success: () -> (), failure: (NSError) -> ()) {
//        loginSuccess = success
//        loginFailure = failure
//        
//        let client = TwitterClient.sharedInstance
//        
//        client.deauthorize()
//        client.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterapp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
//            print ("I got a token")
//            
//            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
//            
//            UIApplication.sharedApplication().openURL(url)
//            
//        }) { (error: NSError!) -> Void in
//            print ("error: \(error.localizedDescription)")
//            self.loginFailure?(error)
//        }
//    }
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        let client = TwitterClient.sharedInstance
        client.deauthorize()
        client.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterapp://oauth"), scope: nil, success: { (requesttoken:BDBOAuth1Credential!) -> Void in
            print("I got a request token")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requesttoken.token)")!
            UIApplication.sharedApplication().openURL(url)
        }) { (error: NSError!) -> Void in
            self.loginFailure?(error)
        }
    }
    
    func handleOpenUrl(url:NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            //print ("I got the access token!")
            self.loginSuccess?()
            
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetWithArray(dictionaries)
        
            success(tweets)
            
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }
    
    
    func currentAccount() {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            //print("account: \(response)")
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            print ("name : \(user.name!)")
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
        })
    }
}
