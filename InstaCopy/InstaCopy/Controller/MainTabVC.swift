//
//  MainTabVC.swift
//  InstaCopy
//
//  Created by imac on 6/21/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate
        self.delegate = self
        
        // Config view controllers
        configureViewControllers()
        
        // User validation
        checkIfUserIsLoggedIn()

    }
    
    /// Function to create view controllers
    func configureViewControllers() {
        
        // Home feed controller
        let feedVC = constructNavController(unselectedImage: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!, rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Search feed controller
        let searchVC = constructNavController(unselectedImage: UIImage(named: "search_unselected")!, selectedImage: UIImage(named: "search_selected")!, rootViewController: SearchVC())
        
        // Post controller
        let uploadPostVC = constructNavController(unselectedImage: UIImage(named: "plus_unselected")!, selectedImage: UIImage(named: "plus_unselected")!, rootViewController: UploadPostVC())
        
        // Notification controller
        let notificationVC = constructNavController(unselectedImage: UIImage(named: "like_unselected")!, selectedImage: UIImage(named: "like_selected")!, rootViewController: NotificationsVC())
        
        // Profile controller
        let userprofileVC = constructNavController(unselectedImage: UIImage(named: "profile_unselected")!, selectedImage: UIImage(named: "profile_selected")!, rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // View controller add
        viewControllers = [feedVC, searchVC, uploadPostVC, notificationVC, userprofileVC]
        
        // Tab bar tint Color
        tabBar.tintColor = .black
        
    }
    
    /// Construct navigation bar
    func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // Construct nav controller
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.barTintColor = .white
        
        return navController
        
    }
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                // Present login controller
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
    }

}
