//
//  User.swift
//  InstaCopy
//
//  Created by imac on 6/24/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

class User {
    
    // Attributes
    var username: String!
    var name: String!
    var profileImageUrl: String!
    var uid: String!
    
    init(uid: String, dictionary: Dictionary<String, AnyObject>) {
        
        self.uid = uid
        
        if let username = dictionary["username"] as? String {
            self.username = username
        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = profileImageUrl
        }
        
        
    }
    
    
    
}
