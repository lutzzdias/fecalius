//
//  User.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 19/02/24.
//

import Foundation
import SwiftData

@Model
final class User {
    var username: String
    var name: String?
    var bio: String?
    var pic: Data?
    
    @Relationship(deleteRule: .cascade, inverse: \Poop.user)
    var poops: [Poop]
    
    init(username: String, name: String? = nil, bio: String? = nil, pic: Data? = nil, poops: [Poop] = []) {
        self.name = name
        self.username = username
        self.bio = bio
        self.pic = pic
        self.poops = poops
    }
}
