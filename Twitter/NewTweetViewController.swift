//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Weifan Lin on 3/21/16.
//  Copyright © 2016 Weifan Lin. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.text = "What's happening?"
        tweetTextView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func textViewDidBeginEditing(tweetTextView: UITextView) {
        if (self.tweetTextView.text == "What's happening?") {
            self.tweetTextView.text = ""
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func sendTweet(sender: AnyObject) {
        let newTweet = tweetTextView.text
        
        if (newTweet != nil) {

            TwitterClient.sharedInstance.publishTweet({ (tweet: Tweet) -> () in
                }, failure: { (error: NSError) -> () in
                    print(error)
                }, text: newTweet)
            
            print(newTweet)
            
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {

            dismissViewControllerAnimated(true, completion: nil)
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
