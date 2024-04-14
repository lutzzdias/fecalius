//
//  Location.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/04/24.
//

import Foundation
import SwiftUI
import SwiftData

// TODO: Count how many times a location has been registered and order locations based on most used
// TODO: Fix macro errors (???)

@Model
final class Location {
    var name: String
    var icon: String
    var color: Color
    
    init(name: String, icon: String = "mappin", color: Color = .accentColor) {
        self.name = name
        self.icon = icon
        self.color = color
    }
    
    static var all = FetchDescriptor<Location>()
    
}
