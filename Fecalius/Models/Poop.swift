//
//  Poop.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 19/02/24.
//

import Foundation
import SwiftData

@Model
final class Poop {
    var latitude: Double
    var longitude: Double
    var location: String
    var observations: String?
    var rating: Int
    var timestamp: Date
    
    var user: User
    
    init(latitude: Double, longitude: Double, location: String, observations: String? = nil, rating: Int = 0, timestamp: Date, user: User) {
        self.latitude = latitude
        self.longitude = longitude
        self.location = location
        self.observations = observations
        self.rating = rating
        self.timestamp = timestamp
        self.user = user
    }
    
    var date: String {
        self.timestamp.formatted(date: .abbreviated, time: .shortened)
    }
    
    static var all = FetchDescriptor<Poop>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
    
    public struct classifiedPoops {
        var sameDay: [Poop]
        var sameMonth: [Poop]
        var older: [Poop]
    }
    
    static func classified(_ all: [Poop]) -> classifiedPoops {
        var classified = classifiedPoops(sameDay: [], sameMonth: [], older: [])
        for poop in all {
            if (Calendar.current.isDate(poop.timestamp, inSameDayAs: Date.now)) { classified.sameDay.append(poop) }
            else if (Calendar.current.isDate(poop.timestamp, equalTo: Date.now, toGranularity: .month)) { classified.sameMonth.append(poop)}
            else { classified.older.append(poop) }
        }
        return classified
    }
    
    static private let mockUser = User(username: "lutzzdias")
    static let mock = [
        Poop(latitude: 1, longitude: 1, location: "ASDF", timestamp: Date.now, user: mockUser),
        Poop(latitude: 1, longitude: 1, location: "Home", timestamp: Date.now, user: mockUser),
        Poop(latitude: 1, longitude: 1, location: "Home", timestamp: Date.now, user: mockUser),
        Poop(latitude: 1, longitude: 1, location: "Home", timestamp: Date.now, user: mockUser),
    ]
}
