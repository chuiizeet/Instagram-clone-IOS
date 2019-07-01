//
//  Protocols.swift
//  InstaCopy
//
//  Created by imac on 6/29/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import Foundation

protocol UserProfileHeaderDelegate {
    
    func handleEditFollowTapped(for header: UserProfileHeader)
    func setUserStats(for header: UserProfileHeader)
    func handleFollowersTapped(for header: UserProfileHeader)
    func handleFollowingTapped(for header: UserProfileHeader)
    
}
