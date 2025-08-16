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
    var observations: String?
    var rating: Double
    var timestamp: Date
    
    @Relationship(inverse: \Location.poops) var location: Location
    
    init(location: Location, observations: String? = nil, rating: Double = 0, timestamp: Date) {
        self.location = location
        self.observations = observations
        self.rating = rating
        self.timestamp = timestamp
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
    
    static let mock = [
        Poop(location: Location(name: "Home", latitude: 1, longitude: 1), observations: "This is a good test poop", rating: 3.5, timestamp: Date.now),
        Poop(location: Location(name: "Home", latitude: 1, longitude: 1), observations: "This is a bad test poop", rating: 0.5, timestamp: Date.now),
        Poop(location: Location(name: "Home", latitude: 1, longitude: 1), observations: "This is a great test poop", rating: 5, timestamp: Date.now),
        Poop(location: Location(name: "Home", latitude: 1, longitude: 1), observations: "This is an average test poop", rating: 2.5, timestamp: Date.now),
    ]
}
