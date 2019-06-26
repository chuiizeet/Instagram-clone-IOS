//
//  SearchVC.swift
//  InstaCopy
//
//  Created by imac on 6/21/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchUserCell"

class SearchVC: UITableViewController {
    
    // MARK - Properties
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        tableView.register(SearchUserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // Separator insets
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
        
        // Config nav controller
        configureNavController()
        
        // Fetch users
        fetchUsers()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        print("The username is: \(user.username)")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchUserCell
        
        cell.user = users[indexPath.row]
        
        return cell
        
    }
    
    // MARK: - Handlers
    
    func configureNavController() {
        navigationItem.title = "Explore"
    }
    
    // MARK: - API
    
    func fetchUsers() {
        
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            
            // Uid
            let uid = snapshot.key
            
            // Snapshot value cast as dict
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            // User
            let user = User(uid: uid, dictionary: dictionary)
            
            // Append user data
            self.users.append(user)
            
            // Reload tableView
            self.tableView.reloadData()
            
        }
        
    }

}
