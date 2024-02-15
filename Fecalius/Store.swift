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
    var observations: String?
    var rating: Double?
    var timestamp: Date
    
    var user: User
    
    @Relationship(deleteRule: .cascade, inverse: \Location.poops)
    var location: Location
    
    init(observations: String? = nil, rating: Double? = nil, timestamp: Date, user: User, location: Location) {
        self.observations = observations
        self.rating = rating
        self.timestamp = timestamp
        self.user = user
        self.location = location
    }
    
    static private let mockUser = User(username: "lutzzdias")
    static private let mockLocation = Location(name: "Home", latitude: 40.19199, longitude: 8.41587, user: mockUser)
    static let mock = [
        Poop(timestamp: Date.now, user: mockUser, location: mockLocation),
        Poop(timestamp: Date.now, user: mockUser, location: mockLocation),
        Poop(timestamp: Date.now, user: mockUser, location: mockLocation)
    ]
}

@Model
final class Location {
    var name: String
    var latitude: Double
    var longitude: Double
    
    var poops: [Poop]
    var user: User
    
    init(name: String, latitude: Double, longitude: Double, poops: [Poop] = [], user: User) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.poops = poops
        self.user = user
    }
}

@Model
final class User {
    var username: String
    var name: String?
    var bio: String?
    var pic: Data?
    
    @Relationship(deleteRule: .cascade, inverse: \Poop.user)
    var poops: [Poop]
    
    @Relationship(deleteRule: .cascade, inverse: \Location.user)
    var locations: [Location]
    
    init(username: String, name: String? = nil, bio: String? = nil, pic: Data? = nil, poops: [Poop] = [], locations: [Location] = []) {
        self.name = name
        self.username = username
        self.bio = bio
        self.pic = pic
        self.poops = poops
        self.locations = locations
    }
}
