//
//  SearchVC.swift
//  InstaCopy
//
//  Created by imac on 6/21/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SearchUserCell"

class SearchVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        tableView.register(SearchUserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // Separator insets
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)

        configureNavController()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchUserCell
        
        
        return cell
        
    }
    
    // MARK: - Handlers
    
    func configureNavController() {
        navigationItem.title = "Explore"
    }

}
