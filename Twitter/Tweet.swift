//
//  Tweet.swift
//  Twitter
//
//  Created by Weifan Lin on 3/19/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String!
    var username: String?
    var userID: String!
    var screenname: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileImageUrl: NSURL?
    var tweetID: String!

    var user = User!()
    
    var isFavorited: Bool
    var isRetweeted: Bool
    
    var _createAt: String!
    var createAt: String? {
        get {
            let df = NSDateFormatter()
            //Wed Dec 01 17:08:03 +0000 2010
            df.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
            let date = df.dateFromString(_createAt)
            df.dateFormat = "M/dd/yy, HH:mm:ss a"
            let dateStr = df.stringFromDate(date!)
            return dateStr
        }
    }
    
    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as! String
        username = dictionary["user"]!["name"] as? String
        userID = dictionary["user"]!["id_str"] as! String
        screenname = dictionary["user"]!["screen_name"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        if let url = (dictionary["user"]!["profile_image_url_https"] as? String) {
            profileImageUrl = NSURL(string: url)
        }
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
        _createAt = dictionary["created_at"] as! String
        tweetID = dictionary["id_str"] as! String
        
        isFavorited = dictionary["favorited"] as! Bool
        isRetweeted = dictionary["retweeted"] as! Bool
    }
    
    class func tweetWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary  in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
