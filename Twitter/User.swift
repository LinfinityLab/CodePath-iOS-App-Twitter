//
//  User.swift
//  Twitter
//
//  Created by Weifan Lin on 3/19/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String!
    var screenname: String?
    var profileUrl: NSURL?
    var tagline: String!
    var dictionary: NSDictionary?
    
    var followers: Int = 0
    var following: Int = 0
    var totalTweets: Int = 0
    
    //var tweets = [Tweet]()  trying to get user's tweets but run into some trouble
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as! String
        screenname = dictionary["screenname"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as! String
        
        followers = (dictionary["followers_count"] as? Int) ?? 0
        
        following = (dictionary["friends_count"] as? Int) ?? 0
        
        totalTweets = (dictionary["statuses_count"] as? Int) ?? 0
        
        //tweets = Tweet.tweetWithArray((dictionary["status"] as? [NSDictionary])!)
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
        
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}
