//
//  HomeDataSource.swift
//  TwitterLBTA
//
//  Created by Unlocked on 4/21/17.
//  Copyright © 2017 Unlocked. All rights reserved.
//

import UIKit
import LBTAComponents
import TRON
import SwiftyJSON

class HomeDataSource: Datasource, JSONDecodable {
    let users: [User]
    
    required init(json: JSON) throws {
        
        var users = [User]()
        
        let array = json["users"].array
        for userJson in array! {
            let name = userJson["name"].stringValue
            let username = userJson["username"].stringValue
            let bio = userJson["bio"].stringValue
            
            let user = User(name: name,
                            username: username,
                            bioText: bio,
                            profileImage: UIImage())
            
            users.append(user)
        }
        
        self.users = users
    }
    
    let tweets: [Tweet] = {
        let brianUser = User(name: "Brian Voong",
                             username: "@buildthatapp",
                             bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps.",
                             profileImage: #imageLiteral(resourceName: "profile_name"))
        let tweet = Tweet(user: brianUser, message: "Welcome to episode 9 of the Twitter Series, really hope you guys are enjoying the series so far. I really really need a long text block to render out so we're going to stop here.")
        
        let tweet2 = Tweet(user: brianUser, message: "This is the second tweet message for out sample project. Very very exciting message...")
        
        
        return [tweet, tweet2]
    }()
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self , TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 {
            return tweets.count
        }
        return users.count
    }
}
