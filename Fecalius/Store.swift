//
//  Item.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/02/24.
//

import Foundation
import SwiftData

@Model
final class Poop {
    var latitude: Double
    var longitude: Double
    var location: String
    var observations: String?
    var rating: Int?
    var timestamp: Date
    
    var user: User
    
    init(latitude: Double, longitude: Double, location: String, observations: String? = nil, rating: Int? = nil, timestamp: Date, user: User) {
        self.latitude = latitude
        self.longitude = longitude
        self.location = location
        self.observations = observations
        self.rating = rating
        self.timestamp = timestamp
        self.user = user
    }
    
    static var all = FetchDescriptor<Poop>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
    
    static private let mockUser = User(username: "lutzzdias")
    static let mock = [
        Poop(latitude: 1, longitude: 1, location: "Home", timestamp: Date.now, user: mockUser),
        Poop(latitude: 1, longitude: 1, location: "Home", timestamp: Date.now, user: mockUser),
        Poop(latitude: 1, longitude: 1, location: "Home", timestamp: Date.now, user: mockUser),
        Poop(latitude: 1, longitude: 1, location: "Home", timestamp: Date.now, user: mockUser),
    ]
}

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
