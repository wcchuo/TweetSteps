//
//  Tweet.swift
//  Twipper
//
//  Created by Wei Chung Chuo on 8/13/15.
//  Copyright © 2015 Wei Chung Chuo. All rights reserved.
//

import Foundation
import Accounts
import Social


class Tweet {
    var tweetText: String?
    var userName: String?
    var createdAt: String?
    var pictureURL: NSURL?
    init (tweetText: String?, userName: String?, createdAt: String?, pictureURL : NSURL?) {
        self.tweetText = tweetText
        self.userName = userName
        self.createdAt = createdAt
        self.pictureURL = pictureURL
    }
    
    

    static func postTweet(steps: Int) {
        let accountStore = ACAccountStore()
        print(accountStore)
        let twitterAccountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(twitterAccountType,
            options: nil,
            completion: {
                (granted: Bool, error: NSError!) -> Void in
                if (!granted) {3
                    print ("Access to Twitter Account denied")
                } else {
                    let twitterAccounts = accountStore.accountsWithAccountType(twitterAccountType)
                    if twitterAccounts.count == 0 {
                        print ("No Twitter Accounts available")
                        return
                    } else {
                        let twitterParams = [
                            "status" : "I just took \(steps) steps! #steptweet #walk"
                        ]
                        let twitterAPIURL = NSURL(string: "https://api.twitter.com/1.1/statuses/update.json")
                        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                            requestMethod: SLRequestMethod.POST,
                            URL: twitterAPIURL,
                            parameters: twitterParams)
                        request.account = twitterAccounts.first as! ACAccount
                        request.performRequestWithHandler({
                            (responseData: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) -> Void in
                            self.handlePostTweetResponse(responseData, urlResponse: urlResponse, error: error)
                        })
                    }
                }
        })
    }
    
    static func handlePostTweetResponse(responseData: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) {
        if let dataValue = responseData {
            let jsonObject: AnyObject?
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions(rawValue: 0))
            } catch let error as NSError {
                print(error)
                jsonObject = nil
            }
            print("\(jsonObject)")
        } else {
            print("handleTwitterData received no data")
        }
    }

}
