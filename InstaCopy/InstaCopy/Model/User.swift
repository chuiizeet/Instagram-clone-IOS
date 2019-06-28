//
//  User.swift
//  InstaCopy
//
//  Created by imac on 6/24/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//
import Firebase

class User {
    
    // Attributes
    var username: String!
    var name: String!
    var profileImageUrl: String!
    var uid: String!
    var isFollowed = false
    
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
    
    func follow() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        guard let uid = uid else { return }
        
        // Set is followed to true
        self.isFollowed = true
        
        // Add followed user to current user-following struct
        USER_FOLLOWING_REF.child(currentUid).updateChildValues([self.uid: 1])
        
        // Add current user to followed user-follower struct
        USER_FOLLOWER_REF.child(uid).updateChildValues([self.uid: 1])
        
    }
    
    func unfollow() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        guard let uid = uid else { return }
        
        // Set is followed to false
        self.isFollowed = false
        
        // Remove from current user-following struc
        USER_FOLLOWING_REF.child(currentUid).child(self.uid).removeValue()
        
        // Remove current user from user-following struc
        USER_FOLLOWING_REF.child(uid).child(currentUid).removeValue()
        
    }
    
    func checkIfUserIsFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        USER_FOLLOWING_REF.child(currentUid).observeSingleEvent(of: .value) { (snapshot) in

            if snapshot.hasChild(self.uid) {
                self.isFollowed = true
                print("User is followed")
            } else {
                self.isFollowed = false
                print("User is not followed")
            }
        }
    }
    
    
}
