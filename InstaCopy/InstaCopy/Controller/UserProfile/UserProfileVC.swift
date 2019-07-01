//
//  UserProfileVC.swift
//  InstaCopy
//
//  Created by imac on 6/21/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "UserProfileHeader"

class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate {
    
    // MARK: Properties
    
    var user: User?
    
    var userToLoadFromSearchVC: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        // Bg color
        self.collectionView.backgroundColor = .white
        
        // Fetch user data
        if userToLoadFromSearchVC == nil {
            fetchCurrentUserData()
        }

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 200)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // Declare Header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
        
        // Set delegate
        header.delegate = self
        
        // Set user header
        if let user = self.user {
            header.user = user
        } else if let userToLoadFromSearchVC = self.userToLoadFromSearchVC {
            header.user = userToLoadFromSearchVC
            navigationItem.title = userToLoadFromSearchVC.username
        }

        return header
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        
    
        return cell
    }
    
    // MARK: - UserProfileHeader Protocol
    
    func handleFollowersTapped(for header: UserProfileHeader) {
        let followVC = FollowVC()
        followVC.viewFollowers = true
        navigationController?.pushViewController(followVC, animated: true)
    }
    
    func handleFollowingTapped(for header: UserProfileHeader) {
        let followVC = FollowVC()
        followVC.viewFollowing = true
        navigationController?.pushViewController(followVC, animated: true)
    }
    
    func handleEditFollowTapped(for header: UserProfileHeader) {
        
        guard let user = header.user else { return }

        if header.editProfileFollowButton.titleLabel?.text == "Edit Profile" {
            print("Hanle edit profile")
        } else {

            if header.editProfileFollowButton.titleLabel?.text == "Follow" {
                header.editProfileFollowButton.setTitle("Following", for: .normal)
                user.follow()
            } else {
                header.editProfileFollowButton.setTitle("Follow", for: .normal)
                user.unfollow()
            }
        }
        
    }
    
    func setUserStats(for header: UserProfileHeader) {
        
        guard let uid = header.user?.uid else { return }
        
        var numberOfFollwers: Int!
        var numberOfFollowing: Int!

        // Get number of followers
        USER_FOLLOWER_REF.child(uid).observe(.value) { (snapshot) in

            if let snapshot = snapshot.value as? Dictionary<String, AnyObject> {
                numberOfFollwers = snapshot.count
            } else {
                numberOfFollwers = 0
            }

            let attributedText = NSMutableAttributedString(string: "\(numberOfFollwers!)\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            header.followersLabel.attributedText = attributedText

        }

        // Get number of following
        USER_FOLLOWING_REF.child(uid).observe(.value) { (snapshot) in

            if let snapshot = snapshot.value as? Dictionary<String, AnyObject> {
                numberOfFollowing = snapshot.count
            } else {
                numberOfFollowing = 0
            }

            let attributedText = NSMutableAttributedString(string: "\(numberOfFollowing!)\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            header.followingLabel.attributedText = attributedText

        }

    }
    
    // MARK: - API
    
    func fetchCurrentUserData() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            self.user = user
            self.navigationItem.title = user.username
            self.collectionView.reloadData()
        }
        

        }


}
