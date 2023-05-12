//
//  TwitterUser.swift
//  TwitterClone
//
//  Created by Lucas Newlands on 04/05/23.
//

import Foundation
import Firebase

struct TwitterUser: Codable {
    let id: String
    var displayName: String = ""
    var username: String = ""
    var followersCount: Int = 0
    var followingCount: Int = 0
    var createdOn: Date = Date()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false
    
    init(from user: User) {
        self.id = user.uid
    }
    
}
