//
//  Location.swift
//  Fecalius
//
//  Created by Thiago Dias on 16/08/25.
//

import SwiftData
import Foundation
import MapKit

@Model
final class Location {
    var name: String
    var latitude: Double
    var longitude: Double
    
    var poops: [Poop]
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.poops = []
    }
    
    static var all = FetchDescriptor<Location>(sortBy: [SortDescriptor(\.name)])
    
    static func fetchOrCreate(
        name: String,
        coordinate: CLLocationCoordinate2D,
        context: ModelContext
    ) throws -> Location {

        // Create a FetchDescriptor to fetch locations by name
        let descriptor = FetchDescriptor<Location>(
            predicate: #Predicate<Location> { location in
                location.name == name
            }
        )
        
        // Fetch matching locations
        let results = try context.fetch(descriptor)
        
        print(name)
        print(results)
        
        if let existing = results.first {
            return existing
        }
        
        // Create a new Location if none exists
        let location = Location(
            name: name,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        context.insert(location)
        return location
    }


}
